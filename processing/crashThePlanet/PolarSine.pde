class PolarSine extends Demo {
	float phase = 0.0;
	float phaseInc = 1 / 256.0;
	int nArcs = 9;
	float dInc = 8;
	int c0 = 255;
	int c1 = 0;
	float period = 0.125;
	float innerRingSize = 4;
	float outerRingSize = 330;

	void update() {
		phase += phaseInc;
		phase -= (int) phase;
	}

	PolarSine() {
	}

	PolarSine(int nArcs, float innerRingSize, int phaseInc, float period, int c0, int c1) {
		this.nArcs = nArcs;
		this.innerRingSize = innerRingSize;
		this.outerRingSize = outerRingSize;
		this.phaseInc = phaseInc;
		this.period = period;
		this.c0 = c0;
		this.c1 = c1;
	}

	void display() {
		stroke(127);
		float d = innerRingSize;
		float unit = 1 / (float) nArcs;
		float counter = 0;

		pushMatrix();
		translate(width / 2.0, height / 2.0);
		float outerPhase = phase;

		while (d < outerRingSize) {
			for (int i = 0; i < nArcs; i++) {
				float innerPhase = outerPhase + i;
				pushMatrix();		
				float n = i * unit;
				float a = n * TAU;

				rotate(a);
				stroke(c0);
				if (counter % 2 == 0) {
					rotate(unit * TAU * 0.5);
					innerPhase += 0.5;
					stroke(c1);
				}
				float totalPhase = phase + innerPhase + outerPhase;
				while(totalPhase > 1) {
					totalPhase -= 1;
				}
				float a1 = map(sin(TAU * totalPhase), -1, 1, 0, 1) * unit * 2.5;
				a1 = max(a1, 0.01);
				PVector p0 = PVector.fromAngle(-a1).mult(d);
				PVector p1 = PVector.fromAngle(a1).mult(d);
				line(p0, p1);
				popMatrix();
				innerPhase += n;
			}  
			d += dInc;
			counter++;
			outerPhase += unit * period;
		}
		popMatrix();
	}
}