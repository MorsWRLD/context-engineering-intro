class RewardEngine:
    BASE_XP_RATE = 10  # per 10 minutes
    BASE_CREDIT_RATE = 5

    def calculate(self, minutes, mode="chill", streak_days=0):
        xp = (minutes // 10) * self.BASE_XP_RATE
        credits = (minutes // 10) * self.BASE_CREDIT_RATE

        if mode == "grind":
            xp *= 2  # grind doubles XP
            credits = int(credits * 1.5)

        # Streak bonus (5% per day)
        streak_bonus = 1 + (0.05 * streak_days)
        xp = int(xp * streak_bonus)
        credits = int(credits * streak_bonus)

        return {"xp": xp, "credits": credits}
