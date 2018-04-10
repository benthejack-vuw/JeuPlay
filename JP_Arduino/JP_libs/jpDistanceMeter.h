#include <Bounce2.h>
#include "fastPin.h"

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
    FastPin *_pin1, *_pin2;
};

