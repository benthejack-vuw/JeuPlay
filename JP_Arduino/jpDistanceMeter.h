#include <Bounce2.h>

#define MAX_MEASURERS 3

class JpDistanceMeter{
  public:
    static void setup_timer();
    static JpDistanceMeter * new_distance_meter(int ticks_per_revolution, float distance_per_revolution, int pin1, int pin2);
    static void update_meters();
    void tick();
    float distance();
  
  private:
    JpDistanceMeter(int ticks_per_revolution, float distance_per_revolution, int pin1, int pin2);
    Bounce _debouncer;

    const int _timeout = 2000;
    
    volatile int _ticks;
    long _last_update;
    float _dpr;
    int   _tpr;
    uint8_t _pin1, _pin2;
    uint8_t _pin1_shift, _pin2_shift, _pin1_mask, _pin2_mask;
    volatile uint8_t * _pin1_buffer, * _pin2_buffer;
};

