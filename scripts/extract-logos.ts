import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const storageFile = path.join(__dirname, '../data/storage.json');
const storage = JSON.parse(fs.readFileSync(storageFile, 'utf-8'));

// Create partners directory if it doesn't exist
const partnersDir = path.join(__dirname, '../client/public/partners');
if (!fs.existsSync(partnersDir)) {
  fs.mkdirSync(partnersDir, { recursive: true });
}

// Process each partner
storage.partners.forEach((partner: any) => {
  if (partner.logo && partner.logo.startsWith('data:image')) {
    // Extract the base64 data
    const matches = partner.logo.match(/^data:image\/([a-zA-Z]+);base64,(.+)$/);
    if (matches) {
      const extension = matches[1];
      const base64Data = matches[2];
      
      // Create filename from partner name (sanitized)
      const filename = partner.name
        .toLowerCase()
        .replace(/\s+/g, '-')
        .replace(/[^a-z0-9-]/g, '');
      
      const filepath = `${filename}.${extension}`;
      const fullPath = path.join(partnersDir, filepath);
      
      // Write the file
      const buffer = Buffer.from(base64Data, 'base64');
      fs.writeFileSync(fullPath, buffer);
      
      // Update the logo reference in the partner object
      partner.logo = `/partners/${filepath}`;
      
      console.log(`✓ Saved ${partner.name} logo to ${filepath}`);
    }
  }
});

// Write updated storage back to file
fs.writeFileSync(storageFile, JSON.stringify(storage, null, 2));

console.log('\n✓ All logos extracted and storage.json updated!');
