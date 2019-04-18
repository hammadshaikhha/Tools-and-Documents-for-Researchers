'''
Purpose: Write time in text file at which script is executed

Date Started: Wednesday, April 17, 2019
'''

# Import relevant libraries
import time

# Create text file (add path to your working directory)
filename = "record_time.txt"

# Record time 
current_time = time.strftime('%a %H:%M:%S')

# Open file and write current time in new line
with open(filename, 'a') as line:

    # Record current time as string
    str_time = str(current_time)
    
    # Append time to a new line
    line.write(str_time)
    
    # Create new line
    line.write('\n')

print("Current time appended to file")
