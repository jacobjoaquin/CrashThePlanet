class CircleThing extends Demo {
	int nFrames = 256;
	float phase = 0.0;
	float phaseInc = 1 / float(nFrames);
	float phase2 = 0.0;
	float phase2Inc = phaseInc * 1.333;

	void update() {
		phase += phaseInc;
		phase -= (int) phase;
		phase2 += phase2Inc;
		phase2 -= (int) phase2;
	}

	void display() {
		// stroke(128);
		float r = width / 8.0;
		pushMatrix();
		translate(width / 2.0, height / 2.0);
		float thisPhase = 1 - phase;
		float thisPhase2 = 1 - phase2;
		float r2 = r;
		while (r2 <= 330) {
			stroke(max(0, sin(thisPhase * TAU) * 256));
			float s = r2 * 2;
			ellipse(sin(thisPhase2 * TAU) * r * 0.25, 0, s, s);			

			r2 *= 1.125;
			thisPhase += 0.05;
			thisPhase -= (int) thisPhase;
			thisPhase2 += 0.03333;
			thisPhase2 -= (int) thisPhase2;
		}
		popMatrix();
	}
}