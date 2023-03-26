using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    [SerializeField] private float horizontal;
    [SerializeField] private float speed = 8f;
    [SerializeField] private float jumpingPower = 16f;
    [SerializeField] private bool isFacingRight = true;

    [SerializeField] private Rigidbody2D rb;
    [SerializeField] private Transform groundCheck;
    [SerializeField] private Animator anim;
    [SerializeField] private LayerMask groundLayer;

    private State _state;
    private State state
    {
        get => _state;

        set
        {
            _state = value;

            if(_state == State.run)
            {
                anim.SetBool("RUN", true);
                anim.SetBool("JUMP", false);
                anim.SetBool("IDLE", false);
                
            } else if(_state == State.idle)
            {
                anim.SetBool("IDLE", true);
                anim.SetBool("RUN", false);
                anim.SetBool("JUMP", false);
                
            } else if(_state == State.jump)
            {
                anim.SetBool("JUMP", true);
                anim.SetBool("RUN", false);
                anim.SetBool("IDLE", false);
                
            }
        }
    }

    void Update()
    {
        horizontal = Input.GetAxisRaw("Horizontal");

        if (Input.GetButtonDown("Jump"))
        {
            Jump();
        }


        Flip();
    }

    private void FixedUpdate()
    {
        if(horizontal != 0)
        {
            Run(); 
        }
        else
        {
            StopRunning();
        }
    }

    private bool IsGrounded()
    {
        return Physics2D.OverlapCircle(groundCheck.position, 0.2f, groundLayer);
    }

    private void Flip()
    {
        if (isFacingRight && horizontal < 0f || !isFacingRight && horizontal > 0f)
        {
            isFacingRight = !isFacingRight;
            Vector3 localScale = transform.localScale;
            localScale.x *= -1f;
            transform.localScale = localScale;
        }
    }

    private void Run()
    {
        if (!IsGrounded())
        {
            state = State.jump;
        } else
        {
            state = State.run;
        }
        
        rb.velocity = new Vector2(horizontal * speed, rb.velocity.y);
    }

    private void StopRunning()
    {
        if (!IsGrounded())
        {
            state = State.jump;
        }
        else
        {
            state = State.idle;
        }
        
    }
    

    private void Jump()
    {
        if (IsGrounded())
        {
            rb.velocity = new Vector2(rb.velocity.x, jumpingPower);
            state = State.jump;
        }
        if (rb.velocity.y > 0f)
        {
            rb.velocity = new Vector2(rb.velocity.x, rb.velocity.y * 0.5f);
            state = State.jump;
        }
    }



}

public enum State
{
    idle,
    run,
    jump,
}