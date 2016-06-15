
hevc_idct16:     file format elf64-x86-64


Disassembly of section .init:

0000000000400620 <_init>:
  400620:	48 83 ec 08          	sub    $0x8,%rsp
  400624:	48 8b 05 cd 19 20 00 	mov    0x2019cd(%rip),%rax        # 601ff8 <_DYNAMIC+0x1e0>
  40062b:	48 85 c0             	test   %rax,%rax
  40062e:	74 05                	je     400635 <_init+0x15>
  400630:	e8 5b 00 00 00       	callq  400690 <__gmon_start__@plt>
  400635:	48 83 c4 08          	add    $0x8,%rsp
  400639:	c3                   	retq   

Disassembly of section .plt:

0000000000400640 <free@plt-0x10>:
  400640:	ff 35 c2 19 20 00    	pushq  0x2019c2(%rip)        # 602008 <_GLOBAL_OFFSET_TABLE_+0x8>
  400646:	ff 25 c4 19 20 00    	jmpq   *0x2019c4(%rip)        # 602010 <_GLOBAL_OFFSET_TABLE_+0x10>
  40064c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400650 <free@plt>:
  400650:	ff 25 c2 19 20 00    	jmpq   *0x2019c2(%rip)        # 602018 <_GLOBAL_OFFSET_TABLE_+0x18>
  400656:	68 00 00 00 00       	pushq  $0x0
  40065b:	e9 e0 ff ff ff       	jmpq   400640 <_init+0x20>

0000000000400660 <putchar@plt>:
  400660:	ff 25 ba 19 20 00    	jmpq   *0x2019ba(%rip)        # 602020 <_GLOBAL_OFFSET_TABLE_+0x20>
  400666:	68 01 00 00 00       	pushq  $0x1
  40066b:	e9 d0 ff ff ff       	jmpq   400640 <_init+0x20>

0000000000400670 <puts@plt>:
  400670:	ff 25 b2 19 20 00    	jmpq   *0x2019b2(%rip)        # 602028 <_GLOBAL_OFFSET_TABLE_+0x28>
  400676:	68 02 00 00 00       	pushq  $0x2
  40067b:	e9 c0 ff ff ff       	jmpq   400640 <_init+0x20>

0000000000400680 <__libc_start_main@plt>:
  400680:	ff 25 aa 19 20 00    	jmpq   *0x2019aa(%rip)        # 602030 <_GLOBAL_OFFSET_TABLE_+0x30>
  400686:	68 03 00 00 00       	pushq  $0x3
  40068b:	e9 b0 ff ff ff       	jmpq   400640 <_init+0x20>

0000000000400690 <__gmon_start__@plt>:
  400690:	ff 25 a2 19 20 00    	jmpq   *0x2019a2(%rip)        # 602038 <_GLOBAL_OFFSET_TABLE_+0x38>
  400696:	68 04 00 00 00       	pushq  $0x4
  40069b:	e9 a0 ff ff ff       	jmpq   400640 <_init+0x20>

00000000004006a0 <memalign@plt>:
  4006a0:	ff 25 9a 19 20 00    	jmpq   *0x20199a(%rip)        # 602040 <_GLOBAL_OFFSET_TABLE_+0x40>
  4006a6:	68 05 00 00 00       	pushq  $0x5
  4006ab:	e9 90 ff ff ff       	jmpq   400640 <_init+0x20>

00000000004006b0 <clock_gettime@plt>:
  4006b0:	ff 25 92 19 20 00    	jmpq   *0x201992(%rip)        # 602048 <_GLOBAL_OFFSET_TABLE_+0x48>
  4006b6:	68 06 00 00 00       	pushq  $0x6
  4006bb:	e9 80 ff ff ff       	jmpq   400640 <_init+0x20>

00000000004006c0 <__printf_chk@plt>:
  4006c0:	ff 25 8a 19 20 00    	jmpq   *0x20198a(%rip)        # 602050 <_GLOBAL_OFFSET_TABLE_+0x50>
  4006c6:	68 07 00 00 00       	pushq  $0x7
  4006cb:	e9 70 ff ff ff       	jmpq   400640 <_init+0x20>

00000000004006d0 <rand@plt>:
  4006d0:	ff 25 82 19 20 00    	jmpq   *0x201982(%rip)        # 602058 <_GLOBAL_OFFSET_TABLE_+0x58>
  4006d6:	68 08 00 00 00       	pushq  $0x8
  4006db:	e9 60 ff ff ff       	jmpq   400640 <_init+0x20>

Disassembly of section .text:

00000000004006e0 <main>:
  4006e0:	41 57                	push   %r15
  4006e2:	be 00 02 00 00       	mov    $0x200,%esi
  4006e7:	bf 10 00 00 00       	mov    $0x10,%edi
  4006ec:	41 56                	push   %r14
  4006ee:	41 55                	push   %r13
  4006f0:	45 31 ed             	xor    %r13d,%r13d
  4006f3:	41 54                	push   %r12
  4006f5:	55                   	push   %rbp
  4006f6:	53                   	push   %rbx
  4006f7:	48 83 ec 28          	sub    $0x28,%rsp
  4006fb:	e8 a0 ff ff ff       	callq  4006a0 <memalign@plt>
  400700:	be 00 02 00 00       	mov    $0x200,%esi
  400705:	bf 10 00 00 00       	mov    $0x10,%edi
  40070a:	48 89 c3             	mov    %rax,%rbx
  40070d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  400712:	e8 89 ff ff ff       	callq  4006a0 <memalign@plt>
  400717:	be 00 02 00 00       	mov    $0x200,%esi
  40071c:	bf 10 00 00 00       	mov    $0x10,%edi
  400721:	49 89 c6             	mov    %rax,%r14
  400724:	e8 77 ff ff ff       	callq  4006a0 <memalign@plt>
  400729:	be 00 02 00 00       	mov    $0x200,%esi
  40072e:	bf 10 00 00 00       	mov    $0x10,%edi
  400733:	49 89 c7             	mov    %rax,%r15
  400736:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  40073b:	e8 60 ff ff ff       	callq  4006a0 <memalign@plt>
  400740:	bf 84 16 40 00       	mov    $0x401684,%edi
  400745:	48 89 04 24          	mov    %rax,(%rsp)
  400749:	e8 22 ff ff ff       	callq  400670 <puts@plt>
  40074e:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
  400753:	49 89 de             	mov    %rbx,%r14
  400756:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40075d:	00 00 00 
  400760:	31 db                	xor    %ebx,%ebx
  400762:	4f 8d 24 2e          	lea    (%r14,%r13,1),%r12
  400766:	4b 8d 2c 2f          	lea    (%r15,%r13,1),%rbp
  40076a:	eb 44                	jmp    4007b0 <main+0xd0>
  40076c:	0f 1f 40 00          	nopl   0x0(%rax)
  400770:	e8 5b ff ff ff       	callq  4006d0 <rand@plt>
  400775:	89 c1                	mov    %eax,%ecx
  400777:	c1 f9 1f             	sar    $0x1f,%ecx
  40077a:	c1 e9 11             	shr    $0x11,%ecx
  40077d:	8d 14 08             	lea    (%rax,%rcx,1),%edx
  400780:	81 e2 ff 7f 00 00    	and    $0x7fff,%edx
  400786:	29 ca                	sub    %ecx,%edx
  400788:	66 41 89 14 1c       	mov    %dx,(%r12,%rbx,1)
  40078d:	66 89 54 1d 00       	mov    %dx,0x0(%rbp,%rbx,1)
  400792:	31 c0                	xor    %eax,%eax
  400794:	0f bf d2             	movswl %dx,%edx
  400797:	be 91 16 40 00       	mov    $0x401691,%esi
  40079c:	bf 01 00 00 00       	mov    $0x1,%edi
  4007a1:	48 83 c3 02          	add    $0x2,%rbx
  4007a5:	e8 16 ff ff ff       	callq  4006c0 <__printf_chk@plt>
  4007aa:	48 83 fb 20          	cmp    $0x20,%rbx
  4007ae:	74 20                	je     4007d0 <main+0xf0>
  4007b0:	e8 1b ff ff ff       	callq  4006d0 <rand@plt>
  4007b5:	a8 01                	test   $0x1,%al
  4007b7:	75 b7                	jne    400770 <main+0x90>
  4007b9:	e8 12 ff ff ff       	callq  4006d0 <rand@plt>
  4007be:	99                   	cltd   
  4007bf:	c1 ea 11             	shr    $0x11,%edx
  4007c2:	01 d0                	add    %edx,%eax
  4007c4:	25 ff 7f 00 00       	and    $0x7fff,%eax
  4007c9:	29 c2                	sub    %eax,%edx
  4007cb:	eb bb                	jmp    400788 <main+0xa8>
  4007cd:	0f 1f 00             	nopl   (%rax)
  4007d0:	bf 0a 00 00 00       	mov    $0xa,%edi
  4007d5:	49 83 c5 20          	add    $0x20,%r13
  4007d9:	e8 82 fe ff ff       	callq  400660 <putchar@plt>
  4007de:	49 81 fd 00 02 00 00 	cmp    $0x200,%r13
  4007e5:	0f 85 75 ff ff ff    	jne    400760 <main+0x80>
  4007eb:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
  4007f0:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  4007f5:	45 31 e4             	xor    %r12d,%r12d
  4007f8:	31 ed                	xor    %ebp,%ebp
  4007fa:	4c 89 f6             	mov    %r14,%rsi
  4007fd:	e8 be 07 00 00       	callq  400fc0 <idct16_scalar>
  400802:	48 8b 34 24          	mov    (%rsp),%rsi
  400806:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  40080b:	e8 f0 0c 00 00       	callq  401500 <idct16_simd>
  400810:	ba 95 16 40 00       	mov    $0x401695,%edx
  400815:	be a5 16 40 00       	mov    $0x4016a5,%esi
  40081a:	bf 01 00 00 00       	mov    $0x1,%edi
  40081f:	31 c0                	xor    %eax,%eax
  400821:	e8 9a fe ff ff       	callq  4006c0 <__printf_chk@plt>
  400826:	b8 01 00 00 00       	mov    $0x1,%eax
  40082b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400830:	48 8b 34 24          	mov    (%rsp),%rsi
  400834:	4f 8d 2c 34          	lea    (%r12,%r14,1),%r13
  400838:	31 db                	xor    %ebx,%ebx
  40083a:	4e 8d 3c 26          	lea    (%rsi,%r12,1),%r15
  40083e:	66 90                	xchg   %ax,%ax
  400840:	45 0f bf 44 5d 00    	movswl 0x0(%r13,%rbx,2),%r8d
  400846:	45 0f bf 0c 5f       	movswl (%r15,%rbx,2),%r9d
  40084b:	66 45 39 c8          	cmp    %r9w,%r8w
  40084f:	74 17                	je     400868 <main+0x188>
  400851:	89 e9                	mov    %ebp,%ecx
  400853:	89 da                	mov    %ebx,%edx
  400855:	be d8 16 40 00       	mov    $0x4016d8,%esi
  40085a:	bf 01 00 00 00       	mov    $0x1,%edi
  40085f:	31 c0                	xor    %eax,%eax
  400861:	e8 5a fe ff ff       	callq  4006c0 <__printf_chk@plt>
  400866:	31 c0                	xor    %eax,%eax
  400868:	48 83 c3 01          	add    $0x1,%rbx
  40086c:	48 83 fb 10          	cmp    $0x10,%rbx
  400870:	75 ce                	jne    400840 <main+0x160>
  400872:	83 c5 01             	add    $0x1,%ebp
  400875:	49 83 c4 20          	add    $0x20,%r12
  400879:	83 fd 10             	cmp    $0x10,%ebp
  40087c:	75 b2                	jne    400830 <main+0x150>
  40087e:	85 c0                	test   %eax,%eax
  400880:	74 0a                	je     40088c <main+0x1ac>
  400882:	bf b3 16 40 00       	mov    $0x4016b3,%edi
  400887:	e8 e4 fd ff ff       	callq  400670 <puts@plt>
  40088c:	49 8d ae 00 02 00 00 	lea    0x200(%r14),%rbp
  400893:	bf bc 16 40 00       	mov    $0x4016bc,%edi
  400898:	4c 89 f3             	mov    %r14,%rbx
  40089b:	e8 d0 fd ff ff       	callq  400670 <puts@plt>
  4008a0:	4c 8d 6b 20          	lea    0x20(%rbx),%r13
  4008a4:	0f 1f 40 00          	nopl   0x0(%rax)
  4008a8:	0f bf 13             	movswl (%rbx),%edx
  4008ab:	31 c0                	xor    %eax,%eax
  4008ad:	be 91 16 40 00       	mov    $0x401691,%esi
  4008b2:	bf 01 00 00 00       	mov    $0x1,%edi
  4008b7:	48 83 c3 02          	add    $0x2,%rbx
  4008bb:	e8 00 fe ff ff       	callq  4006c0 <__printf_chk@plt>
  4008c0:	4c 39 eb             	cmp    %r13,%rbx
  4008c3:	75 e3                	jne    4008a8 <main+0x1c8>
  4008c5:	bf 0a 00 00 00       	mov    $0xa,%edi
  4008ca:	e8 91 fd ff ff       	callq  400660 <putchar@plt>
  4008cf:	48 39 dd             	cmp    %rbx,%rbp
  4008d2:	75 cc                	jne    4008a0 <main+0x1c0>
  4008d4:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
  4008d9:	4c 89 f2             	mov    %r14,%rdx
  4008dc:	b9 ca 16 40 00       	mov    $0x4016ca,%ecx
  4008e1:	bf c0 0f 40 00       	mov    $0x400fc0,%edi
  4008e6:	48 89 ee             	mov    %rbp,%rsi
  4008e9:	e8 52 0c 00 00       	callq  401540 <benchmark>
  4008ee:	4c 8b 3c 24          	mov    (%rsp),%r15
  4008f2:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
  4008f7:	b9 a0 16 40 00       	mov    $0x4016a0,%ecx
  4008fc:	bf 00 15 40 00       	mov    $0x401500,%edi
  400901:	4c 89 fa             	mov    %r15,%rdx
  400904:	48 89 de             	mov    %rbx,%rsi
  400907:	e8 34 0c 00 00       	callq  401540 <benchmark>
  40090c:	48 89 ef             	mov    %rbp,%rdi
  40090f:	e8 3c fd ff ff       	callq  400650 <free@plt>
  400914:	4c 89 f7             	mov    %r14,%rdi
  400917:	e8 34 fd ff ff       	callq  400650 <free@plt>
  40091c:	48 89 df             	mov    %rbx,%rdi
  40091f:	e8 2c fd ff ff       	callq  400650 <free@plt>
  400924:	4c 89 ff             	mov    %r15,%rdi
  400927:	e8 24 fd ff ff       	callq  400650 <free@plt>
  40092c:	48 83 c4 28          	add    $0x28,%rsp
  400930:	31 c0                	xor    %eax,%eax
  400932:	5b                   	pop    %rbx
  400933:	5d                   	pop    %rbp
  400934:	41 5c                	pop    %r12
  400936:	41 5d                	pop    %r13
  400938:	41 5e                	pop    %r14
  40093a:	41 5f                	pop    %r15
  40093c:	c3                   	retq   

000000000040093d <_start>:
  40093d:	31 ed                	xor    %ebp,%ebp
  40093f:	49 89 d1             	mov    %rdx,%r9
  400942:	5e                   	pop    %rsi
  400943:	48 89 e2             	mov    %rsp,%rdx
  400946:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  40094a:	50                   	push   %rax
  40094b:	54                   	push   %rsp
  40094c:	49 c7 c0 60 16 40 00 	mov    $0x401660,%r8
  400953:	48 c7 c1 f0 15 40 00 	mov    $0x4015f0,%rcx
  40095a:	48 c7 c7 e0 06 40 00 	mov    $0x4006e0,%rdi
  400961:	e8 1a fd ff ff       	callq  400680 <__libc_start_main@plt>
  400966:	f4                   	hlt    
  400967:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40096e:	00 00 

0000000000400970 <deregister_tm_clones>:
  400970:	b8 77 20 60 00       	mov    $0x602077,%eax
  400975:	55                   	push   %rbp
  400976:	48 2d 70 20 60 00    	sub    $0x602070,%rax
  40097c:	48 83 f8 0e          	cmp    $0xe,%rax
  400980:	48 89 e5             	mov    %rsp,%rbp
  400983:	77 02                	ja     400987 <deregister_tm_clones+0x17>
  400985:	5d                   	pop    %rbp
  400986:	c3                   	retq   
  400987:	b8 00 00 00 00       	mov    $0x0,%eax
  40098c:	48 85 c0             	test   %rax,%rax
  40098f:	74 f4                	je     400985 <deregister_tm_clones+0x15>
  400991:	5d                   	pop    %rbp
  400992:	bf 70 20 60 00       	mov    $0x602070,%edi
  400997:	ff e0                	jmpq   *%rax
  400999:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004009a0 <register_tm_clones>:
  4009a0:	b8 70 20 60 00       	mov    $0x602070,%eax
  4009a5:	55                   	push   %rbp
  4009a6:	48 2d 70 20 60 00    	sub    $0x602070,%rax
  4009ac:	48 c1 f8 03          	sar    $0x3,%rax
  4009b0:	48 89 e5             	mov    %rsp,%rbp
  4009b3:	48 89 c2             	mov    %rax,%rdx
  4009b6:	48 c1 ea 3f          	shr    $0x3f,%rdx
  4009ba:	48 01 d0             	add    %rdx,%rax
  4009bd:	48 d1 f8             	sar    %rax
  4009c0:	75 02                	jne    4009c4 <register_tm_clones+0x24>
  4009c2:	5d                   	pop    %rbp
  4009c3:	c3                   	retq   
  4009c4:	ba 00 00 00 00       	mov    $0x0,%edx
  4009c9:	48 85 d2             	test   %rdx,%rdx
  4009cc:	74 f4                	je     4009c2 <register_tm_clones+0x22>
  4009ce:	5d                   	pop    %rbp
  4009cf:	48 89 c6             	mov    %rax,%rsi
  4009d2:	bf 70 20 60 00       	mov    $0x602070,%edi
  4009d7:	ff e2                	jmpq   *%rdx
  4009d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000004009e0 <__do_global_dtors_aux>:
  4009e0:	80 3d 89 16 20 00 00 	cmpb   $0x0,0x201689(%rip)        # 602070 <__TMC_END__>
  4009e7:	75 11                	jne    4009fa <__do_global_dtors_aux+0x1a>
  4009e9:	55                   	push   %rbp
  4009ea:	48 89 e5             	mov    %rsp,%rbp
  4009ed:	e8 7e ff ff ff       	callq  400970 <deregister_tm_clones>
  4009f2:	5d                   	pop    %rbp
  4009f3:	c6 05 76 16 20 00 01 	movb   $0x1,0x201676(%rip)        # 602070 <__TMC_END__>
  4009fa:	f3 c3                	repz retq 
  4009fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000400a00 <frame_dummy>:
  400a00:	48 83 3d 08 14 20 00 	cmpq   $0x0,0x201408(%rip)        # 601e10 <__JCR_END__>
  400a07:	00 
  400a08:	74 1e                	je     400a28 <frame_dummy+0x28>
  400a0a:	b8 00 00 00 00       	mov    $0x0,%eax
  400a0f:	48 85 c0             	test   %rax,%rax
  400a12:	74 14                	je     400a28 <frame_dummy+0x28>
  400a14:	55                   	push   %rbp
  400a15:	bf 10 1e 60 00       	mov    $0x601e10,%edi
  400a1a:	48 89 e5             	mov    %rsp,%rbp
  400a1d:	ff d0                	callq  *%rax
  400a1f:	5d                   	pop    %rbp
  400a20:	e9 7b ff ff ff       	jmpq   4009a0 <register_tm_clones>
  400a25:	0f 1f 00             	nopl   (%rax)
  400a28:	e9 73 ff ff ff       	jmpq   4009a0 <register_tm_clones>
  400a2d:	0f 1f 00             	nopl   (%rax)

0000000000400a30 <partialButterflyInverse16>:
  400a30:	41 57                	push   %r15
  400a32:	48 8d 47 20          	lea    0x20(%rdi),%rax
  400a36:	8d 4a ff             	lea    -0x1(%rdx),%ecx
  400a39:	41 56                	push   %r14
  400a3b:	41 55                	push   %r13
  400a3d:	41 54                	push   %r12
  400a3f:	55                   	push   %rbp
  400a40:	53                   	push   %rbx
  400a41:	89 d3                	mov    %edx,%ebx
  400a43:	ba 01 00 00 00       	mov    $0x1,%edx
  400a48:	d3 e2                	shl    %cl,%edx
  400a4a:	89 d9                	mov    %ebx,%ecx
  400a4c:	48 89 44 24 a0       	mov    %rax,-0x60(%rsp)
  400a51:	48 8d 44 24 d8       	lea    -0x28(%rsp),%rax
  400a56:	48 83 c0 1c          	add    $0x1c,%rax
  400a5a:	48 89 44 24 a8       	mov    %rax,-0x58(%rsp)
  400a5f:	48 8d 44 24 b8       	lea    -0x48(%rsp),%rax
  400a64:	48 83 c0 1c          	add    $0x1c,%rax
  400a68:	48 89 44 24 b0       	mov    %rax,-0x50(%rsp)
  400a6d:	89 d0                	mov    %edx,%eax
  400a6f:	90                   	nop
  400a70:	0f bf 6f 20          	movswl 0x20(%rdi),%ebp
  400a74:	44 0f bf 57 60       	movswl 0x60(%rdi),%r10d
  400a79:	41 bd 5a 00 00 00    	mov    $0x5a,%r13d
  400a7f:	44 0f bf 8f a0 00 00 	movswl 0xa0(%rdi),%r9d
  400a86:	00 
  400a87:	41 be 57 00 00 00    	mov    $0x57,%r14d
  400a8d:	0f bf 9f e0 00 00 00 	movswl 0xe0(%rdi),%ebx
  400a94:	44 0f bf 87 20 01 00 	movswl 0x120(%rdi),%r8d
  400a9b:	00 
  400a9c:	44 0f bf a7 60 01 00 	movswl 0x160(%rdi),%r12d
  400aa3:	00 
  400aa4:	44 0f bf 9f a0 01 00 	movswl 0x1a0(%rdi),%r11d
  400aab:	00 
  400aac:	0f bf 97 e0 01 00 00 	movswl 0x1e0(%rdi),%edx
  400ab3:	41 89 ef             	mov    %ebp,%r15d
  400ab6:	45 0f af fd          	imul   %r13d,%r15d
  400aba:	45 89 d5             	mov    %r10d,%r13d
  400abd:	45 0f af ee          	imul   %r14d,%r13d
  400ac1:	41 89 de             	mov    %ebx,%r14d
  400ac4:	45 01 ef             	add    %r13d,%r15d
  400ac7:	47 8d 2c 89          	lea    (%r9,%r9,4),%r13d
  400acb:	41 c1 e5 04          	shl    $0x4,%r13d
  400acf:	45 01 ef             	add    %r13d,%r15d
  400ad2:	41 bd 46 00 00 00    	mov    $0x46,%r13d
  400ad8:	45 0f af f5          	imul   %r13d,%r14d
  400adc:	41 bd 39 00 00 00    	mov    $0x39,%r13d
  400ae2:	45 01 f7             	add    %r14d,%r15d
  400ae5:	45 89 c6             	mov    %r8d,%r14d
  400ae8:	45 0f af f5          	imul   %r13d,%r14d
  400aec:	41 bd 2b 00 00 00    	mov    $0x2b,%r13d
  400af2:	45 01 f7             	add    %r14d,%r15d
  400af5:	45 89 e6             	mov    %r12d,%r14d
  400af8:	45 0f af f5          	imul   %r13d,%r14d
  400afc:	47 8d 2c 9b          	lea    (%r11,%r11,4),%r13d
  400b00:	45 01 f7             	add    %r14d,%r15d
  400b03:	47 8d 74 ad 00       	lea    0x0(%r13,%r13,4),%r14d
  400b08:	45 01 f7             	add    %r14d,%r15d
  400b0b:	44 8d 34 d2          	lea    (%rdx,%rdx,8),%r14d
  400b0f:	45 01 fe             	add    %r15d,%r14d
  400b12:	41 89 ef             	mov    %ebp,%r15d
  400b15:	44 89 74 24 d8       	mov    %r14d,-0x28(%rsp)
  400b1a:	41 be 57 00 00 00    	mov    $0x57,%r14d
  400b20:	45 0f af fe          	imul   %r14d,%r15d
  400b24:	45 6b f2 39          	imul   $0x39,%r10d,%r14d
  400b28:	45 01 fe             	add    %r15d,%r14d
  400b2b:	47 8d 3c c9          	lea    (%r9,%r9,8),%r15d
  400b2f:	45 01 fe             	add    %r15d,%r14d
  400b32:	44 6b fb d5          	imul   $0xffffffd5,%ebx,%r15d
  400b36:	45 01 fe             	add    %r15d,%r14d
  400b39:	47 8d 3c 80          	lea    (%r8,%r8,4),%r15d
  400b3d:	41 c1 e7 04          	shl    $0x4,%r15d
  400b41:	45 29 fe             	sub    %r15d,%r14d
  400b44:	45 6b fc a6          	imul   $0xffffffa6,%r12d,%r15d
  400b48:	45 01 fe             	add    %r15d,%r14d
  400b4b:	45 6b fb ba          	imul   $0xffffffba,%r11d,%r15d
  400b4f:	45 01 fe             	add    %r15d,%r14d
  400b52:	44 6b fa e7          	imul   $0xffffffe7,%edx,%r15d
  400b56:	45 01 fe             	add    %r15d,%r14d
  400b59:	44 8d 7c ad 00       	lea    0x0(%rbp,%rbp,4),%r15d
  400b5e:	44 89 74 24 dc       	mov    %r14d,-0x24(%rsp)
  400b63:	47 8d 34 d2          	lea    (%r10,%r10,8),%r14d
  400b67:	44 89 7c 24 98       	mov    %r15d,-0x68(%rsp)
  400b6c:	41 c1 e7 04          	shl    $0x4,%r15d
  400b70:	45 01 f7             	add    %r14d,%r15d
  400b73:	45 6b f1 ba          	imul   $0xffffffba,%r9d,%r14d
  400b77:	45 01 f7             	add    %r14d,%r15d
  400b7a:	44 6b f3 a9          	imul   $0xffffffa9,%ebx,%r14d
  400b7e:	45 01 f7             	add    %r14d,%r15d
  400b81:	45 6b f0 e7          	imul   $0xffffffe7,%r8d,%r14d
  400b85:	41 c1 e5 04          	shl    $0x4,%r13d
  400b89:	45 01 f7             	add    %r14d,%r15d
  400b8c:	45 6b f4 39          	imul   $0x39,%r12d,%r14d
  400b90:	45 01 f7             	add    %r14d,%r15d
  400b93:	45 6b f3 5a          	imul   $0x5a,%r11d,%r14d
  400b97:	45 01 f7             	add    %r14d,%r15d
  400b9a:	44 6b f2 2b          	imul   $0x2b,%edx,%r14d
  400b9e:	45 01 fe             	add    %r15d,%r14d
  400ba1:	41 89 ef             	mov    %ebp,%r15d
  400ba4:	44 89 74 24 e0       	mov    %r14d,-0x20(%rsp)
  400ba9:	41 be 46 00 00 00    	mov    $0x46,%r14d
  400baf:	45 0f af fe          	imul   %r14d,%r15d
  400bb3:	45 6b f2 d5          	imul   $0xffffffd5,%r10d,%r14d
  400bb7:	45 01 f7             	add    %r14d,%r15d
  400bba:	45 6b f1 a9          	imul   $0xffffffa9,%r9d,%r14d
  400bbe:	45 01 f7             	add    %r14d,%r15d
  400bc1:	44 8d 34 db          	lea    (%rbx,%rbx,8),%r14d
  400bc5:	45 01 f7             	add    %r14d,%r15d
  400bc8:	45 6b f0 5a          	imul   $0x5a,%r8d,%r14d
  400bcc:	45 01 f7             	add    %r14d,%r15d
  400bcf:	47 8d 34 a4          	lea    (%r12,%r12,4),%r14d
  400bd3:	44 89 74 24 9c       	mov    %r14d,-0x64(%rsp)
  400bd8:	47 8d 34 b6          	lea    (%r14,%r14,4),%r14d
  400bdc:	45 01 fe             	add    %r15d,%r14d
  400bdf:	41 89 d7             	mov    %edx,%r15d
  400be2:	45 29 ee             	sub    %r13d,%r14d
  400be5:	41 bd c7 ff ff ff    	mov    $0xffffffc7,%r13d
  400beb:	45 0f af fd          	imul   %r13d,%r15d
  400bef:	41 89 ed             	mov    %ebp,%r13d
  400bf2:	45 01 fe             	add    %r15d,%r14d
  400bf5:	41 bf e7 ff ff ff    	mov    $0xffffffe7,%r15d
  400bfb:	44 89 74 24 e4       	mov    %r14d,-0x1c(%rsp)
  400c00:	41 be 39 00 00 00    	mov    $0x39,%r14d
  400c06:	45 0f af ee          	imul   %r14d,%r13d
  400c0a:	47 8d 34 92          	lea    (%r10,%r10,4),%r14d
  400c0e:	41 c1 e6 04          	shl    $0x4,%r14d
  400c12:	45 29 f5             	sub    %r14d,%r13d
  400c15:	45 89 ce             	mov    %r9d,%r14d
  400c18:	45 0f af f7          	imul   %r15d,%r14d
  400c1c:	41 bf 5a 00 00 00    	mov    $0x5a,%r15d
  400c22:	45 01 f5             	add    %r14d,%r13d
  400c25:	41 89 de             	mov    %ebx,%r14d
  400c28:	45 0f af f7          	imul   %r15d,%r14d
  400c2c:	41 bf a9 ff ff ff    	mov    $0xffffffa9,%r15d
  400c32:	45 01 f5             	add    %r14d,%r13d
  400c35:	47 8d 34 c0          	lea    (%r8,%r8,8),%r14d
  400c39:	45 29 f5             	sub    %r14d,%r13d
  400c3c:	45 89 e6             	mov    %r12d,%r14d
  400c3f:	45 0f af f7          	imul   %r15d,%r14d
  400c43:	41 bf 2b 00 00 00    	mov    $0x2b,%r15d
  400c49:	45 01 f5             	add    %r14d,%r13d
  400c4c:	45 89 de             	mov    %r11d,%r14d
  400c4f:	45 0f af f7          	imul   %r15d,%r14d
  400c53:	41 bf 46 00 00 00    	mov    $0x46,%r15d
  400c59:	45 01 f5             	add    %r14d,%r13d
  400c5c:	41 89 d6             	mov    %edx,%r14d
  400c5f:	45 0f af f7          	imul   %r15d,%r14d
  400c63:	41 bf a6 ff ff ff    	mov    $0xffffffa6,%r15d
  400c69:	45 01 f5             	add    %r14d,%r13d
  400c6c:	41 89 ee             	mov    %ebp,%r14d
  400c6f:	8d 6c ed 00          	lea    0x0(%rbp,%rbp,8),%ebp
  400c73:	44 89 6c 24 e8       	mov    %r13d,-0x18(%rsp)
  400c78:	41 bd 2b 00 00 00    	mov    $0x2b,%r13d
  400c7e:	45 0f af f5          	imul   %r13d,%r14d
  400c82:	45 89 d5             	mov    %r10d,%r13d
  400c85:	45 0f af ef          	imul   %r15d,%r13d
  400c89:	41 bf 39 00 00 00    	mov    $0x39,%r15d
  400c8f:	45 01 ee             	add    %r13d,%r14d
  400c92:	45 89 cd             	mov    %r9d,%r13d
  400c95:	45 0f af ef          	imul   %r15d,%r13d
  400c99:	45 01 ee             	add    %r13d,%r14d
  400c9c:	44 8d 2c 9b          	lea    (%rbx,%rbx,4),%r13d
  400ca0:	47 8d 7c ad 00       	lea    0x0(%r13,%r13,4),%r15d
  400ca5:	41 c1 e5 04          	shl    $0x4,%r13d
  400ca9:	45 01 fe             	add    %r15d,%r14d
  400cac:	45 6b f8 a9          	imul   $0xffffffa9,%r8d,%r15d
  400cb0:	45 01 fe             	add    %r15d,%r14d
  400cb3:	45 6b fc 46          	imul   $0x46,%r12d,%r15d
  400cb7:	45 01 fe             	add    %r15d,%r14d
  400cba:	47 8d 3c db          	lea    (%r11,%r11,8),%r15d
  400cbe:	45 01 fe             	add    %r15d,%r14d
  400cc1:	44 8d 3c 92          	lea    (%rdx,%rdx,4),%r15d
  400cc5:	41 c1 e7 04          	shl    $0x4,%r15d
  400cc9:	45 29 fe             	sub    %r15d,%r14d
  400ccc:	44 8b 7c 24 98       	mov    -0x68(%rsp),%r15d
  400cd1:	44 89 74 24 ec       	mov    %r14d,-0x14(%rsp)
  400cd6:	45 6b f2 ba          	imul   $0xffffffba,%r10d,%r14d
  400cda:	47 8d 3c bf          	lea    (%r15,%r15,4),%r15d
  400cde:	45 01 f7             	add    %r14d,%r15d
  400ce1:	45 6b f1 5a          	imul   $0x5a,%r9d,%r14d
  400ce5:	45 01 fe             	add    %r15d,%r14d
  400ce8:	45 89 c7             	mov    %r8d,%r15d
  400ceb:	45 29 ee             	sub    %r13d,%r14d
  400cee:	41 bd 2b 00 00 00    	mov    $0x2b,%r13d
  400cf4:	45 0f af fd          	imul   %r13d,%r15d
  400cf8:	41 bd 57 00 00 00    	mov    $0x57,%r13d
  400cfe:	45 01 fe             	add    %r15d,%r14d
  400d01:	47 8d 3c e4          	lea    (%r12,%r12,8),%r15d
  400d05:	45 89 dc             	mov    %r11d,%r12d
  400d08:	45 01 fe             	add    %r15d,%r14d
  400d0b:	41 bf c7 ff ff ff    	mov    $0xffffffc7,%r15d
  400d11:	45 0f af e7          	imul   %r15d,%r12d
  400d15:	41 bf 2b 00 00 00    	mov    $0x2b,%r15d
  400d1b:	45 0f af cf          	imul   %r15d,%r9d
  400d1f:	41 bf 4b 00 00 00    	mov    $0x4b,%r15d
  400d25:	45 01 e6             	add    %r12d,%r14d
  400d28:	41 89 d4             	mov    %edx,%r12d
  400d2b:	45 0f af e5          	imul   %r13d,%r12d
  400d2f:	41 bd a6 ff ff ff    	mov    $0xffffffa6,%r13d
  400d35:	45 01 f4             	add    %r14d,%r12d
  400d38:	41 be e7 ff ff ff    	mov    $0xffffffe7,%r14d
  400d3e:	45 0f af d6          	imul   %r14d,%r10d
  400d42:	44 89 64 24 f0       	mov    %r12d,-0x10(%rsp)
  400d47:	41 bc 57 00 00 00    	mov    $0x57,%r12d
  400d4d:	41 be 59 00 00 00    	mov    $0x59,%r14d
  400d53:	41 01 ea             	add    %ebp,%r10d
  400d56:	bd 46 00 00 00       	mov    $0x46,%ebp
  400d5b:	45 01 d1             	add    %r10d,%r9d
  400d5e:	41 ba c7 ff ff ff    	mov    $0xffffffc7,%r10d
  400d64:	41 0f af da          	imul   %r10d,%ebx
  400d68:	44 01 cb             	add    %r9d,%ebx
  400d6b:	44 8b 4c 24 9c       	mov    -0x64(%rsp),%r9d
  400d70:	44 0f af c5          	imul   %ebp,%r8d
  400d74:	bd 32 00 00 00       	mov    $0x32,%ebp
  400d79:	45 0f af dc          	imul   %r12d,%r11d
  400d7d:	41 bc 4b 00 00 00    	mov    $0x4b,%r12d
  400d83:	41 c1 e1 04          	shl    $0x4,%r9d
  400d87:	41 01 d8             	add    %ebx,%r8d
  400d8a:	45 29 c8             	sub    %r9d,%r8d
  400d8d:	44 0f bf 8f c0 00 00 	movswl 0xc0(%rdi),%r9d
  400d94:	00 
  400d95:	45 01 d8             	add    %r11d,%r8d
  400d98:	44 0f bf 5f 40       	movswl 0x40(%rdi),%r11d
  400d9d:	41 0f af d5          	imul   %r13d,%edx
  400da1:	41 bd a7 ff ff ff    	mov    $0xffffffa7,%r13d
  400da7:	45 89 ca             	mov    %r9d,%r10d
  400daa:	44 01 c2             	add    %r8d,%edx
  400dad:	44 89 db             	mov    %r11d,%ebx
  400db0:	44 0f bf 87 40 01 00 	movswl 0x140(%rdi),%r8d
  400db7:	00 
  400db8:	41 0f af de          	imul   %r14d,%ebx
  400dbc:	89 54 24 f4          	mov    %edx,-0xc(%rsp)
  400dc0:	0f bf 97 c0 01 00 00 	movswl 0x1c0(%rdi),%edx
  400dc7:	45 0f af d7          	imul   %r15d,%r10d
  400dcb:	41 be ce ff ff ff    	mov    $0xffffffce,%r14d
  400dd1:	41 bf 32 00 00 00    	mov    $0x32,%r15d
  400dd7:	41 01 da             	add    %ebx,%r10d
  400dda:	44 89 c3             	mov    %r8d,%ebx
  400ddd:	0f af dd             	imul   %ebp,%ebx
  400de0:	43 8d 2c c9          	lea    (%r9,%r9,8),%ebp
  400de4:	01 ed                	add    %ebp,%ebp
  400de6:	41 01 da             	add    %ebx,%r10d
  400de9:	8d 1c d2             	lea    (%rdx,%rdx,8),%ebx
  400dec:	45 8d 14 5a          	lea    (%r10,%rbx,2),%r10d
  400df0:	44 89 db             	mov    %r11d,%ebx
  400df3:	41 0f af dc          	imul   %r12d,%ebx
  400df7:	45 89 dc             	mov    %r11d,%r12d
  400dfa:	47 8d 1c db          	lea    (%r11,%r11,8),%r11d
  400dfe:	45 0f af e7          	imul   %r15d,%r12d
  400e02:	41 bf ce ff ff ff    	mov    $0xffffffce,%r15d
  400e08:	29 eb                	sub    %ebp,%ebx
  400e0a:	44 89 c5             	mov    %r8d,%ebp
  400e0d:	41 0f af ed          	imul   %r13d,%ebp
  400e11:	41 bd a7 ff ff ff    	mov    $0xffffffa7,%r13d
  400e17:	01 eb                	add    %ebp,%ebx
  400e19:	89 d5                	mov    %edx,%ebp
  400e1b:	41 0f af ee          	imul   %r14d,%ebp
  400e1f:	41 be 4b 00 00 00    	mov    $0x4b,%r14d
  400e25:	01 eb                	add    %ebp,%ebx
  400e27:	44 89 cd             	mov    %r9d,%ebp
  400e2a:	41 0f af ed          	imul   %r13d,%ebp
  400e2e:	41 bd 53 00 00 00    	mov    $0x53,%r13d
  400e34:	45 0f af cf          	imul   %r15d,%r9d
  400e38:	41 bf ad ff ff ff    	mov    $0xffffffad,%r15d
  400e3e:	44 01 e5             	add    %r12d,%ebp
  400e41:	47 8d 24 c0          	lea    (%r8,%r8,8),%r12d
  400e45:	47 8d 1c 59          	lea    (%r9,%r11,2),%r11d
  400e49:	41 b9 4b 00 00 00    	mov    $0x4b,%r9d
  400e4f:	46 8d 64 65 00       	lea    0x0(%rbp,%r12,2),%r12d
  400e54:	89 d5                	mov    %edx,%ebp
  400e56:	41 0f af ee          	imul   %r14d,%ebp
  400e5a:	44 0f bf b7 00 01 00 	movswl 0x100(%rdi),%r14d
  400e61:	00 
  400e62:	45 0f af c1          	imul   %r9d,%r8d
  400e66:	44 0f bf 8f 80 00 00 	movswl 0x80(%rdi),%r9d
  400e6d:	00 
  400e6e:	44 01 e5             	add    %r12d,%ebp
  400e71:	41 bc a7 ff ff ff    	mov    $0xffffffa7,%r12d
  400e77:	41 0f af d4          	imul   %r12d,%edx
  400e7b:	45 01 c3             	add    %r8d,%r11d
  400e7e:	44 0f bf 87 80 01 00 	movswl 0x180(%rdi),%r8d
  400e85:	00 
  400e86:	41 01 d3             	add    %edx,%r11d
  400e89:	44 89 ca             	mov    %r9d,%edx
  400e8c:	47 8d 0c c9          	lea    (%r9,%r9,8),%r9d
  400e90:	41 0f af d5          	imul   %r13d,%edx
  400e94:	47 8d 24 c0          	lea    (%r8,%r8,8),%r12d
  400e98:	45 89 f5             	mov    %r14d,%r13d
  400e9b:	46 8d 24 a2          	lea    (%rdx,%r12,4),%r12d
  400e9f:	0f bf 17             	movswl (%rdi),%edx
  400ea2:	c1 e2 06             	shl    $0x6,%edx
  400ea5:	41 c1 e5 06          	shl    $0x6,%r13d
  400ea9:	41 c1 e6 06          	shl    $0x6,%r14d
  400ead:	45 0f af c7          	imul   %r15d,%r8d
  400eb1:	41 01 d5             	add    %edx,%r13d
  400eb4:	44 29 f2             	sub    %r14d,%edx
  400eb7:	41 89 d6             	mov    %edx,%r14d
  400eba:	47 8d 0c 88          	lea    (%r8,%r9,4),%r9d
  400ebe:	47 8d 04 2c          	lea    (%r12,%r13,1),%r8d
  400ec2:	45 29 e5             	sub    %r12d,%r13d
  400ec5:	45 89 ec             	mov    %r13d,%r12d
  400ec8:	45 01 dd             	add    %r11d,%r13d
  400ecb:	45 29 ce             	sub    %r9d,%r14d
  400ece:	45 29 dc             	sub    %r11d,%r12d
  400ed1:	41 01 d1             	add    %edx,%r9d
  400ed4:	44 89 64 24 c8       	mov    %r12d,-0x38(%rsp)
  400ed9:	45 8d 24 19          	lea    (%r9,%rbx,1),%r12d
  400edd:	43 8d 14 10          	lea    (%r8,%r10,1),%edx
  400ee1:	41 29 d9             	sub    %ebx,%r9d
  400ee4:	45 29 d0             	sub    %r10d,%r8d
  400ee7:	45 31 d2             	xor    %r10d,%r10d
  400eea:	44 89 64 24 bc       	mov    %r12d,-0x44(%rsp)
  400eef:	45 89 f4             	mov    %r14d,%r12d
  400ef2:	89 54 24 b8          	mov    %edx,-0x48(%rsp)
  400ef6:	41 29 ec             	sub    %ebp,%r12d
  400ef9:	44 01 f5             	add    %r14d,%ebp
  400efc:	89 6c 24 c0          	mov    %ebp,-0x40(%rsp)
  400f00:	44 89 64 24 cc       	mov    %r12d,-0x34(%rsp)
  400f05:	44 89 4c 24 d0       	mov    %r9d,-0x30(%rsp)
  400f0a:	44 89 6c 24 c4       	mov    %r13d,-0x3c(%rsp)
  400f0f:	45 31 c9             	xor    %r9d,%r9d
  400f12:	44 89 44 24 d4       	mov    %r8d,-0x2c(%rsp)
  400f17:	48 8b 5c 24 a8       	mov    -0x58(%rsp),%rbx
  400f1c:	48 8b 6c 24 b0       	mov    -0x50(%rsp),%rbp
  400f21:	eb 0f                	jmp    400f32 <partialButterflyInverse16+0x502>
  400f23:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400f28:	42 8b 54 4c b8       	mov    -0x48(%rsp,%r9,2),%edx
  400f2d:	46 8b 44 15 00       	mov    0x0(%rbp,%r10,1),%r8d
  400f32:	42 03 54 4c d8       	add    -0x28(%rsp,%r9,2),%edx
  400f37:	41 bb 00 80 ff ff    	mov    $0xffff8000,%r11d
  400f3d:	01 c2                	add    %eax,%edx
  400f3f:	d3 fa                	sar    %cl,%edx
  400f41:	81 fa 00 80 ff ff    	cmp    $0xffff8000,%edx
  400f47:	7c 10                	jl     400f59 <partialButterflyInverse16+0x529>
  400f49:	81 fa ff 7f 00 00    	cmp    $0x7fff,%edx
  400f4f:	41 bb ff 7f 00 00    	mov    $0x7fff,%r11d
  400f55:	44 0f 4e da          	cmovle %edx,%r11d
  400f59:	46 2b 04 13          	sub    (%rbx,%r10,1),%r8d
  400f5d:	66 46 89 1c 0e       	mov    %r11w,(%rsi,%r9,1)
  400f62:	ba 00 80 ff ff       	mov    $0xffff8000,%edx
  400f67:	41 01 c0             	add    %eax,%r8d
  400f6a:	41 d3 f8             	sar    %cl,%r8d
  400f6d:	41 81 f8 00 80 ff ff 	cmp    $0xffff8000,%r8d
  400f74:	7c 10                	jl     400f86 <partialButterflyInverse16+0x556>
  400f76:	41 81 f8 ff 7f 00 00 	cmp    $0x7fff,%r8d
  400f7d:	ba ff 7f 00 00       	mov    $0x7fff,%edx
  400f82:	41 0f 4e d0          	cmovle %r8d,%edx
  400f86:	49 83 ea 04          	sub    $0x4,%r10
  400f8a:	66 42 89 54 0e 10    	mov    %dx,0x10(%rsi,%r9,1)
  400f90:	49 83 c1 02          	add    $0x2,%r9
  400f94:	49 83 fa e0          	cmp    $0xffffffffffffffe0,%r10
  400f98:	75 8e                	jne    400f28 <partialButterflyInverse16+0x4f8>
  400f9a:	48 83 c7 02          	add    $0x2,%rdi
  400f9e:	48 83 c6 20          	add    $0x20,%rsi
  400fa2:	48 3b 7c 24 a0       	cmp    -0x60(%rsp),%rdi
  400fa7:	0f 85 c3 fa ff ff    	jne    400a70 <partialButterflyInverse16+0x40>
  400fad:	5b                   	pop    %rbx
  400fae:	5d                   	pop    %rbp
  400faf:	41 5c                	pop    %r12
  400fb1:	41 5d                	pop    %r13
  400fb3:	41 5e                	pop    %r14
  400fb5:	41 5f                	pop    %r15
  400fb7:	c3                   	retq   
  400fb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  400fbf:	00 

0000000000400fc0 <idct16_scalar>:
  400fc0:	53                   	push   %rbx
  400fc1:	ba 07 00 00 00       	mov    $0x7,%edx
  400fc6:	48 89 f3             	mov    %rsi,%rbx
  400fc9:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
  400fd0:	48 89 e6             	mov    %rsp,%rsi
  400fd3:	e8 58 fa ff ff       	callq  400a30 <partialButterflyInverse16>
  400fd8:	48 89 de             	mov    %rbx,%rsi
  400fdb:	48 89 e7             	mov    %rsp,%rdi
  400fde:	ba 0c 00 00 00       	mov    $0xc,%edx
  400fe3:	e8 48 fa ff ff       	callq  400a30 <partialButterflyInverse16>
  400fe8:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
  400fef:	5b                   	pop    %rbx
  400ff0:	c3                   	retq   
  400ff1:	66 66 66 66 66 66 2e 	data32 data32 data32 data32 data32 nopw %cs:0x0(%rax,%rax,1)
  400ff8:	0f 1f 84 00 00 00 00 
  400fff:	00 

0000000000401000 <partialButterflyInverse16_simd>:
  401000:	55                   	push   %rbp
  401001:	8d 4a ff             	lea    -0x1(%rdx),%ecx
  401004:	b8 01 00 00 00       	mov    $0x1,%eax
  401009:	4c 8d 5f 20          	lea    0x20(%rdi),%r11
  40100d:	66 44 0f 6f 3d ea 06 	movdqa 0x6ea(%rip),%xmm15        # 401700 <_IO_stdin_used+0x90>
  401014:	00 00 
  401016:	53                   	push   %rbx
  401017:	d3 e0                	shl    %cl,%eax
  401019:	49 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%r10
  401020:	ff ff ff 
  401023:	66 44 0f 6f 35 e4 06 	movdqa 0x6e4(%rip),%xmm14        # 401710 <_IO_stdin_used+0xa0>
  40102a:	00 00 
  40102c:	89 54 24 98          	mov    %edx,-0x68(%rsp)
  401030:	66 0f 6e 54 24 98    	movd   -0x68(%rsp),%xmm2
  401036:	89 44 24 98          	mov    %eax,-0x68(%rsp)
  40103a:	66 0f 6e 64 24 98    	movd   -0x68(%rsp),%xmm4
  401040:	66 44 0f 6f 2d d7 06 	movdqa 0x6d7(%rip),%xmm13        # 401720 <_IO_stdin_used+0xb0>
  401047:	00 00 
  401049:	66 0f 70 dc 00       	pshufd $0x0,%xmm4,%xmm3
  40104e:	66 44 0f 6f 25 d9 06 	movdqa 0x6d9(%rip),%xmm12        # 401730 <_IO_stdin_used+0xc0>
  401055:	00 00 
  401057:	66 44 0f 6f 1d e0 06 	movdqa 0x6e0(%rip),%xmm11        # 401740 <_IO_stdin_used+0xd0>
  40105e:	00 00 
  401060:	66 44 0f 6f 15 e7 06 	movdqa 0x6e7(%rip),%xmm10        # 401750 <_IO_stdin_used+0xe0>
  401067:	00 00 
  401069:	66 44 0f 6f 0d ee 06 	movdqa 0x6ee(%rip),%xmm9        # 401760 <_IO_stdin_used+0xf0>
  401070:	00 00 
  401072:	66 44 0f 6f 05 f5 06 	movdqa 0x6f5(%rip),%xmm8        # 401770 <_IO_stdin_used+0x100>
  401079:	00 00 
  40107b:	66 0f 6f 25 fd 06 00 	movdqa 0x6fd(%rip),%xmm4        # 401780 <_IO_stdin_used+0x110>
  401082:	00 
  401083:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  401088:	0f b7 97 e0 00 00 00 	movzwl 0xe0(%rdi),%edx
  40108f:	0f b7 87 a0 00 00 00 	movzwl 0xa0(%rdi),%eax
  401096:	bd 4b 00 00 00       	mov    $0x4b,%ebp
  40109b:	0f b7 8f a0 01 00 00 	movzwl 0x1a0(%rdi),%ecx
  4010a2:	44 0f b7 47 20       	movzwl 0x20(%rdi),%r8d
  4010a7:	48 c1 e2 10          	shl    $0x10,%rdx
  4010ab:	48 09 c2             	or     %rax,%rdx
  4010ae:	0f b7 47 60          	movzwl 0x60(%rdi),%eax
  4010b2:	48 c1 e2 10          	shl    $0x10,%rdx
  4010b6:	48 09 c2             	or     %rax,%rdx
  4010b9:	0f b7 87 e0 01 00 00 	movzwl 0x1e0(%rdi),%eax
  4010c0:	48 c1 e2 10          	shl    $0x10,%rdx
  4010c4:	4c 09 c2             	or     %r8,%rdx
  4010c7:	48 89 54 24 a8       	mov    %rdx,-0x58(%rsp)
  4010cc:	48 c1 e0 10          	shl    $0x10,%rax
  4010d0:	48 09 c8             	or     %rcx,%rax
  4010d3:	0f b7 8f 60 01 00 00 	movzwl 0x160(%rdi),%ecx
  4010da:	48 c1 e0 10          	shl    $0x10,%rax
  4010de:	48 09 c8             	or     %rcx,%rax
  4010e1:	0f b7 8f 20 01 00 00 	movzwl 0x120(%rdi),%ecx
  4010e8:	48 c1 e0 10          	shl    $0x10,%rax
  4010ec:	48 09 c8             	or     %rcx,%rax
  4010ef:	48 89 44 24 b0       	mov    %rax,-0x50(%rsp)
  4010f4:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  4010fa:	66 41 0f f5 c7       	pmaddwd %xmm15,%xmm0
  4010ff:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  401105:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  40110a:	8b 5c 24 a0          	mov    -0x60(%rsp),%ebx
  40110e:	48 c1 f8 20          	sar    $0x20,%rax
  401112:	03 44 24 98          	add    -0x68(%rsp),%eax
  401116:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  40111c:	66 41 0f f5 c6       	pmaddwd %xmm14,%xmm0
  401121:	8d 14 18             	lea    (%rax,%rbx,1),%edx
  401124:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  401129:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  40112f:	8b 5c 24 a0          	mov    -0x60(%rsp),%ebx
  401133:	48 c1 f8 20          	sar    $0x20,%rax
  401137:	01 d0                	add    %edx,%eax
  401139:	89 44 24 d8          	mov    %eax,-0x28(%rsp)
  40113d:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  401142:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  401148:	48 c1 f8 20          	sar    $0x20,%rax
  40114c:	03 44 24 98          	add    -0x68(%rsp),%eax
  401150:	66 41 0f f5 c5       	pmaddwd %xmm13,%xmm0
  401155:	8d 14 18             	lea    (%rax,%rbx,1),%edx
  401158:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  40115d:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  401163:	8b 4c 24 a0          	mov    -0x60(%rsp),%ecx
  401167:	48 c1 f8 20          	sar    $0x20,%rax
  40116b:	01 d0                	add    %edx,%eax
  40116d:	89 44 24 dc          	mov    %eax,-0x24(%rsp)
  401171:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  401176:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  40117c:	48 c1 f8 20          	sar    $0x20,%rax
  401180:	03 44 24 98          	add    -0x68(%rsp),%eax
  401184:	66 41 0f f5 c4       	pmaddwd %xmm12,%xmm0
  401189:	8d 14 08             	lea    (%rax,%rcx,1),%edx
  40118c:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  401191:	48 c1 f8 20          	sar    $0x20,%rax
  401195:	01 d0                	add    %edx,%eax
  401197:	89 44 24 e0          	mov    %eax,-0x20(%rsp)
  40119b:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  4011a1:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  4011a6:	8b 5c 24 a0          	mov    -0x60(%rsp),%ebx
  4011aa:	48 c1 f8 20          	sar    $0x20,%rax
  4011ae:	03 44 24 98          	add    -0x68(%rsp),%eax
  4011b2:	44 0f bf 4f 40       	movswl 0x40(%rdi),%r9d
  4011b7:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  4011bd:	44 0f bf 87 c0 00 00 	movswl 0xc0(%rdi),%r8d
  4011c4:	00 
  4011c5:	66 41 0f f5 c3       	pmaddwd %xmm11,%xmm0
  4011ca:	8d 14 18             	lea    (%rax,%rbx,1),%edx
  4011cd:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  4011d2:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  4011d8:	8b 4c 24 a0          	mov    -0x60(%rsp),%ecx
  4011dc:	48 c1 f8 20          	sar    $0x20,%rax
  4011e0:	01 d0                	add    %edx,%eax
  4011e2:	89 44 24 e4          	mov    %eax,-0x1c(%rsp)
  4011e6:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  4011eb:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  4011f1:	48 c1 f8 20          	sar    $0x20,%rax
  4011f5:	03 44 24 98          	add    -0x68(%rsp),%eax
  4011f9:	66 41 0f f5 c2       	pmaddwd %xmm10,%xmm0
  4011fe:	8d 14 08             	lea    (%rax,%rcx,1),%edx
  401201:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  401206:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  40120c:	8b 5c 24 a0          	mov    -0x60(%rsp),%ebx
  401210:	48 c1 f8 20          	sar    $0x20,%rax
  401214:	01 d0                	add    %edx,%eax
  401216:	89 44 24 e8          	mov    %eax,-0x18(%rsp)
  40121a:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  40121f:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  401225:	48 c1 f8 20          	sar    $0x20,%rax
  401229:	03 44 24 98          	add    -0x68(%rsp),%eax
  40122d:	66 41 0f f5 c1       	pmaddwd %xmm9,%xmm0
  401232:	8d 14 18             	lea    (%rax,%rbx,1),%edx
  401235:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  40123a:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  401240:	8b 4c 24 a0          	mov    -0x60(%rsp),%ecx
  401244:	48 c1 f8 20          	sar    $0x20,%rax
  401248:	01 d0                	add    %edx,%eax
  40124a:	89 44 24 ec          	mov    %eax,-0x14(%rsp)
  40124e:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  401253:	66 0f 6f 44 24 a8    	movdqa -0x58(%rsp),%xmm0
  401259:	48 c1 f8 20          	sar    $0x20,%rax
  40125d:	03 44 24 98          	add    -0x68(%rsp),%eax
  401261:	66 41 0f f5 c0       	pmaddwd %xmm8,%xmm0
  401266:	8d 14 08             	lea    (%rax,%rcx,1),%edx
  401269:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  40126e:	0f bf 8f 40 01 00 00 	movswl 0x140(%rdi),%ecx
  401275:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  40127b:	8b 5c 24 a0          	mov    -0x60(%rsp),%ebx
  40127f:	48 c1 f8 20          	sar    $0x20,%rax
  401283:	01 d0                	add    %edx,%eax
  401285:	89 44 24 f0          	mov    %eax,-0x10(%rsp)
  401289:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  40128e:	48 c1 f8 20          	sar    $0x20,%rax
  401292:	03 44 24 98          	add    -0x68(%rsp),%eax
  401296:	8d 14 18             	lea    (%rax,%rbx,1),%edx
  401299:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  40129e:	44 89 cb             	mov    %r9d,%ebx
  4012a1:	48 c1 f8 20          	sar    $0x20,%rax
  4012a5:	01 d0                	add    %edx,%eax
  4012a7:	0f bf 97 c0 01 00 00 	movswl 0x1c0(%rdi),%edx
  4012ae:	89 44 24 f4          	mov    %eax,-0xc(%rsp)
  4012b2:	b8 59 00 00 00       	mov    $0x59,%eax
  4012b7:	0f af d8             	imul   %eax,%ebx
  4012ba:	44 89 c0             	mov    %r8d,%eax
  4012bd:	0f af c5             	imul   %ebp,%eax
  4012c0:	bd 32 00 00 00       	mov    $0x32,%ebp
  4012c5:	01 d8                	add    %ebx,%eax
  4012c7:	89 cb                	mov    %ecx,%ebx
  4012c9:	0f af dd             	imul   %ebp,%ebx
  4012cc:	bd 4b 00 00 00       	mov    $0x4b,%ebp
  4012d1:	01 d8                	add    %ebx,%eax
  4012d3:	8d 1c d2             	lea    (%rdx,%rdx,8),%ebx
  4012d6:	8d 1c 58             	lea    (%rax,%rbx,2),%ebx
  4012d9:	48 8b 44 24 c8       	mov    -0x38(%rsp),%rax
  4012de:	4c 21 d0             	and    %r10,%rax
  4012e1:	48 09 d8             	or     %rbx,%rax
  4012e4:	44 89 cb             	mov    %r9d,%ebx
  4012e7:	0f af dd             	imul   %ebp,%ebx
  4012ea:	43 8d 2c c0          	lea    (%r8,%r8,8),%ebp
  4012ee:	89 c0                	mov    %eax,%eax
  4012f0:	01 ed                	add    %ebp,%ebp
  4012f2:	29 eb                	sub    %ebp,%ebx
  4012f4:	6b e9 a7             	imul   $0xffffffa7,%ecx,%ebp
  4012f7:	01 eb                	add    %ebp,%ebx
  4012f9:	6b ea ce             	imul   $0xffffffce,%edx,%ebp
  4012fc:	01 eb                	add    %ebp,%ebx
  4012fe:	bd a7 ff ff ff       	mov    $0xffffffa7,%ebp
  401303:	48 c1 e3 20          	shl    $0x20,%rbx
  401307:	48 09 d8             	or     %rbx,%rax
  40130a:	44 89 cb             	mov    %r9d,%ebx
  40130d:	47 8d 0c c9          	lea    (%r9,%r9,8),%r9d
  401311:	48 89 44 24 c8       	mov    %rax,-0x38(%rsp)
  401316:	b8 32 00 00 00       	mov    $0x32,%eax
  40131b:	0f af d8             	imul   %eax,%ebx
  40131e:	44 89 c0             	mov    %r8d,%eax
  401321:	0f af c5             	imul   %ebp,%eax
  401324:	bd 4b 00 00 00       	mov    $0x4b,%ebp
  401329:	66 0f 6f 74 24 d8    	movdqa -0x28(%rsp),%xmm6
  40132f:	01 d8                	add    %ebx,%eax
  401331:	8d 1c c9             	lea    (%rcx,%rcx,8),%ebx
  401334:	8d 1c 58             	lea    (%rax,%rbx,2),%ebx
  401337:	89 d0                	mov    %edx,%eax
  401339:	0f af c5             	imul   %ebp,%eax
  40133c:	bd 4b 00 00 00       	mov    $0x4b,%ebp
  401341:	01 c3                	add    %eax,%ebx
  401343:	48 8b 44 24 d0       	mov    -0x30(%rsp),%rax
  401348:	4c 21 d0             	and    %r10,%rax
  40134b:	48 09 d8             	or     %rbx,%rax
  40134e:	bb ce ff ff ff       	mov    $0xffffffce,%ebx
  401353:	44 0f af c3          	imul   %ebx,%r8d
  401357:	89 c0                	mov    %eax,%eax
  401359:	0f af cd             	imul   %ebp,%ecx
  40135c:	47 8d 04 48          	lea    (%r8,%r9,2),%r8d
  401360:	44 01 c1             	add    %r8d,%ecx
  401363:	41 b8 a7 ff ff ff    	mov    $0xffffffa7,%r8d
  401369:	41 0f af d0          	imul   %r8d,%edx
  40136d:	01 ca                	add    %ecx,%edx
  40136f:	48 8b 4c 24 b8       	mov    -0x48(%rsp),%rcx
  401374:	48 c1 e2 20          	shl    $0x20,%rdx
  401378:	48 09 d0             	or     %rdx,%rax
  40137b:	0f b7 17             	movzwl (%rdi),%edx
  40137e:	48 89 44 24 d0       	mov    %rax,-0x30(%rsp)
  401383:	0f b7 87 00 01 00 00 	movzwl 0x100(%rdi),%eax
  40138a:	4c 21 d1             	and    %r10,%rcx
  40138d:	48 c1 e0 10          	shl    $0x10,%rax
  401391:	48 09 d0             	or     %rdx,%rax
  401394:	0f b7 97 80 01 00 00 	movzwl 0x180(%rdi),%edx
  40139b:	48 c1 e0 10          	shl    $0x10,%rax
  40139f:	48 09 d0             	or     %rdx,%rax
  4013a2:	0f b7 97 80 00 00 00 	movzwl 0x80(%rdi),%edx
  4013a9:	48 c1 e0 10          	shl    $0x10,%rax
  4013ad:	48 09 d0             	or     %rdx,%rax
  4013b0:	48 89 44 24 98       	mov    %rax,-0x68(%rsp)
  4013b5:	48 89 44 24 a0       	mov    %rax,-0x60(%rsp)
  4013ba:	66 0f 6f 44 24 98    	movdqa -0x68(%rsp),%xmm0
  4013c0:	66 0f f5 c4          	pmaddwd %xmm4,%xmm0
  4013c4:	66 0f 7f 44 24 98    	movdqa %xmm0,-0x68(%rsp)
  4013ca:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  4013cf:	44 8b 44 24 98       	mov    -0x68(%rsp),%r8d
  4013d4:	48 c1 f8 20          	sar    $0x20,%rax
  4013d8:	48 8b 54 24 a0       	mov    -0x60(%rsp),%rdx
  4013dd:	44 8b 4c 24 a0       	mov    -0x60(%rsp),%r9d
  4013e2:	41 8d 1c 00          	lea    (%r8,%rax,1),%ebx
  4013e6:	44 29 c0             	sub    %r8d,%eax
  4013e9:	48 c1 e0 20          	shl    $0x20,%rax
  4013ed:	66 0f 6f 44 24 e8    	movdqa -0x18(%rsp),%xmm0
  4013f3:	48 09 d9             	or     %rbx,%rcx
  4013f6:	48 c1 fa 20          	sar    $0x20,%rdx
  4013fa:	48 89 4c 24 b8       	mov    %rcx,-0x48(%rsp)
  4013ff:	48 8b 4c 24 c0       	mov    -0x40(%rsp),%rcx
  401404:	89 d3                	mov    %edx,%ebx
  401406:	44 29 cb             	sub    %r9d,%ebx
  401409:	44 01 ca             	add    %r9d,%edx
  40140c:	48 c1 e2 20          	shl    $0x20,%rdx
  401410:	4c 21 d1             	and    %r10,%rcx
  401413:	48 09 d9             	or     %rbx,%rcx
  401416:	48 89 4c 24 c0       	mov    %rcx,-0x40(%rsp)
  40141b:	48 8b 4c 24 b8       	mov    -0x48(%rsp),%rcx
  401420:	89 c9                	mov    %ecx,%ecx
  401422:	48 09 d1             	or     %rdx,%rcx
  401425:	48 8b 54 24 c0       	mov    -0x40(%rsp),%rdx
  40142a:	48 89 4c 24 b8       	mov    %rcx,-0x48(%rsp)
  40142f:	89 d2                	mov    %edx,%edx
  401431:	48 09 c2             	or     %rax,%rdx
  401434:	48 89 54 24 c0       	mov    %rdx,-0x40(%rsp)
  401439:	66 0f 6f 7c 24 b8    	movdqa -0x48(%rsp),%xmm7
  40143f:	66 0f 6f 6c 24 b8    	movdqa -0x48(%rsp),%xmm5
  401445:	66 0f fe 7c 24 c8    	paddd  -0x38(%rsp),%xmm7
  40144b:	66 0f 6f cf          	movdqa %xmm7,%xmm1
  40144f:	66 0f fa fe          	psubd  %xmm6,%xmm7
  401453:	66 0f fe fb          	paddd  %xmm3,%xmm7
  401457:	66 0f fa 6c 24 c8    	psubd  -0x38(%rsp),%xmm5
  40145d:	66 0f 70 ed 1b       	pshufd $0x1b,%xmm5,%xmm5
  401462:	66 0f e2 fa          	psrad  %xmm2,%xmm7
  401466:	66 0f fe ce          	paddd  %xmm6,%xmm1
  40146a:	66 0f 6f f7          	movdqa %xmm7,%xmm6
  40146e:	66 0f fe cb          	paddd  %xmm3,%xmm1
  401472:	66 0f e2 ca          	psrad  %xmm2,%xmm1
  401476:	66 0f fe c5          	paddd  %xmm5,%xmm0
  40147a:	66 0f fa 6c 24 e8    	psubd  -0x18(%rsp),%xmm5
  401480:	66 0f fe eb          	paddd  %xmm3,%xmm5
  401484:	66 0f e2 ea          	psrad  %xmm2,%xmm5
  401488:	66 0f 6b f5          	packssdw %xmm5,%xmm6
  40148c:	66 0f fe c3          	paddd  %xmm3,%xmm0
  401490:	66 0f e2 c2          	psrad  %xmm2,%xmm0
  401494:	66 0f 6b c8          	packssdw %xmm0,%xmm1
  401498:	66 0f 7f 74 24 98    	movdqa %xmm6,-0x68(%rsp)
  40149e:	48 8b 44 24 98       	mov    -0x68(%rsp),%rax
  4014a3:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
  4014a7:	89 c2                	mov    %eax,%edx
  4014a9:	c1 fa 10             	sar    $0x10,%edx
  4014ac:	66 89 46 1e          	mov    %ax,0x1e(%rsi)
  4014b0:	66 89 56 1c          	mov    %dx,0x1c(%rsi)
  4014b4:	48 89 c2             	mov    %rax,%rdx
  4014b7:	48 c1 f8 30          	sar    $0x30,%rax
  4014bb:	48 c1 ea 20          	shr    $0x20,%rdx
  4014bf:	66 89 46 18          	mov    %ax,0x18(%rsi)
  4014c3:	48 8b 44 24 a0       	mov    -0x60(%rsp),%rax
  4014c8:	66 89 56 1a          	mov    %dx,0x1a(%rsi)
  4014cc:	89 c2                	mov    %eax,%edx
  4014ce:	66 89 46 16          	mov    %ax,0x16(%rsi)
  4014d2:	c1 fa 10             	sar    $0x10,%edx
  4014d5:	66 89 56 14          	mov    %dx,0x14(%rsi)
  4014d9:	48 89 c2             	mov    %rax,%rdx
  4014dc:	48 c1 f8 30          	sar    $0x30,%rax
  4014e0:	48 c1 ea 20          	shr    $0x20,%rdx
  4014e4:	48 83 c7 02          	add    $0x2,%rdi
  4014e8:	66 89 46 10          	mov    %ax,0x10(%rsi)
  4014ec:	66 89 56 12          	mov    %dx,0x12(%rsi)
  4014f0:	48 83 c6 20          	add    $0x20,%rsi
  4014f4:	4c 39 df             	cmp    %r11,%rdi
  4014f7:	0f 85 8b fb ff ff    	jne    401088 <partialButterflyInverse16_simd+0x88>
  4014fd:	5b                   	pop    %rbx
  4014fe:	5d                   	pop    %rbp
  4014ff:	c3                   	retq   

0000000000401500 <idct16_simd>:
  401500:	53                   	push   %rbx
  401501:	ba 07 00 00 00       	mov    $0x7,%edx
  401506:	48 89 f3             	mov    %rsi,%rbx
  401509:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
  401510:	48 89 e6             	mov    %rsp,%rsi
  401513:	e8 e8 fa ff ff       	callq  401000 <partialButterflyInverse16_simd>
  401518:	48 89 de             	mov    %rbx,%rsi
  40151b:	48 89 e7             	mov    %rsp,%rdi
  40151e:	ba 0c 00 00 00       	mov    $0xc,%edx
  401523:	e8 d8 fa ff ff       	callq  401000 <partialButterflyInverse16_simd>
  401528:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
  40152f:	5b                   	pop    %rbx
  401530:	c3                   	retq   
  401531:	66 66 66 66 66 66 2e 	data32 data32 data32 data32 data32 nopw %cs:0x0(%rax,%rax,1)
  401538:	0f 1f 84 00 00 00 00 
  40153f:	00 

0000000000401540 <benchmark>:
  401540:	41 56                	push   %r14
  401542:	49 89 ce             	mov    %rcx,%r14
  401545:	41 55                	push   %r13
  401547:	49 89 fd             	mov    %rdi,%r13
  40154a:	31 ff                	xor    %edi,%edi
  40154c:	41 54                	push   %r12
  40154e:	49 89 f4             	mov    %rsi,%r12
  401551:	55                   	push   %rbp
  401552:	48 89 d5             	mov    %rdx,%rbp
  401555:	53                   	push   %rbx
  401556:	bb 40 42 0f 00       	mov    $0xf4240,%ebx
  40155b:	48 83 ec 20          	sub    $0x20,%rsp
  40155f:	48 89 e6             	mov    %rsp,%rsi
  401562:	e8 49 f1 ff ff       	callq  4006b0 <clock_gettime@plt>
  401567:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  40156e:	00 00 
  401570:	48 89 ee             	mov    %rbp,%rsi
  401573:	4c 89 e7             	mov    %r12,%rdi
  401576:	41 ff d5             	callq  *%r13
  401579:	83 eb 01             	sub    $0x1,%ebx
  40157c:	75 f2                	jne    401570 <benchmark+0x30>
  40157e:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
  401583:	31 ff                	xor    %edi,%edi
  401585:	e8 26 f1 ff ff       	callq  4006b0 <clock_gettime@plt>
  40158a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
  40158f:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  401594:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  401599:	48 2b 04 24          	sub    (%rsp),%rax
  40159d:	48 89 ce             	mov    %rcx,%rsi
  4015a0:	48 29 d6             	sub    %rdx,%rsi
  4015a3:	78 3b                	js     4015e0 <benchmark+0xa0>
  4015a5:	48 69 c0 00 ca 9a 3b 	imul   $0x3b9aca00,%rax,%rax
  4015ac:	4c 89 f2             	mov    %r14,%rdx
  4015af:	bf 01 00 00 00       	mov    $0x1,%edi
  4015b4:	48 01 c6             	add    %rax,%rsi
  4015b7:	b8 01 00 00 00       	mov    $0x1,%eax
  4015bc:	f2 48 0f 2a c6       	cvtsi2sd %rsi,%xmm0
  4015c1:	be 74 16 40 00       	mov    $0x401674,%esi
  4015c6:	f2 0f 5e 05 c2 01 00 	divsd  0x1c2(%rip),%xmm0        # 401790 <_IO_stdin_used+0x120>
  4015cd:	00 
  4015ce:	e8 ed f0 ff ff       	callq  4006c0 <__printf_chk@plt>
  4015d3:	48 83 c4 20          	add    $0x20,%rsp
  4015d7:	5b                   	pop    %rbx
  4015d8:	5d                   	pop    %rbp
  4015d9:	41 5c                	pop    %r12
  4015db:	41 5d                	pop    %r13
  4015dd:	41 5e                	pop    %r14
  4015df:	c3                   	retq   
  4015e0:	48 8d b1 00 ca 9a 3b 	lea    0x3b9aca00(%rcx),%rsi
  4015e7:	48 83 e8 01          	sub    $0x1,%rax
  4015eb:	48 29 d6             	sub    %rdx,%rsi
  4015ee:	eb b5                	jmp    4015a5 <benchmark+0x65>

00000000004015f0 <__libc_csu_init>:
  4015f0:	41 57                	push   %r15
  4015f2:	41 89 ff             	mov    %edi,%r15d
  4015f5:	41 56                	push   %r14
  4015f7:	49 89 f6             	mov    %rsi,%r14
  4015fa:	41 55                	push   %r13
  4015fc:	49 89 d5             	mov    %rdx,%r13
  4015ff:	41 54                	push   %r12
  401601:	4c 8d 25 f8 07 20 00 	lea    0x2007f8(%rip),%r12        # 601e00 <__frame_dummy_init_array_entry>
  401608:	55                   	push   %rbp
  401609:	48 8d 2d f8 07 20 00 	lea    0x2007f8(%rip),%rbp        # 601e08 <__init_array_end>
  401610:	53                   	push   %rbx
  401611:	4c 29 e5             	sub    %r12,%rbp
  401614:	31 db                	xor    %ebx,%ebx
  401616:	48 c1 fd 03          	sar    $0x3,%rbp
  40161a:	48 83 ec 08          	sub    $0x8,%rsp
  40161e:	e8 fd ef ff ff       	callq  400620 <_init>
  401623:	48 85 ed             	test   %rbp,%rbp
  401626:	74 1e                	je     401646 <__libc_csu_init+0x56>
  401628:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40162f:	00 
  401630:	4c 89 ea             	mov    %r13,%rdx
  401633:	4c 89 f6             	mov    %r14,%rsi
  401636:	44 89 ff             	mov    %r15d,%edi
  401639:	41 ff 14 dc          	callq  *(%r12,%rbx,8)
  40163d:	48 83 c3 01          	add    $0x1,%rbx
  401641:	48 39 eb             	cmp    %rbp,%rbx
  401644:	75 ea                	jne    401630 <__libc_csu_init+0x40>
  401646:	48 83 c4 08          	add    $0x8,%rsp
  40164a:	5b                   	pop    %rbx
  40164b:	5d                   	pop    %rbp
  40164c:	41 5c                	pop    %r12
  40164e:	41 5d                	pop    %r13
  401650:	41 5e                	pop    %r14
  401652:	41 5f                	pop    %r15
  401654:	c3                   	retq   
  401655:	66 66 2e 0f 1f 84 00 	data32 nopw %cs:0x0(%rax,%rax,1)
  40165c:	00 00 00 00 

0000000000401660 <__libc_csu_fini>:
  401660:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000401664 <_fini>:
  401664:	48 83 ec 08          	sub    $0x8,%rsp
  401668:	48 83 c4 08          	add    $0x8,%rsp
  40166c:	c3                   	retq   
