import java.io.File;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

class VstRecorder extends DisplayableBase {
	Vst vst;
	String filename;
	private File file;
	private FileOutputStream fileOutputStream;
	private boolean isRecording = false;

	VstRecorder(Vst vst, String filename) {
		this.vst = vst;
		this.filename = filename;
	}

	void update() {
		if (isRecording) {
			write();
		}
	}

	void beginRecord() {
		isRecording = true;
		file = new File(sketchPath("") + filename);
		try {
			fileOutputStream = new FileOutputStream(file, false);
		}
		catch (FileNotFoundException e) {
			println(e);
		}
		catch (IOException e) {
			println(e);
		}
	}

	void endRecord() {
		isRecording = false;
		try {
			fileOutputStream.close();
		}
		catch (IOException e) {
			println(e);
		}
	}

	private void write() {
		try {
			fileOutputStream.write(vst.buffer.buffer, 0, vst.buffer.bufferByteCount);
			fileOutputStream.flush();
		}
		catch (FileNotFoundException e) {
			println(e);
		}
		catch (IOException e) {
			println(e);
		}
	}
}

class VstPlayback extends DisplayableBase {
	Vst vst;
	String filename;
	private File file;
	private FileInputStream fileInputStream;
	private boolean isRecording = false;

	VstPlayback(Vst vst, String filename) {
		this.vst = vst;
		this.filename = filename;
		init();
	}

	private void init() {
		file = new File(sketchPath("") + filename);
		try {
			fileInputStream = new FileInputStream(file);
		}
		catch (FileNotFoundException e) {
			println(e);
		}
		catch (IOException e) {
			println(e);
		}
	}

	void update() {
	}

	void display() {
		// Send Byte Data Vst
	}

	void close() {
		try {
			fileInputStream.close();
		}
		catch (IOException e) {
			println(e);
		}
	}
}
