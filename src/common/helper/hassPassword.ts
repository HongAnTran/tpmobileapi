import * as bcrypt from "bcrypt";

async function hashPassword(password: string): Promise<string> {
  const saltRounds = 10;
  const salt = await bcrypt.genSalt(saltRounds);
  return bcrypt.hash(password, salt);
}
// Helper function to remove diacritics and special characters
function sanitizeName(name: string): string {
  return name
    .normalize("NFD") // Normalize the string into decomposed form
    .replace(/[\u0300-\u036f]/g, "") // Remove diacritical marks
    .replace(/[^a-zA-Z0-9-_\.]/g, ""); // Remove special characters except for alphanumeric, dashes, underscores, and dots
}
export { hashPassword, sanitizeName };
