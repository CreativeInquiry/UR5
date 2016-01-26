Here’s the quick low-down on the files:

#UR-5

##00 Tests

* **byteTest**: reference files in case you need to send/receive and convert byte data, e.g., we needed it to communicate with the Robotique Gripper.

* **byteTest_2dArray**: same as byteTest, but includes 2d array
calibrationTest: This is going to be a great place to start. This file should send load 4 different coordinates from the data/3_waypoints_simple.script file in the Processing sketch and then by clicking each button it will take you to that corner, e.g., TL will take you to the Top-Left coordinate. 
  * **Please note:** These coordinates were relative to my set up… so when you click on the button, make sure your other hand is on the Red emergency stop button on the Console for the robot in case you need to quickly hit stop if it’s going to fast, going to far or about to hit something. :)
  * The Robot class is the basics needed to convert a string over to a URScript. In more advanced cases, I enhanced this class so that it became the Server and the Client was the drawing app.
  * You’ll need to enter your own HOST and PORT address… although for the latter, it’s possible it will be the same. The assumption here is that you’ve either connected the UR-5 to the network via Ethernet or that your laptop is plugged in directly into the UR-5. To do the latter, you can use a standard ethernet cable.

* **drawingLinesTest**: This is a simple example that draws dynamic lines and converts the pixels to various lengths including mm… which will be necessary in the final application. 
* **gethostipadudress**: This test script will be necessary for more complex applications when you need to dynamically define your IP address.


The following 2 folders contain various sketches. The 01 Creative apps are the Client and the 02 Robot apps act as the Server. The Client app is where the creative experience and UI exist and in turn pass that data to the Server app to convert, format and send that data to the robot. 

To run, you’ll want to 
turn on and go through the boot up process with the UR5
to play it safe, you’ll probably hand to raise the end (wrist) of the UR5 about 2-3 feet from the surface the robot arm is mounted to
you’ll always want to open and run one of the Server app in 02 Robot first to establish communication with the robot
after the robot app is running without any errors, open and run one of the creative apps

There are a few constraints that are nice to know about, most of which hopefully have been resolved with this code. Here’s a few from what I can recall:
At a single time, you can send not more than 8,000 lines of code to the UR5 before it crashes. If it does crash, it requires a reboot.
The Server app sends a set of path data to robot in batches, where each batch is sent after either a certain amount of time has past, after the robot stops moving or, in this case, after the robot stops moving for a certain amount of time. The robot isn’t smart enough to tell us when it has finished running the code we sent it so we have to monitor its movements, set a timer for when it’s stopped moving and check again to see if it’s still stopped. If it still isn’t moving, then we send it another batch of paths, which I refer to as brushstrokes. 
There’s a limit to the throughput size of data you can send from the Client to Server app via the socket connection. To overcome this challenge, in more advanced apps with the potential to send tons of data in short bursts, I write the path data to a separate file for each burst and send the path and name of the file to the server app which adds that to a queue which is runs as soon as the UR5 is ready for the next batch.


## 01 Creative (client app)
CreativeApp_PerpLines: (Remember to launch the 02 Robot/Processing/RobotApp 1st) This client app records the path you’re creating by clicking-n-dragging the cursor and draws perpendicular lines to it. Clicking on the Make Magic button sends the perp line data to the robot app via a socket connection. Please note the IO class is used for calibrating the TL, BR, BL and TR positions of the robot so that it knows the boundaries of the area to draw in. In this example, the GUI class does not include buttons to calibrate these positions, but later apps will.
CreativeApp_Scotty:  (Remember to launch the 02 Robot/Processing/RobotApp 1st) This app imports coordinates from a text file, converts it and sends it to the robot app. The PathData class contains a list of the drawingFiles which are located in data/ folder.
The ExtendScripts for Adobe Illustrator folder contains an ExtendScript to convert and export simple line drawings to a compatible text file. 
Note: The format of the text file is important… including the empty line at the end of the file.
CreativeApp_Watercolor_multiplePoints: (Remember to launch the 02 Robot/Processing/RobotApp 1st)  

## 02 Robot (server app)

RobotApp: 
Classes
RobotApp: Loads and defines main libraries and instances for the Robot and Gripper. The Gripper we used was the Robotique Gripper. This code can be commented out if you’re not using the same. This class establishes the socket connections as well.
Calibration: This class includes the GUI used for calibrating the TL, TR, BL, BR corners as well as the ability to save and load this points (savePts, loadPts) between sessions.
Gripper: Sends/receives and converts data to/from the Gripper and this app.
Robot: Sends/receives and converts data to/from the Robot and this app. 
Note: Don’t forget to set your IP address in line 6 & 7 relative to your setup. ;)
RobotFeedback: Manages the feedback from the robot including joint positions, velocities++, more of which are documented as comments in the code.
RobotMessage: Sends data to the robot as a message
SocketConnection: Client/server setup.
URScript: Formats path data being sent to the robot into a URScript
Utils: Gets IP address, handles data and unit conversions


Ok! Always hold on to your red emergency cut off button on the console for the robot when running any apps and good luck!

These files… technically belong to Autodesk… so you might want to use them as reference and create your own set from them. 

Please let me know if you have any questions. 

Woohoo!
Drew