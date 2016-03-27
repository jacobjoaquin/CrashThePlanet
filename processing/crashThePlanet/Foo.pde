class Foo extends Demo {
	int nFrames = 64;
	float phase = 0.0;
	float phaseInc = 1 / float(nFrames);

	void update() {
		phase += phaseInc;
		phase -= (int) phase;
	}

	void display() {
		stroke(128);
		float r = 5;
		pushMatrix();
		translate(width / 2.0, height / 2.0);
		float thisPhase = 1 - phase;
		float r2 = r;
		while (r2 < 300) {
			stroke(thisPhase * 256);
			ellipse(0, 0, r2 * 2, r2 * 2);
			r2 *= 1.25;
			thisPhase += 0.1;
			thisPhase -= (int) thisPhase;
		}
		popMatrix();
	}
}