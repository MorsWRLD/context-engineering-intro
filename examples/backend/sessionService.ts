import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

export class SessionService {
  static async start(userId: string, duration: number) {
    return prisma.session.create({
      data: { userId, duration, active: true, startedAt: new Date() },
    });
  }

  static async stop(sessionId: string) {
    return prisma.session.update({
      where: { id: sessionId },
      data: { active: false, stoppedAt: new Date() },
    });
  }

  static async getStats(userId: string) {
    return prisma.session.findMany({
      where: { userId },
      orderBy: { startedAt: "desc" },
      take: 10,
    });
  }
}
