// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


import java.nio.ByteBuffer;

class RobotFeedback {
  int message_size;       // Total message length in bytes
  double time;            // Time elapsed since the controller was started
  double q_target;        // Target joint positions
  double[] qd_target;     // Target joint velocities
  double[] qdd_target;    // Target joint accelerations
  double[] i_target;      // Target joint currents
  double[] m_target;      // Target joint moments (torques)
  double[] q_actual;      // Actual joint positions
  double[] qd_actual;     // Actual joint velocities
  double[] i_actual;      // Actual joint currents
  double[] tool_accelerometer_values; // Tool x,y and z accelerometer values (software version 1.7)
  double[] unused;        // Unused
  double[] tcp_force;     // Generalised forces in the TCP
  double[] tool_vector;   // Cartesian coordinates of the tool: (x,y,z,rx,ry,rz), where rx, ry and rz is a rotation vector representation of the tool orientation 
  double[] tcp_speed;     // Speed of the tool given in cartesian coordinates
  double[] digital_input_bits; // Current state of the digital inputs. NOTE: these are bits encoded as int64_t, e.g. a value of 5 corresponds to bit 0 and bit 2 set high 
  double[] motor_temperatures; // Temperature of each joint in degrees celcius
  double controller_timer;// Controller realtime thread execution time
  double test_value;      // A value used by Universal Robots software only
  double robot_mode;      // Robot control mode (see PolyScopeProgramServer)
  double[] joint_modes;   // Joint control modes (see PolyScopeProgramServer) (only from software version 1.8 and on)
  
  int[] bytes_size   = { 4, 8, 48, 48, 48, 48, 48, 48, 48, 48, 24, 120, 48, 48, 48, 8, 48, 8, 8, 8, 48 };
  int[] nb_of_values = { 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 3, 15, 6, 6, 6, 1, 6, 1, 1, 1, 6 };
  int[] bytes_start  = { 0, 4, 12, 60, 108, 156, 204, 252, 300, 348, 396, 420, 540, 588, 636, 684, 692, 740, 748, 756, 764 };
  
  byte[] byteBuffer = new byte[812]; //812 are coming from the robot
 
  void computeData(){
    message_size = getDataInt(0);
    time         = getDataDouble(1);
    q_target     = getDataDouble(2);
    qd_target    = getDataDoubleArray(3);
    qdd_target   = getDataDoubleArray(4);
    i_target     = getDataDoubleArray(5);
    m_target     = getDataDoubleArray(6);
    q_actual     = getDataDoubleArray(7);
    qd_actual    = getDataDoubleArray(8);
    i_actual     = getDataDoubleArray(9);
    unused       = getDataDoubleArray(11);
    tcp_force    = getDataDoubleArray(12);
    tool_vector  = getDataDoubleArray(13); //
    tcp_speed    = getDataDoubleArray(14);
    test_value   = getDataDouble(18);
    robot_mode   = getDataDouble(19);
    joint_modes  = getDataDoubleArray(20);
    tool_accelerometer_values = getDataDoubleArray(10);
    digital_input_bits        = getDataDoubleArray(15);
    motor_temperatures        = getDataDoubleArray(16);
    controller_timer          = getDataDouble(17);  
  }
 
   double[] getDataDoubleArray(int index){
     int size  = bytes_size[index]/nb_of_values[index];
     int count = nb_of_values[index];
     int start = bytes_start[index];
     double[] values = new double[count];
     
     for(int i=0; i<count ;i++){
       values[i] = ByteBuffer.wrap(partArray(byteBuffer, start+size*i, size)).getDouble();
     }
     return values;
   }

   double getDataDouble(int index){
     int size  = bytes_size[index];
     int start = bytes_start[index];
     double values;
     
     values = ByteBuffer.wrap(partArray(byteBuffer, start, size)).getDouble();
     return values;
   }
 
   int getDataInt(int index){
     int size  = bytes_size[index];
     int start = bytes_start[index];
     int values;
     
     values = ByteBuffer.wrap(partArray(byteBuffer, start, size)).getInt();
     return values;
   }
 
  byte[] partArray(byte[] source, int start, int size) {
    byte[] part = new byte[size];
    System.arraycopy(source, start, part, 0, size);
    return part;
  }
}