

/* Created by Hollis Kim.

*/

#include <SimpleTimer.h>
#include <SPI.h>
#include <Pixy.h>

#define MOTOR_LEFT_A 7//4
#define MOTOR_LEFT_B 8//5
#define MOTOR_LEFT_PWM 5//9

#define MOTOR_RIGHT_A 9//6
#define MOTOR_RIGHT_B 10//7
#define MOTOR_RIGHT_PWM 6//10

#define RC_CH_1 11
#define RC_CH_2 13

#define DIR_FORWARD 1
#define DIR_BACKWARD 2
#define BRAKE 3

#define MOTOR_LEFT 1
#define MOTOR_RIGHT 2

//#define MAX_MOTOR_SPEED 255
//#define MAX_MOTOR_SPEED 70
#define MAX_MOTOR_SPEED 150
#define MIN_MOTOR_SPEED 50

#define CAM_WIDTH_MAX      100
#define CAM_WIDTH_MIN      20

#define CAM_MAX_X      320
#define CAM_CENTER_X   (160)

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

int motor_L;
int motor_R;

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

  timer.setInterval(10, getManualInput);
  timer.setInterval(10, getPixyInput);
  timer.setInterval(10, calcuSpeedDirection);
  timer.setInterval(10, setMotorSpeed);
  timer.setInterval(10, plot);
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
  float sizeMax = 0.0f;
  float center = 0.0f;

  // grab blocks!
  blocks = pixy.getBlocks();

  // If there are detect blocks, print them!
  if (blocks)
  {

      for (j=0; j<blocks; j++)
      {
//        sprintf(buf, "  block %d: ", j);
//        Serial.print(buf);
//        pixy.blocks[j].print();
//        Serial.print('\r');

        x += pixy.blocks[j].x;
        sizeMax = max(pixy.blocks[j].width, pixy.blocks[j].height);
      }

      // Serial.println(sizeMax);

      center = (x/(float)blocks);
      
      pixy_direction = (center - CAM_CENTER_X) / (float)CAM_CENTER_X;

      if( abs(pixy_direction) < 0.5f){
        pixy_speed = ((sizeMax - CAM_WIDTH_MIN)/pixy_speed_ratio - 1.0f)*-1.0f;
        pixy_speed = max(pixy_speed, -1.0f);
        pixy_speed = min(pixy_speed, 1.0f);        
      }
      else{
        if(pixy_speed == 0.0f){
          pixy_speed == 0.2f;
        }
      }

  }
  else{
    pixy_speed = 0.0f;
  }

}

#define Kp 0.1
#define Ki 0.2
#define Kd 0.001
#define dt 0.01

double prev_err_speed = 0.0;
double sum_err_speed = 0.0;

double prev_err_dir = 0.0;
double sum_err_dir = 0.0;


void calcuSpeedDirection(){

  // Apply dir/speed get from rc remote.
  final_direction = (manual_direction + final_direction) * 0.5f;
  final_speed = (manual_speed + final_speed) * 0.5f;


  double err;
  double Kp_term, Ki_term, Kd_term;

  err = pixy_speed - final_speed;
  sum_err_speed += err;
  Kp_term = Kp * err;
  Ki_term = Ki * sum_err_speed;
  Kd_term = Kd * (err - prev_err_speed);

  prev_err_speed = err;
  final_speed =  Kp_term + Ki_term + Kd_term; 


  err = pixy_direction - final_direction;
  sum_err_dir += err;
  Kp_term = Kp * err;
  Ki_term = Ki * sum_err_dir;
  Kd_term = Kd * (err - prev_err_dir);

  prev_err_dir = err;
  final_direction =  Kp_term + Ki_term + Kd_term; 

  

//  final_speed = min(1.0, final_speed);
//  final_speed = max(0, final_speed);

  final_direction = pixy_direction;
//  final_speed += (pixy_speed - final_speed) * 0.8f;

  // Apply dir/speed get from obstacle sensor.

 }

 void plot() {
//  Serial.print(manual_speed*10);
//  Serial.print(" ");
//  Serial.print(manual_direction*10);
//  Serial.print(" ");
  Serial.print(pixy_speed*10);
  Serial.print(" ");
//  Serial.print(pixy_direction*10);
//  Serial.print(" ");
  Serial.print(final_speed*10);
  Serial.print(" ");
//  Serial.print(final_direction*10);
//  Serial.print(" ");
//  Serial.print(motor_L*0.1);
//  Serial.print(" ");
//  Serial.print(motor_R*0.1);
//  Serial.print(" ");
//  Serial.print("0.0 ");
  Serial.println();
 }
 

 void setMotorSpeed(){


  if(final_direction > 0){
    motor_L = (int)(final_speed * 0.5f * (1.0f - (final_direction *0.3f)) * MAX_MOTOR_SPEED);
    motor_R = (int)(final_speed * 0.5f * MAX_MOTOR_SPEED);
  }
  else{
    motor_L = (int)(final_speed * 0.5f * MAX_MOTOR_SPEED);    
    motor_R = (int)(final_speed * 0.5f * (1.0f + (final_direction* 0.3f)) * MAX_MOTOR_SPEED);
  }

//    motor_L = (int)(final_speed * 0.5f * MAX_MOTOR_SPEED);
//    motor_R = (int)(final_speed * 0.5f * MAX_MOTOR_SPEED);

  motor_L = min(motor_L, MAX_MOTOR_SPEED);
  motor_R = min(motor_R, MAX_MOTOR_SPEED);

  motor_L = max(motor_L, -MAX_MOTOR_SPEED);
  motor_R = max(motor_R, -MAX_MOTOR_SPEED);

//  motor_L = max(motor_L, 0);
//  motor_R = max(motor_R, 0);


  if(-MIN_MOTOR_SPEED < motor_L && motor_L < MIN_MOTOR_SPEED){
    motor_L = 0;
  }

  if(-MIN_MOTOR_SPEED < motor_R && motor_R < MIN_MOTOR_SPEED){
    motor_R = 0;
  }

//  motor(MOTOR_LEFT, motor_L);
//  motor(MOTOR_RIGHT, motor_R);

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
      digitalWrite(pinA, HIGH);
      digitalWrite(pinB, LOW);
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

  analogWrite(pwm, speed);
}

