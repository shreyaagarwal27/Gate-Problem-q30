const int A_LED = 11;   // Input A  -- LED indicator
const int B_LED = 9;   // Input B  -- LED indicator
const int Y_LED = 10;   // Output X -- LED indicator
 
void setup()
{
    pinMode(A_LED, OUTPUT);
    pinMode(B_LED, OUTPUT);
    pinMode(Y_LED, OUTPUT);
    Serial.begin(9600);
    Serial.println("A  B  X (XNOR)");
}
 
void loop()
{
    for (int i = 0; i < 4; i++)
    {
        int A = (i >> 1) & 1;  // Extract bit 1
        int B =  i       & 1;  // Extract bit 0
 
        // XNOR: output HIGH when A == B
        int X = (A == B) ? 1 : 0;
 
        digitalWrite(A_LED, A);   // Show current A on LED
        digitalWrite(B_LED, B);   // Show current B on LED
        digitalWrite(Y_LED, X);   // Show XNOR output on LED
 
        Serial.print(A); Serial.print("  ");
        Serial.print(B); Serial.print("  ");
        Serial.println(X);
 
        delay(1000);            // Hold for 1 second
    }
}
