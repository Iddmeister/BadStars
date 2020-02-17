shader_type canvas_item;

uniform float pulseWidth = 0.05;
uniform float freq = 1;
uniform float amp = 1;

bool isInPulse(float pos, float t) {
	
	float pulsePos = amp*tan(t*freq);
	
	if ((pos > pulsePos+pulseWidth) || (pos < pulsePos-pulseWidth)) {
		return true;
	} else {
		return false;
	}

	
}

bool isInImage(vec2 uv) {
	
	float len = length(uv-vec2(0.5));
	
	if (len <= 0.5) {
		return true;
	} else {
		return false;
	}
	
	
	return true;
}

void fragment() {
	
	if (isInImage(UV)) {
	
		float len = length(UV-vec2(0.5));
		
		if (isInPulse(len, TIME)) {
			COLOR = texture(TEXTURE, UV)
		} else {
			COLOR = vec4(1, 0, 0, 1)
		}
	} else {
		COLOR = texture(TEXTURE, UV)
	}
	
}

