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
		stroke(128);
		float r = 5;
		pushMatrix();
		translate(width / 2.0, height / 2.0);
		float thisPhase = 1 - phase;
		float thisPhase2 = 1 - phase2;
		float r2 = r;
		while (r2 <= 250) {
			// stroke(sin(thisPhase * TAU) * 256);
			stroke(map(sin(thisPhase2 * TAU), -1, 1, 1, 255));
			float s = r2 * 2;
			ellipse(0, 0, s, s);
			r2 *= 1.25;
			thisPhase += 0.1;
			thisPhase -= (int) thisPhase;
			thisPhase2 += 0.06125;
			thisPhase2 -= (int) thisPhase2;
		}
		popMatrix();
	}
}