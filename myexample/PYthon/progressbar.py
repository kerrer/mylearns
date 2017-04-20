#!/usr/bin/python
# -*- coding: utf-8 -*-

import time
import sys

def do_task():
	time.sleep(0.1)

def example_1(n):
	steps = n/10
	for i in range(n):
		do_task()
		if i%steps == 0:
			print '\b.',
			sys.stdout.flush()
	print '\b]  Done!',
	
print 'Starting [          ]',
print '\b'*12,
sys.stdout.flush()
example_1(100)
