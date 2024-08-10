import { BadRequestException, Injectable, PipeTransform } from '@nestjs/common';
import * as path from 'path';
import * as sharp from 'sharp';
import * as fs from 'fs';
import { v4 as uuid } from "uuid"
// Ensure the 'uploads' folder exists
const uploadsDir = path.join(__dirname, process.env.STATIC_FOLDER);
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir, { recursive: true });
}
@Injectable()
export class SharpPipe implements PipeTransform<Express.Multer.File, Promise<string>> {

  async transform(files: Express.Multer.File): Promise<string> {
    const firstFile = files[0]
    if (!firstFile || !firstFile.buffer) {
      throw new Error('No file or file buffer provided');
    }
    const originalName = path.parse(firstFile.originalname).name;
    const filename = uuid(8) + '-' + originalName + '.webp';
    await sharp(firstFile.buffer)
      .resize(800)
      .webp({ effort: 3 })
      .toFile(path.join(process.env.STATIC_FOLDER, filename));

    return filename;
  }


}