import { Request, Response } from "express";
import { SessionService } from "./sessionService";

export class SessionController {
  static async startSession(req: Request, res: Response) {
    const { userId, duration } = req.body;
    const session = await SessionService.start(userId, duration);
    res.json(session);
  }

  static async stopSession(req: Request, res: Response) {
    const { sessionId } = req.body;
    const session = await SessionService.stop(sessionId);
    res.json(session);
  }

  static async stats(req: Request, res: Response) {
    const { userId } = req.params;
    const stats = await SessionService.getStats(userId);
    res.json(stats);
  }
}
