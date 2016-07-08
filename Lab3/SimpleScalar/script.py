import os
import subprocess
import time
import plotly
import plotly.plotly as py
import plotly.graph_objs as go
from plotly import tools

def execute_command():
	benchmark_file = ["benchmarks/fibonacci","benchmarks/matmul", "benchmarks/pi", "benchmarks/whetstone", "benchmarks/memcopy"]
	branch_pred_algo = ["nottaken", "bimod", "2lev", "comb", "perfect"]
	listoflist = []
	for algo in branch_pred_algo:
		indi_list = []
		for bench in benchmark_file:
			test = subprocess.Popen(["./sim-outorder", "-fetch:ifqsize", "1","-decode:width", "1", "-issue:width", "1", 
			"-commit:width", "1", "-issue:inorder", "true", "-res:ialu", "1", "-res:imult", "1", "-res:fpalu", "1"
			, "-res:fpmult", "1", "-bpred", algo, "-redir:sim", "test.txt", bench])
			time.sleep(10)
			#test.kill()
			out_file = open("test.txt", "r")
			for line in out_file:
				if "sim_IPC" in line:
					words = line.split()
					indi_list.append(float(words[1]))
					print algo, words[1]
			out_file.close()
		listoflist.append(indi_list)
		time.sleep(2)

	for list1 in listoflist:
		for f_val in list1:
			print f_val
	algo_name=["fibonacci","matmul", "pi", "whetstone", "memcopy"]
	plotly.tools.set_credentials_file(username='niroj', api_key='4gjbehyypy')
	trace0 = go.Bar(
		x=algo_name,
		y=listoflist[0],
		name='nottaken',
		marker=dict(
			color='rgb(49,130,189)'
			)
		)

	trace1 = go.Bar(
		x=algo_name,
		y=listoflist[1],
		name='bimod',
		marker=dict(
			color='rgb(255,100,50)'
			)
		)

	trace2 = go.Bar(
		x=algo_name,
		y=listoflist[2],
		name='2lev',
		marker=dict(
			color='rgb(74,155,225)'
			)
		)

	trace3 = go.Bar(
		x=algo_name,
		y=listoflist[3],
		name='comb',
		marker=dict(
			color='rgb(225,75,0)'
			)
		)

	trace4 = go.Bar(
		x=algo_name,
		y=listoflist[4],
		name='perfect',
		marker=dict(
			color='rgb(125,200, 200)'
			)
		)
	data = [trace0, trace1, trace2, trace3, trace4]
	layout = go.Layout(
		xaxis=dict(tickangle=-45),barmode='group',)

	fig = go.Figure(data=data, layout=layout)
	py.iplot(fig, filename='assignment3_1')

def assignment3_task2():
	benchmark_file = ["benchmarks/fibonacci","benchmarks/matmul", "benchmarks/pi", "benchmarks/whetstone", "benchmarks/memcopy"]
	num_of_res = ["1", "2", "4", "8"]
	listoflist = []
	for num in num_of_res:
		indi_list = []
		for bench in benchmark_file:
			test = subprocess.Popen(["./sim-outorder", "-fetch:ifqsize", num,"-decode:width", num, "-issue:width", num, 
			"-commit:width", num, "-issue:inorder", "false", "-res:ialu", num, "-res:imult", num, "-res:fpalu", num
			, "-res:fpmult", num, "-bpred", "2lev", "-redir:sim", "test.txt", bench])
			time.sleep(10)
			#test.kill()
			out_file = open("test.txt", "r")
			for line in out_file:
				if "sim_IPC" in line:
					words = line.split()
					indi_list.append(float(words[1]))
					print num, words[1]
			out_file.close()
		listoflist.append(indi_list)
		time.sleep(2)
	#Now, add for the custom case. The fifth case can be done later on??? WAIT FOR IT. First complete the four cases.
	indi_list = []
	for bench in benchmark_file:
		test = subprocess.Popen(["./sim-outorder", "-fetch:ifqsize", "8","-decode:width", "8", "-issue:width", "8",
			"-commit:width", "8", "-issue:inorder", "false", "-res:ialu", "4", "-res:imult", "1", "-res:fpalu", "4",
			"-res:fpmult", "1", "-bpred", "2lev", "-redir:sim", "test.txt", bench])
		time.sleep(10)
		out_file = open("test.txt", "r")
		for line in out_file:
			if "sim_IPC" in line:
				words = line.split()
				indi_list.append(float(words[1]))
				print num, words[1]
		out_file.close()
	listoflist.append(indi_list)
	time.sleep(2)

	for list1 in listoflist:
		for f_val in list1:
			print f_val
	algo_name=["fibonacci","matmul", "pi", "whetstone", "memcopy"]
	plotly.tools.set_credentials_file(username='niroj', api_key='4gjbehyypy')
	trace0 = go.Bar(
		x=algo_name,
		y=listoflist[0],
		name='1',
		marker=dict(
			color='rgb(49,130,189)'
			)
		)

	trace1 = go.Bar(
		x=algo_name,
		y=listoflist[1],
		name='2',
		marker=dict(
			color='rgb(255,100,50)'
			)
		)

	trace2 = go.Bar(
		x=algo_name,
		y=listoflist[2],
		name='4',
		marker=dict(
			color='rgb(74,155,225)'
			)
		)

	trace3 = go.Bar(
		x=algo_name,
		y=listoflist[3],
		name='8',
		marker=dict(
			color='rgb(225,75,0)'
			)
		)

	trace4 = go.Bar(
		x=algo_name,
		y=listoflist[4],
		name='custom',
		marker=dict(
			color='rgb(125,200, 200)'
			)
		)
	data = [trace0, trace1, trace2, trace3, trace4]
	layout = go.Layout(
		xaxis=dict(tickangle=-45),barmode='group',)

	fig = go.Figure(data=data, layout=layout)
	py.iplot(fig, filename='assignment3_2_outorder')

def assignment3_task3():
	benchmark_file = ["benchmarks/fibonacci","benchmarks/matmul", "benchmarks/pi", "benchmarks/whetstone", "benchmarks/memcopy"]
	#branch_pred_algo = ["nottaken", "bimod", "2lev", "comb", "perfect"]
	ruu_list = ["16", "32", "32", "64", "64"]
	lsq_list = ["8", "8", "16", "16", "32"]
	listoflist = []
	for (ruu, lsq) in zip(ruu_list, lsq_list):
		indi_list = []
		for bench in benchmark_file:
			test = subprocess.Popen(["./sim-outorder", "-fetch:ifqsize", "8","-decode:width", "8", "-issue:width", "8", 
			"-commit:width", "8", "-issue:inorder", "false", "-res:ialu", "8", "-res:imult", "2", "-res:fpalu", "8"
			, "-res:fpmult", "2", "-bpred", "2lev", "-ruu:size", ruu, "-lsq:size", lsq, "-redir:sim", "test.txt", bench])
			time.sleep(10)
			#test.kill()
			out_file = open("test.txt", "r")
			for line in out_file:
				if "sim_IPC" in line:
					words = line.split()
					indi_list.append(float(words[1]))
					print ruu_list," ,", lsq_list, " ", words[1]
			out_file.close()
		listoflist.append(indi_list)
		time.sleep(2)

	for list1 in listoflist:
		for f_val in list1:
			print f_val
	algo_name=["fibonacci","matmul", "pi", "whetstone", "memcopy"]
	plotly.tools.set_credentials_file(username='niroj', api_key='4gjbehyypy')
	trace0 = go.Bar(
		x=algo_name,
		y=listoflist[0],
		name='(16, 8)',
		marker=dict(
			color='rgb(49,130,189)'
			)
		)

	trace1 = go.Bar(
		x=algo_name,
		y=listoflist[1],
		name='(32, 8)',
		marker=dict(
			color='rgb(255,100,50)'
			)
		)

	trace2 = go.Bar(
		x=algo_name,
		y=listoflist[2],
		name='(32, 16)',
		marker=dict(
			color='rgb(74,155,225)'
			)
		)

	trace3 = go.Bar(
		x=algo_name,
		y=listoflist[3],
		name='(64, 16)',
		marker=dict(
			color='rgb(225,75,0)'
			)
		)

	trace4 = go.Bar(
		x=algo_name,
		y=listoflist[4],
		name='(64, 32)',
		marker=dict(
			color='rgb(125,200, 200)'
			)
		)
	data = [trace0, trace1, trace2, trace3, trace4]
	layout = go.Layout(
		xaxis=dict(tickangle=-45),barmode='group',)

	fig = go.Figure(data=data, layout=layout)
	py.iplot(fig, filename='assignment3_3_double_res')

def assignment_5():
	num_of_set = 1024
	block_size = 64
	set_associativity = 4
	latency_lev1 = 6
	for i in range(0, 10):
		#latency_lev2 = latency_lev1
		block_size = 64
		for j in range(0, 10):
			latency_lev3 = latency_lev1
			set_associativity = 4
			prev = -1
			for k in range(0, 10):
				cache_value = "ul2:" + str(num_of_set) + ":"+ str(block_size)+":"+ str(set_associativity)+":"+"l"
				test = subprocess.Popen(["./sim-outorder", "-issue:width", "4", "-issue:inorder", "false", "-bpred", "comb", 
					"-mem:lat", "200", "2", "-cache:dl2", cache_value, "-cache:il2lat", str(latency_lev3), "-cache:dl2lat", 
					str(latency_lev3), "-ruu:size", "32", "-lsq:size", "16", "-redir:sim", "test.txt", "benchmarks/memcopy"])
				time.sleep(10)
				#test.kill()
				out_file = open("test.txt", "r")
				for line in out_file:
					if "sim_IPC" in line:
						words = line.split()
						print cache_value, " " ,"latency = ", str(latency_lev3), " : IPC = ", words[1]
						break
				if prev >= float(words[1]):
					break
				prev = float(words[1])
				out_file.close()
				latency_lev3 = latency_lev3 + 1
				set_associativity = set_associativity * 2
			#latency_lev2 = latency_lev2 + 1
			block_size = block_size *2
		latency_lev1 = latency_lev1 + 1
		num_of_set = num_of_set * 2

	return None
	#assignment_5 with the plotting options available
	'''
def assignment_5():
	number_of_sets = ["1024", "2048", "4096", "8192", "16284"]
	block_sizes = ["64", "128", "256", "512", "1024"]
	set_associativity= ["4", "8", "16", "32", "64"]
	listoflist_x = []
	listoflist_y = []
	listoflist_z = []
	latency_lev1 = 6
	for num_set in number_of_sets:
		latency_lev2 = latency_lev1
		list_x = []
		list_y = []
		list_z = []
		for block_size in block_sizes:
			latency_lev3 = latency_lev2
			for associativity in set_associativity:
				cache_value = "ul2:" + num_set + ":"+block_size+":"+associativity+":"+"l"
				test = subprocess.Popen(["./sim-outorder", "-issue:width", "4", "-issue:inorder", "false", "-bpred", "comb", 
					"-cache:dl2", cache_value, "-cache:il2lat", str(latency_lev3), "-ruu:size", "32", "-lsq:size", "16", "-redir:sim",
					"test.txt", "benchmarks/memcopy"])
				time.sleep(8)
				#test.kill()
				out_file = open("test.txt", "r")
				for line in out_file:
					if "sim_IPC" in line:
						words = line.split()
						print cache_value, " " ,"latency = ", str(latency_lev3), " : IPC = ", words[1]
						list_x.append(float(block_size))
						list_y.append(float(associativity))
						list_z.append(float(words[1]))
				out_file.close()
				latency_lev3 = latency_lev3 + 1
			latency_lev2 = latency_lev2 + 1
		latency_lev1 = latency_lev1 + 1
		listoflist_x.append(list_x)
		listoflist_y.append(list_y)
		listoflist_z.append(list_z)

	#Now drawing in the python
	plotly.tools.set_credentials_file(username='niroj', api_key='4gjbehyypy')
	scene = dict(
		xaxis=dict(
			gridcolor='rgb(255, 255, 255)',
			zerolinecolor='rgb(255, 255, 255)',
			showbackground=True,
			backgroundcolor='rgb(230, 230,230)'
			),
		yaxis=dict(
			gridcolor='rgb(255, 255, 255)',
			zerolinecolor='rgb(255, 255, 255)',
			showbackground=True,
			backgroundcolor='rgb(230, 230,230)'
			),
		zaxis=dict(
			gridcolor='rgb(255, 255, 255)',
			zerolinecolor='rgb(255, 255, 255)',
			showbackground=True,
			backgroundcolor='rgb(230, 230,230)'
			)
		)
	fig = tools.make_subplots(rows=2, cols=2,
		specs=[[{'is_3d': True}, {'is_3d': True}],
		[{'is_3d': True}, {'is_3d': True}]])
	# adding surfaces to subplots.
	fig.append_trace(dict(type='surface', x=listoflist_x[0], y=listoflist_y[0], z=listoflist_z[0], colorscale='Viridis',
		scene='scene1', showscale=False), 1, 1)
	fig.append_trace(dict(type='surface', x=listoflist_x[1], y=listoflist_y[1], z=listoflist_z[1], colorscale='RdBu',
		scene='scene2', showscale=False), 1, 2)
	fig.append_trace(dict(type='surface', x=listoflist_x[2], y=listoflist_y[2], z=listoflist_z[2], colorscale='YIOrRd',
		scene='scene3', showscale=False), 2, 1)
	fig.append_trace(dict(type='surface', x=listoflist_x[3], y=listoflist_y[3], z=listoflist_z[3], colorscale='YIGnBu',
		scene='scene4', showscale=False), 2, 2)
	fig['layout'].update(title='subplots with different colorscales',
		height=800, width=800)
	fig['layout']['scene1'].update(scene)
	fig['layout']['scene2'].update(scene)
	fig['layout']['scene3'].update(scene)
	fig['layout']['scene4'].update(scene)
	py.iplot(fig, file_name='assignment3_5')

	return None
	'''

if __name__ == "__main__":
	#execute_command()
	#assignment3_task2()
	#assignment3_task3()
	assignment_5()