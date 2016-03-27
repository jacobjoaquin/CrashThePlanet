import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.FileOutputStream;
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
			appendToFile();
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

	private void appendToFile() {
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