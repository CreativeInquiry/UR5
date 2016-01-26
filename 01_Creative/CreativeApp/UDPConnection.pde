// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!


// import UDP library
import hypermedia.net.*;

class UDPConnection {

  UDP udp;  
    
  public void initConnection(PApplet parent, int udpPort, String udpHost) {  
    // create a multicast UDP connection on port 6000 and join the group at the address "224.0.0.1"
    udp = new UDP( parent, udpPort, udpHost);
    // wait constantly for incoming data
    udp.listen( true );
    // ... well, just verifies if it's really a multicast socket and blablabla
    println( "init as multicast socket ... "+udp.isMulticast() );
    println( "joins a multicast group  ... "+udp.isJoined() );    
  }

  void encodeData(ArrayList <PathData> brushStrokes, Boolean cp5Init){
    // Q: Why 4? 
    int byteCount = brushStrokes.size() * 6 * 4; // 6 int in each stroke
    
    println("byteCount: " +byteCount);
    ByteBuffer byteBuffer = ByteBuffer.allocate(byteCount);
        
    for (int i = 0; i < brushStrokes.size(); i++) {
      PathData brushStroke = brushStrokes.get(i);
            
      float[] args = brushStroke.getArgs();
      
      for(int j=0; j < args.length; j++){
        float pixel = args[j];
        
        // Convert the pixels to mm
        float mm = pixelsToMM( pixel );
        float m = mmToMeters( mm );
        // println(i+": " +j+" pixel: " + pixel + ", mm: " + mm);
        
        // Add the values to the byteBuffer
        // Q: Why 4? 
        byteBuffer.putFloat(i*6*4 + j*4,  m);
      }
    }
    if (cp5Init) sendData(byteBuffer);
  
    decodeUdpData(byteBuffer);
  }

  // UDP MAGIC
  void sendData(ByteBuffer byteBuffer){
    // by default if the ip address and the port number are not specified, UDP 
    // send the message to the joined group address and the current socket port.    
    udp.send( byteBuffer.array() ); // = send( data, group_ip, port );
    
    // note: by creating a multicast program, you can also send a message to a
    // specific address (i.e. send( "the messsage", "192.168.0.2", 7010 ); )
  }

  /**
   * This is the program receive handler. To perform any action on datagram 
   * reception, you need to implement this method in your code. She will be 
   * automatically called by the UDP object each time he receive a nonnull 
   * message.
   */   
  void decodeUdpData(ByteBuffer byteBuffer) {
    byte[] bytes = byteBuffer.array();
    
    for(int i=0; i < bytes.length; i+=4){
      float floatByte = ByteBuffer.wrap(partArray(bytes, i, 4)).getFloat();
      // println("CreativeApp: decode: "+i+": " +floatByte);
    } 
  }
  
  byte[] partArray(byte[] source, int start, int size) {
    byte[] part = new byte[size];
    System.arraycopy(source, start, part, 0, size);
    return part;
  }   
}