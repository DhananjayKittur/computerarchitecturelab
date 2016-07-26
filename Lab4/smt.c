// ASSIGNMENT_4
//Bogati, Rajendra (376628)
//Kittur Gonibasappa, Dhananjaya Kumara(376629)
//Pokhrel, Niroj(376630)

#include <unistd.h>
#include <pthread.h>
#include <sched.h>
#include <sys/syscall.h>
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <immintrin.h>

//define the number here with the core assigned to you
//THE USAGE OF CPUID_SMT0 12 was not giving proper performance result compared to other cpuid<12. So, we have used 6.
#define CPUID_SMT0 6
#define CPUID_SMT1 (CPUID_SMT0+24)

//enable and disable your SMT thread
#define SMT1_ON 1

static int fibonacci(int n){
  if(n==0){
    return 0;
  }
  else{
    if(n==1)
      return 1;
    else
      return (fibonacci(n-1)+fibonacci(n-2));
  }
}

static void *tf_smt0(void *targ){
  cpu_set_t mask;
  CPU_ZERO(&mask);
  CPU_SET(CPUID_SMT0, &mask);
  pid_t tid = syscall(SYS_gettid); //glibc does not provide a wrapper for gettid
  sched_setaffinity(tid, sizeof(cpu_set_t), &mask);

  printf("Fibonacci number 40 = %d\n", fibonacci(40));

  pthread_exit(NULL);
}

static void *tf_smt1(void *targ){
  cpu_set_t mask;
  CPU_ZERO(&mask);
  CPU_SET(CPUID_SMT1, &mask);
  pid_t tid = syscall(SYS_gettid); //glibc does not provide a wrapper for gettid
  sched_setaffinity(tid, sizeof(cpu_set_t), &mask);
/************************************************DESCRIPTION_OF_THE_SOLUTION*********************************************
Goal of the assignment is to keep the tf_smt1 thread run along with tf_smt0 with Simultaneous Multithreading on Intel Xeon E5-2680v3 
processor. tf_smt0 is performing calculation of fibonacci series for number 40. 
Assignment is to come up with a code for the tf_smt1 which uses as much less resources as possible used in fibonacci.
given code had an infinite loop while(1){} in tf_smt1. 

1. The 02 optimization enabled in the compiler was optimizing the code inside our loop. The solution for this was volatile. By declaring 
the variables as volatile, it will prevent the compiler from optimizing the code. 

2. The objdump of the smt file showed the following assembly code for fibonacci:
	00000000004009c0 <fibonacci>:
  4009c0:       55                      push   %rbp
  4009c1:       53                      push   %rbx
  4009c2:       48 83 ec 08             sub    $0x8,%rsp
  4009c6:       85 ff                   test   %edi,%edi
  4009c8:       74 3a                   je     400a04 <fibonacci+0x44>
  4009ca:       83 ff 01                cmp    $0x1,%edi
  4009cd:       89 fb                   mov    %edi,%ebx
  4009cf:       74 37                   je     400a08 <fibonacci+0x48>
  4009d1:       31 ed                   xor    %ebp,%ebp
  4009d3:       eb 08                   jmp    4009dd <fibonacci+0x1d>
  4009d5:       0f 1f 00                nopl   (%rax)
  4009d8:       83 fb 01                cmp    $0x1,%ebx
  4009db:       74 1b                   je     4009f8 <fibonacci+0x38>
  4009dd:       8d 7b ff                lea    -0x1(%rbx),%edi
  4009e0:       e8 db ff ff ff          callq  4009c0 <fibonacci>
  4009e5:       01 c5                   add    %eax,%ebp
  4009e7:       83 eb 02                sub    $0x2,%ebx
  4009ea:       75 ec                   jne    4009d8 <fibonacci+0x18>
  4009ec:       48 83 c4 08             add    $0x8,%rsp
  4009f0:       89 e8                   mov    %ebp,%eax
  4009f2:       5b                      pop    %rbx
  4009f3:       5d                      pop    %rbp
  4009f4:       c3                      retq
  4009f5:       0f 1f 00                nopl   (%rax)
  4009f8:       83 c5 01                add    $0x1,%ebp
  4009fb:       48 83 c4 08             add    $0x8,%rsp
  4009ff:       89 e8                   mov    %ebp,%eax
  400a01:       5b                      pop    %rbx
  400a02:       5d                      pop    %rbp
  400a03:       c3                      retq
  400a04:       31 ed                   xor    %ebp,%ebp
  400a06:       eb e4                   jmp    4009ec <fibonacci+0x2c>
  400a08:       bd 01 00 00 00          mov    $0x1,%ebp
  400a0d:       eb dd                   jmp    4009ec <fibonacci+0x2c>
  400a0f:       90                      nop

As we can see from the assembly file above, fibonacci calculation has alot of jump instructions and some integer arithmetic operations. Thus, while 
implementing our code for the thread we want to prevent using these resources as much as possible so that fibonacci can work smoothly.

3. In the current scenario, for the infinite while loop ie while(1) produces the following assembly code which we observed using objdump as follows:
	400a57:       eb fe                   jmp    400a57 <tf_smt1+0x47>
Thus, this code is continuously running the jump instructions which is contending with the thread 0 for the branch and alu resources.

4. So, our main objective was not to use alu and jump instructions as much as possible. To achieve this we using floating point instructions which is
not currently used by fibonacci thread. Thus, while our thread is busy implementing the floating point operations fibonacci thread can continue to use
the resources alone. The objdump of our code is below
  400a88:       f3 0f 10 4c 24 0c       movss  0xc(%rsp),%xmm1
  400a8e:       f3 0f 5e c8             divss  %xmm0,%xmm1
  400a92:       f3 0f 11 4c 24 0c       movss  %xmm1,0xc(%rsp)
  400a98:       c7 44 24 10 00 00 80    movl   $0x3f800000,0x10(%rsp)
  400a9f:       3f
  400aa0:       f3 0f 10 4c 24 14       movss  0x14(%rsp),%xmm1
  400aa6:       f3 0f 5e c8             divss  %xmm0,%xmm1
  400aaa:       f3 0f 11 4c 24 14       movss  %xmm1,0x14(%rsp)
  400ab0:       f3 0f 10 4c 24 10       movss  0x10(%rsp),%xmm1
  400ab6:       f3 0f 5e c8             divss  %xmm0,%xmm1
  400aba:       f3 0f 11 4c 24 18       movss  %xmm1,0x18(%rsp)
  400ac0:       f3 0f 10 4c 24 18       movss  0x18(%rsp),%xmm1
  400ac6:       f3 0f 5e c8             divss  %xmm0,%xmm1
  400aca:       f3 0f 11 4c 24 1c       movss  %xmm1,0x1c(%rsp)
  400ad0:       f3 0f 10 4c 24 0c       movss  0xc(%rsp),%xmm1
  400ad6:       f3 0f 5e c8             divss  %xmm0,%xmm1
  400ada:       f3 0f 11 4c 24 0c       movss  %xmm1,0xc(%rsp)
  400ae0:       eb a6                   jmp    400a88 <tf_smt1+0x78>
As we can see in the above code that was generated from the objdump, we can see many floating point operations with divisions and fewer jump instructions.
This has allowed fibonacci thread to continue using the resources alone.

Conclusion:
By using the power of SMT we improved the performance of the code. SMT is a technique for improving efficiency of superscalar CPUs with hardware mutlithreading. It permits multiple indpendent threads of execution to better utilize the resources. This was proved in our implementation as the proper usage of the resources helped 
in improving the performance. 


***********************************************************************************************************************/
  volatile float vf32Var1 = 1.0, vf32Var2 = 1.0, vf32Var3=40.32, vf32Var4=23.10, vf32Var5=12.42;

  float f32Const = 5.32;
  while (1){
    // put your "background" code here
    // no sleeps are other code that schedules the thread out is allowed
    // inline assembly is not allowed
	vf32Var1 = vf32Var1 / f32Const;
	vf32Var2 = f32Const / f32Const;
	vf32Var3 = vf32Var3 / f32Const;
	vf32Var4 = vf32Var2 / f32Const;
	vf32Var5 = vf32Var4 / f32Const;
	vf32Var1 = vf32Var1 / f32Const;
  }
  //To be sure that the previous loop is not optimized away by the compiler
  printf("This should not appear\n");
  pthread_exit(NULL);
}

static int64_t diff(struct timespec start, struct timespec end)
{
  struct timespec temp;
  int64_t d;
  if ((end.tv_nsec-start.tv_nsec)<0) {
      temp.tv_sec = end.tv_sec-start.tv_sec-1;
      temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
  } else {
      temp.tv_sec = end.tv_sec-start.tv_sec;
      temp.tv_nsec = end.tv_nsec-start.tv_nsec;
  }
  d = temp.tv_sec*1000000000+temp.tv_nsec;
  return d;
}

int main ()
{
  pthread_t smt0, smt1;
  struct timespec start, end;

  clock_gettime(CLOCK_REALTIME,&start);

  pthread_create(&smt0, NULL, tf_smt0, NULL);
#if SMT1_ON
  pthread_create(&smt1, NULL, tf_smt1, NULL);
#endif

  pthread_join(smt0, NULL);
  clock_gettime(CLOCK_REALTIME,&end);
#if SMT1_ON
  pthread_cancel(smt1);
#endif

  double time = (double) diff(start,end)/1000000;
  printf("\nExecution time thread SMT0 \t %.3f ms\n", time);

  return 0;
}


