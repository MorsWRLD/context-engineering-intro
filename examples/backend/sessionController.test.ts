import request from "supertest";
import express from "express";
import { SessionController } from "./sessionController";

const app = express();
app.use(express.json());
app.post("/start", SessionController.startSession);
app.post("/stop", SessionController.stopSession);

describe("SessionController", () => {
  it("should start a session", async () => {
    const res = await request(app)
      .post("/start")
      .send({ userId: "u1", duration: 25 });
    expect(res.status).toBe(200);
    expect(res.body.active).toBe(true);
  });
});
