/* Created by Hollis Kim.

*/

#include <SimpleTimer.h>
#include <SPI.h>
#include <Pixy.h>

#define MOTOR_LEFT_A 4
#define MOTOR_LEFT_B 5
#define MOTOR_LEFT_PWM 9

#define MOTOR_RIGHT_A 6
#define MOTOR_RIGHT_B 7
#define MOTOR_RIGHT_PWM 10

#define RC_CH_1 11
#define RC_CH_2 13

#define DIR_FORWARD 1
#define DIR_BACKWARD 2
#define BRAKE 3

#define MOTOR_LEFT 1
#define MOTOR_RIGHT 2

//#define MAX_MOTOR_SPEED 255
#define MAX_MOTOR_SPEED 100
#define MIN_MOTOR_SPEED 50

#define CAM_WIDTH_MAX      300
#define CAM_WIDTH_MIN      50

#define CAM_MAX_X      319
#define CAM_CENTER_X   109

SimpleTimer timer;
Pixy pixy;

int ch1;
int ch2;

float manual_speed;       // cacluated speed get from RC controler, -1 ~ 1 range.
float manual_direction;   // cacluated direction get from RC controler, -1 ~ 1 range.

float pixy_speed;       // speed came from Pixy, -1 ~ 1 range.
float pixy_direction;   // direction came from Pixy, -1 ~ 1 range.
float pixy_speed_ratio = 0.0f;

// vector x, y-axis to Avoid obstacle.  Range -1.0 ~ 1.0
// y-axis is front/back way, x-axis is left/right side.
// This vector is aim to opposit direciton of the sensor's face direction.
// The value of dot-matrix(sqrt(x^2 + y^2)) reflect the distance of obstacle.
float sonar_y;   
float sonar_x;

float final_speed;       // final calculated speed.
float final_direction;   // Final calculated direciton.

void setup() {
  Serial.begin(9600);

  pinMode(MOTOR_LEFT_A, OUTPUT);
  pinMode(MOTOR_LEFT_B, OUTPUT);
  //pinMode(MOTOR_LEFT_PWM, OUTPUT);
  
  pinMode(MOTOR_RIGHT_A, OUTPUT);
  pinMode(MOTOR_RIGHT_B, OUTPUT);
  //pinMode(MOTOR_RIGHT_PWM, OUTPUT);

  pinMode(RC_CH_1, INPUT); // Set remode control input channel 1
  pinMode(RC_CH_2, INPUT); // Set remode control input channel 2

  pixy_speed_ratio = (CAM_WIDTH_MAX - CAM_WIDTH_MIN)/2;
  pixy.init();

  timer.setInterval(100, getManualInput);
  timer.setInterval(500, getPixyInput);
  timer.setInterval(100, calcuSpeedDirection);
  timer.setInterval(100, setMotorSpeed);
  timer.setInterval(100, plot);
}



void getManualInput(){
  int input1 = pulseIn(RC_CH_1, HIGH, 25000); // Read the pulse width of 
  int input2 = pulseIn(RC_CH_2, HIGH, 25000); // each channel

  if(input1 != 0){
    ch1 = input1;
  }

  if(input2 != 0){
    ch2 = input2;
  }

  float manual_direction = (ch2 - 1500) / 500.f;
  float manual_speed = (ch1 - 1500) / 500.f;

//  Serial.print(ch1);
//  Serial.print("   |   ");
//
//  Serial.print(ch2);
//  Serial.print("   |   ");
}


void getPixyInput(){
  static int i = 0;
  int j;
  uint16_t blocks;
  char buf[32];
  float x = 0.0f;
  float y = 0.0f;
  float width = 0.0f;
  float height = 0.0f;
  float center = 0.0f;

  // grab blocks!
  blocks = pixy.getBlocks();

  // If there are detect blocks, print them!
  if (blocks)
  {
    // do this (print) every 50 frames because printing every
    // frame would bog down the Arduino
//      sprintf(buf, "Detected %d:\r\n", blocks);
//      Serial.print(buf);
      for (j=0; j<blocks; j++)
      {
//        sprintf(buf, "  block %d: ", j);
//        Serial.print(buf);
//        pixy.blocks[j].print();
//        Serial.print('\r');

        x = min(pixy.blocks[j].x, x);
        y = min(pixy.blocks[j].y, y);
        width = max(pixy.blocks[j].width, width);
        height = max(pixy.blocks[j].height, height);
      }

      center = x + (width*0.5);
      pixy_speed = ((width - CAM_WIDTH_MIN)/pixy_speed_ratio - 1.0f)*-1.0f;

//      pixy_speed *= 0.2f;

      pixy_speed = max(pixy_speed, -1.0f);
      pixy_speed = min(pixy_speed, 1.0f);

//      Serial.print("pixy_speed :");
//      Serial.println(pixy_speed);
  }
  else{
    pixy_speed = 0.0f;
  }

}

#define Kp 1.2
#define Ki 0.01
#define Kd 0.00002
#define dt 0.01

double prev_err = 0.0;
double sum_err = 0.0;
double I_err = 0.0;


void calcuSpeedDirection(){

  // Apply dir/speed get from rc remote.
  final_direction = (manual_direction + final_direction) * 0.5f;
  final_speed = (manual_speed + final_speed) * 0.5f;


  double current_val;
  double err;
  double D_err;
  double Kp_term, Ki_term, Kd_term;

  err = pixy_speed - final_speed;
  sum_err += err;
  Kp_term = Kp * err;
  Ki_term = Ki * sum_err;
  Kd_term = Kd * (err - prev_err);

  prev_err = err;

  final_speed =  Kp_term + Ki_term + Kd_term; 

  final_direction = 0.0f;
//  final_speed += (pixy_speed - final_speed) * 0.8f;

  // Apply dir/speed get from obstacle sensor.

 }

 void plot() {
  Serial.print(manual_speed);
  Serial.print(" ");
  Serial.print(manual_direction);
  Serial.print(" ");
  Serial.print(pixy_speed);
  Serial.print(" ");
  Serial.print(pixy_direction);
  Serial.print(" ");
  Serial.print(final_speed);
  Serial.print(" ");
  Serial.print(final_direction);
  Serial.println();
 }
 

 void setMotorSpeed(){

  int motor_L;
  int motor_R;

  if(final_direction > 0){
    motor_L = (int)(final_speed * MAX_MOTOR_SPEED);
    motor_R = (int)(final_speed * (1.0f - final_direction) * MAX_MOTOR_SPEED);
  }
  else{
    motor_L = (int)(final_speed * (1.0f + final_direction) * MAX_MOTOR_SPEED);
    motor_R = (int)(final_speed * MAX_MOTOR_SPEED);    
  }

  motor_L = min(motor_L, MAX_MOTOR_SPEED);
  motor_R = min(motor_R, MAX_MOTOR_SPEED);

  motor_L = max(motor_L, -MAX_MOTOR_SPEED);
  motor_R = max(motor_R, -MAX_MOTOR_SPEED);


//  Serial.print(motor_L);
//  Serial.print(" | ");
//  Serial.print(motor_R);
//
//  Serial.println();

  if(-MIN_MOTOR_SPEED < motor_L && motor_L < MIN_MOTOR_SPEED){
//    motor(MOTOR_LEFT, 0);
  }
  else{
//    motor(MOTOR_LEFT, motor_L);
  }

  if(-MIN_MOTOR_SPEED < motor_R && motor_R < MIN_MOTOR_SPEED){
//    motor(MOTOR_RIGHT, 0);
  }
  else{
//    motor(MOTOR_RIGHT, motor_R);
  }

}



void loop() {

  timer.run();
}



/*
 * Control motor method.
 * Side : which motor(LEFT of RIGHT)
 * Speed : 0 - 255
 * Dir : Direction of spinning.
 */
void motor(int side, int speed)
{
//Serial.println("...1");
  int pwm;
  int pinA;
  int pinB;
  int dir;

  if(speed < 0){
    dir = DIR_BACKWARD;
  }
  else{
    dir = DIR_FORWARD; 
  }
  
  if(side == MOTOR_LEFT){
    //Serial.println("...2");
    pwm = MOTOR_LEFT_PWM;  
    pinA = MOTOR_LEFT_A;
    pinB = MOTOR_LEFT_B;
    //Serial.println("...3");
  }
  else{
    pwm = MOTOR_RIGHT_PWM;
    pinA = MOTOR_RIGHT_A;
    pinB = MOTOR_RIGHT_B;
  }

  switch(dir){
    case DIR_FORWARD:
    //Serial.println("...4");
      digitalWrite(pinA, HIGH);
      digitalWrite(pinB, LOW);
      //Serial.println("...5");
      break;
      
    case DIR_BACKWARD:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, HIGH);
      break;
    
    case BRAKE:
      digitalWrite(pinA, LOW);
      digitalWrite(pinB, LOW);
      break;

    default:
      break;
  }

//Serial.println("...6");
  analogWrite(pwm, speed);
  //Serial.println("...7");
}

