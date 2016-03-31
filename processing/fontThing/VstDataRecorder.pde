import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.ByteArrayOutputStream;
import java.io.BufferedWriter;
import java.io.Writer;
import java.io.FileWriter;
import java.io.FileReader;
import java.util.Scanner;

class VstDataRecorder extends DisplayableBase  {
	Vst vst;
	String filename;
	private File file;
	//private FileOutputStream fileOutputStream;
	private BufferedWriter bufferedWriter;
	private boolean isRecording = false;

	VstDataRecorder(Vst vst, String filename) {
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
			Writer writer = new FileWriter(file);
            bufferedWriter = new BufferedWriter(writer);
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
			bufferedWriter.close();
		}
		catch (IOException e) {
			println(e);
		}
	}

	private void write() {
		try {
			StringBuffer sb = vst.buffer.toCSV();
			sb.append("\n");
			bufferedWriter.write(sb.toString());
			bufferedWriter.flush();
		}
		catch (FileNotFoundException e) {
			println(e);
		}
		catch (IOException e) {
			println(e);
		}
	}
}

class VstDataPlayback extends DisplayableBase {
	Vst vst;
	String filename;
	private File file;
	private BufferedReader bufferedReader;

	VstDataPlayback(Vst vst, String filename) {
		this.vst = vst;
		this.filename = filename;
		loadFile();
	}

	void loadFile() {
		file = new File(sketchPath("") + filename);
		try {
			close();  // Close file if already open
			bufferedReader = new BufferedReader(new FileReader(file));
		}
		catch (FileNotFoundException e) {
			println(e);
		}
		catch (IOException e) {
			println(e);
		}

	}

	void update() {
		VstBuffer vb = new VstBuffer();
		try {
			String line = bufferedReader.readLine();
			if (line != null) {
				String[] values = line.split(",");
				int length = values.length;
				for (int i = 0; i < length; i += 3) {
					int x = Integer.parseInt(values[i]);
					int y = Integer.parseInt(values[i + 1]);
					int z = Integer.parseInt(values[i + 2]);
					vb.add(new VstPoint(x, y, z));
				}
			}
			else {
				loadFile();
			}
		} catch (IOException e) {
			println(e);
		}
		vst.buffer.addAll(vb);
	}

	void display() {
	}

	void close() {
		try {
			bufferedReader.close();
		}
		catch (IOException e) {
			println(e);
		}
		catch (Exception e) {
			println(e);
		}
	}
}