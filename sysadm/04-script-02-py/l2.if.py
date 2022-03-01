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

# if __name__ == '__main__':
#     n = int(input().strip())
#     if n % 2 > 0:
#         print('Weird')
#     elif 5 >= n >= 2:
#         print('Not Weird')
#     elif 20 >= n >= 6:
#         print('Weird')
#     else:
#         print('Not Weird')

# Задача №2
# На лекции мы рассматривали пример для военкомата.
# Сейчас мы знаем про его рост. Расширить это приложение следующими условиями:
# Проверка на возраст призывника.
# Количество детей.
# Учится ли он сейчас.

# age = int(input('Input your age'))
# childs = int(input('How many kids do you have?'))
# height = int(input('Input height'))
# student = input('Are you a student?')
#
#
# if 18 <= age < 27 and childs <= 2 and student != 'yes':
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

i = 1
for color in 'red', 'orange', 'yellow', 'green', 'cyan', 'blue', 'violet':
    print(i, '-th color of rainbow is ', color, sep = '')
    i += 1