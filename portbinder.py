import serial
import threading

# Configuration for the serial ports
port1 = '/dev/ttyUSB0'
port2 = '/dev/ttyUSB1'
baud_rate = 115200

# Initialize serial ports
ser1 = serial.Serial(port1, baud_rate)
ser2 = serial.Serial(port2, baud_rate)

def forward_data(source, destination):
    while True:
        data = source.read()
        if data:
            destination.write(data)

# Create threads for forwarding data
thread1 = threading.Thread(target=forward_data, args=(ser1, ser2))
thread2 = threading.Thread(target=forward_data, args=(ser2, ser1))

# Start the threads
thread1.start()
thread2.start()

# Join the threads to keep the program running
thread1.join()
thread2.join()
