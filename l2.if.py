#!/bin/python3
# Task
# Given an integer, , perform the following conditional actions:
#
# If  is odd, print Weird
# If  is even and in the inclusive range of  to , print Not Weird
# If  is even and in the inclusive range of  to , print Weird
# If  is even and greater than , print Not Weird

# import math
# import os
# import random
# import re
# import sys

if __name__ == '__main__':
    n = int(input().strip())
    if n % 2 > 0:
        print('Weird')
    elif 5 >= n >= 2:
        print('Not Weird')
    elif 20 >= n >= 6:
        print('Weird')
    else:
        print('Not Weird')

# height = int(input('Input height'))
# age = int(input('Input your age'))
#
# if 18 < age < 27:
#     if height < 170:
#         print("Tank Army")
#     elif height < 185:
#         print("Flot Army")
#     elif height < 200:
#         print("Desant Army")
#     else:
#         print("Other")
# else:
#     print("Don't army")