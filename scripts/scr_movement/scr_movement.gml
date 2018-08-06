/// @arg left
/// @arg righht
/// @arg jump
/// @arg sit
/// @arg gravityPower
/// @arg walkSpeed
/// @arg jumpPower
/// @arg max_slp


//	Get Player Input
key_left = keyboard_check(argument0);
key_right = keyboard_check(argument1);
key_jump = keyboard_check(argument2);
sit = keyboard_check(argument3);

//	Set Speed
chr_vspeed += argument4;
chr_hspeed = (key_right - key_left) * argument5;

//	Jump
if (place_meeting(x, y + 1, Block) && (key_jump))
{
	chr_vspeed = -argument6;
}

//	Horizontal Collision
var max_slp = argument7;
repeat (abs(chr_hspeed))
{
    var blk, mov;
    blk = place_meeting(x + sign(chr_hspeed), y, Block);
    mov = false;
    if (blk == true)
    {
		//	climb
        for (var a = 1; a <= max_slp; a++)
        {
            if (place_meeting(x + sign(chr_hspeed), y - a, Block) == false)
            {
                x += sign(chr_hspeed);
                y -= a;
                mov = true;   
                break;
            }
        }
        if (mov == false)
        {
            chr_hspeed = 0;
        }
    }
	else
	{
		//	Down
        for (var a = max_slp; a >= 1; a--)
        {
            if (place_meeting(x + sign(chr_hspeed), y + a, Block) == false)
            {
                if (place_meeting(x + sign(chr_hspeed), y + a + 1, Block) == true)
                {
                    x += sign(chr_hspeed); 
                    y += a;     
                    mov = true;    
                }
            }
        }
        if (mov == false) 
        {
            x += sign(chr_hspeed); 
        }
    }
}

//	Vertical Collision
if (place_meeting(x, y + chr_vspeed, Block))
{
	while (!place_meeting(x, y + sign(chr_vspeed), Block))
	{
		y += sign(chr_vspeed);
	}
	chr_vspeed = 0;
}
y += chr_vspeed;
