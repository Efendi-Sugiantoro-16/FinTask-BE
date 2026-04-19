import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

async function main() {
  const username = 'EFENDI_14';
  const newPassword = 'Admin123!';
  const passwordHash = await bcrypt.hash(newPassword, 10);

  const updated = await prisma.user.update({
    where: { username },
    data: { 
      passwordHash,
      role: 'ADMIN' // Ensure role is ADMIN
    },
  });

  console.log(`Password for user ${updated.username} has been reset to: ${newPassword}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
