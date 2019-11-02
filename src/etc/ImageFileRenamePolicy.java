package etc;

import java.io.File;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class ImageFileRenamePolicy implements FileRenamePolicy
{
	@Override
	public File rename(File file)
	{
		String originalFullName = file.getName();
		String originalName = null;
		String extension = null;
		String currentTimeMS = String.valueOf(System.currentTimeMillis());

		int dotIndex = originalFullName.lastIndexOf(".");

		if (dotIndex != -1)
		{
			extension = originalFullName.substring(dotIndex);
		} else
		{
			extension = "";
		}
		originalName = originalFullName.substring(0, dotIndex);

		File changedFile = new File(file.getParent(), originalName + "_" + currentTimeMS + extension);
		file.renameTo(changedFile);

		return changedFile;
	}
}