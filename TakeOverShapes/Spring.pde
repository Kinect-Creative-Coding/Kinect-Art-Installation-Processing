
public class Spring {
 
    private float rest_value;     // Value that the spring eventually go back to when there's no force applied
    private float current_value;  // Current value of the spring
    private float target_value;   // Target value that the force is being applied towards
    
    // Object Properties
    private float mass;           // Mass
    
    // Spring Properties 
    private float k;    // Spring constant
    private float damp;           // Damping
    
    // Spring Physics, which are all re-calculated every time we apply a new force
    private float velocity = 0.0; // Velocity
    
    Spring(float rest_value, float mass, float k, float damp) {
        this.rest_value = this.current_value = this.target_value = rest_value;
        this.mass = mass;
        this.k = k;
        this.damp = damp;
    }
    
    void setTargetValue(float new_target_value) {
      target_value = new_target_value;
    }
    
    void resetTargetValue() {
      target_value = rest_value;
    }
    
    float getRestValue() {
      return rest_value;
    }
    
    float applyForceTowardsTarget() {
        float force = -k * (current_value - target_value);  // f=-ky
        float accel = force / mass;                         // Set the acceleration, f=ma
        velocity = damp * (velocity + accel);               // Set the velocity
        current_value = current_value + velocity;           // Update current value
        return current_value;
    }
}
