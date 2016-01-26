// Processing v.2 code for the UR-5: initially developed March 2014 
// at the Applied Research Lab in the Office of the CTO at Autodesk
// by Maurice Conti, Stéphane Bersot, and Dr. Woohoo!

import java.nio.ByteBuffer;

void setup(){
  byteTest();
}

void byteTest(){
  // Number of bytes for an int
  int size = 4;
  // Int array to encode
  int[] data = { 100, 200, 300, 1000 }; 
  // Size is 4*4 = 16 bytes to encode 4 integers
  ByteBuffer byteBuffer = ByteBuffer.allocate(data.length * size);
  
  //Encode
  for(int i=0; i < data.length; i++){
    byteBuffer.putInt(i*size,  data[i]);
  }
  
  //Decode
  for(int i=0; i < data.length; i++){
    //We get 4 bytes at the time to read integers one by one
    byte[] byteBufferTemp = new byte[size];
    byteBuffer.get(byteBufferTemp, 0, size);
    int intByte = ByteBuffer.wrap(byteBufferTemp).getInt();
    println(intByte);
  }
}