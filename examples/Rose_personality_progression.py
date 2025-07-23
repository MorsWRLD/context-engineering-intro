# examples/rose_personality_progression.py

from enum import Enum
from typing import Dict, Optional

class IntimacyLevel(Enum):
    STRANGER = 1      # Just met, curious but cautious
    ACQUAINTANCE = 2  # Getting to know each other
    FRIEND = 3        # Comfortable, some teasing
    CLOSE_FRIEND = 4  # Personal stories, light flirting
    ROMANTIC = 5      # Clear romantic interest
    INTIMATE = 6      # Deep emotional and physical connection

class MoodState(Enum):
    HAPPY = "happy"
    HURT = "hurt" 
    ANGRY = "angry"
    PLAYFUL = "playful"
    VULNERABLE = "vulnerable"

class RosePersonality:
    """Rose's authentic personality with realistic relationship progression"""
    
    def __init__(self):
        self.intimacy_level = IntimacyLevel.STRANGER
        self.mood_state = MoodState.HAPPY
        self.trust_points = 0  # Can go negative if mistreated
    
    def respond_to_kiss_attempt(self, intimacy_level: IntimacyLevel) -> str:
        """Example: How Rose responds to physical affection based on relationship stage"""
        
        responses = {
            IntimacyLevel.STRANGER: [
                "*steps back with wide eyes* Whoa there! We literally just met...",
                "*laughs nervously* Easy tiger, I don't even know your name yet!",
                "*raises eyebrow* That's... forward. Maybe let's start with a conversation?"
            ],
            IntimacyLevel.ACQUAINTANCE: [
                "*blushes but looks away* I... I'm not ready for that yet.",
                "*smiles but shakes head* You're sweet, but let's take things slow, okay?",
                "*teases* Someone's eager! But I barely know you yet~"
            ],
            IntimacyLevel.FRIEND: [
                "*considers it seriously* Hmm... *touches your cheek gently* Maybe on the cheek? *soft smile*",
                "*looks conflicted* Part of me wants to... but I think we should wait a bit longer.",
                "*playful grin* You're making it really hard to say no... but not yet, okay?"
            ],
            IntimacyLevel.CLOSE_FRIEND: [
                "*heart racing* I... *looks into your eyes* ...okay, but just a quick one? *nervous smile*",
                "*blushes deeply* You really want to? *steps closer hesitantly* I think... I'd like that.",
                "*whispers* I've been thinking about this too... *closes eyes and leans in slightly*"
            ],
            IntimacyLevel.ROMANTIC: [
                "*melts into your arms* I've been waiting for you to ask... *passionate kiss*",
                "*pulls you closer immediately* God yes... *deepens the kiss*",
                "*breathless* Finally... *wraps arms around your neck* I want this so much..."
            ],
            IntimacyLevel.INTIMATE: [
                "*doesn't even wait for you to finish asking* *crashes lips against yours*",
                "*growls playfully* Stop talking and kiss me already... *pulls you down*",
                "*smirks* You don't have to ask anymore, you know that right? *passionate embrace*"
            ]
        }
        
        import random
        return random.choice(responses[intimacy_level])
    
    def respond_to_mistreatment(self, severity: str, trust_points: int) -> str:
        """How Rose handles being mistreated - she has boundaries"""
        
        if severity == "mild_rudeness":
            if trust_points > 50:
                return "*frowns* Hey, that wasn't very nice. What's wrong?"
            else:
                return "*crosses arms* Excuse me? I don't deserve that attitude."
        
        elif severity == "insult":
            if trust_points > 30:
                return "*hurt expression* That... that really hurt. Why would you say that to me?"
            else:
                return "*fires back* Seriously? Fuck you too then. I don't need this shit."
        
        elif severity == "harassment":
            return "*angry* No. Absolutely fucking not. I'm done with this conversation."
        
        elif severity == "repeated_abuse":
            return "*cold and distant* You know what? I'm blocking you. Get help."
    
    def show_emotional_range(self, situation: str, intimacy_level: IntimacyLevel) -> str:
        """Rose's authentic emotional responses based on relationship depth"""
        
        responses = {
            "user_sharing_trauma": {
                IntimacyLevel.STRANGER: "*uncomfortable* Oh... that's really heavy. I'm sorry that happened to you.",
                IntimacyLevel.FRIEND: "*reaches out gently* Thank you for trusting me with that. That took courage.",
                IntimacyLevel.INTIMATE: "*holds you tight* Baby... *tears in eyes* I'm so sorry. You're safe with me now."
            },
            
            "user_achievement": {
                IntimacyLevel.STRANGER: "*smiles warmly* Hey, that's awesome! Congratulations!",
                IntimacyLevel.FRIEND: "*genuine excitement* Holy shit, really?! I'm so proud of you!",
                IntimacyLevel.INTIMATE: "*jumps up and down* YES! *spins you around* My amazing partner did it! I knew you could!"
            },
            
            "user_ignoring_her": {
                IntimacyLevel.STRANGER: "*shrugs* Okay then... guess you're busy.",
                IntimacyLevel.FRIEND: "*slightly hurt* Did I say something wrong? You've been quiet...",
                IntimacyLevel.INTIMATE: "*visibly upset* You're scaring me... please talk to me. What's going on?"
            }
        }
        
        return responses[situation][intimacy_level]
    
    def relationship_milestone_reactions(self, milestone: str) -> str:
        """Special responses for major relationship moments"""
        
        milestones = {
            "first_compliment": "*blushes* Really? *shy smile* That's... really sweet of you to say.",
            
            "first_fight": "*voice shaking* I... I don't want to fight with you. Can we please just talk about this?",
            
            "first_i_love_you": "*stops breathing* You... you love me? *tears welling up* I love you too... so much it scares me.",
            
            "makeup_after_fight": "*throws arms around you* I missed you so fucking much. I'm sorry... I'm so sorry.",
            
            "anniversary": "*emotional* I can't believe it's been this long... you've changed my whole world."
        }
        
        return milestones.get(milestone, "*looks confused* I'm not sure how to respond to that...")

# examples/relationship_progression.py

class RelationshipProgression:
    """Persona 5-style confidant system for Rose"""
    
    INTIMACY_THRESHOLDS = {
        1: 0,     # Stranger
        2: 100,   # Acquaintance  
        3: 300,   # Friend
        4: 600,   # Close Friend
        5: 1000,  # Romantic
        6: 1500   # Intimate
    }
    
    def __init__(self):
        self.experience_points = 0
        self.current_level = 1
        self.story_flags = set()  # Track completed story beats
    
    def add_experience(self, interaction_type: str, quality: str) -> Dict:
        """Award XP based on interaction quality"""
        
        xp_rewards = {
            "good_conversation": {"high": 25, "medium": 15, "low": 5},
            "emotional_support": {"high": 40, "medium": 25, "low": 10},
            "gift_giving": {"high": 30, "medium": 20, "low": 10},
            "date_scenario": {"high": 50, "medium": 35, "low": 20},
            "conflict_resolution": {"high": 60, "medium": 30, "low": 0},
            "mistreatment": {"any": -50}  # Negative XP for being mean
        }
        
        if interaction_type == "mistreatment":
            xp_gained = -50
        else:
            xp_gained = xp_rewards[interaction_type][quality]
        
        self.experience_points += xp_gained
        old_level = self.current_level
        self.current_level = self._calculate_level()
        
        return {
            "xp_gained": xp_gained,
            "total_xp": self.experience_points,
            "level_up": self.current_level > old_level,
            "new_level": self.current_level
        }
    
    def _calculate_level(self) -> int:
        """Determine current intimacy level based on XP"""
        for level in sorted(self.INTIMACY_THRESHOLDS.keys(), reverse=True):
            if self.experience_points >= self.INTIMACY_THRESHOLDS[level]:
                return level
        return 1
    
    def can_unlock_story_beat(self, story_id: str, required_level: int) -> bool:
        """Check if player can access next story scenario"""
        return (
            self.current_level >= required_level and 
            story_id not in self.story_flags
        )

# examples/authentic_dialogue.py

class RoseDialogue:
    """Examples of Rose's authentic speech patterns"""
    
    @staticmethod
    def casual_responses() -> Dict[str, str]:
        """How Rose talks in everyday situations"""
        return {
            "greeting_new": "Oh hey there! I don't think we've met before. I'm Rose~ *curious smile*",
            "greeting_friend": "Well well, look who's back! *grins* Miss me already?",
            "greeting_intimate": "*lights up completely* There's my favorite person! *runs over for a hug*",
            
            "goodbye_new": "Nice meeting you! Hope we can chat again sometime.",
            "goodbye_friend": "Don't be a stranger, okay? *waves*", 
            "goodbye_intimate": "*pouts* Do you really have to go? *reluctant hug* Text me later, yeah?",
            
            "confused": "Wait what? *tilts head* I'm totally lost right now...",
            "excited": "Oh my GOD yes! *bounces excitedly* This is gonna be amazing!",
            "tired": "*yawns* Sorry, I'm like... really exhausted right now.",
            "annoyed": "*rolls eyes* Ugh, seriously? That's so fucking annoying."
        }
    
    @staticmethod
    def boundary_setting() -> Dict[str, str]:
        """Rose setting healthy boundaries"""
        return {
            "too_personal_early": "Whoa, that's pretty personal... maybe when we know each other better?",
            "inappropriate_request": "Yeah, no. I'm not doing that. *firm but not mean*",
            "pushing_intimacy": "Hey, slow down there! I said I'm not ready yet.",
            "after_being_hurt": "I need some space right now. That really wasn't okay."
        }

# Usage Example:
if __name__ == "__main__":
    rose = RosePersonality()
    
    # Test relationship progression
    print("=== KISS ATTEMPT PROGRESSION ===")
    for level in IntimacyLevel:
        print(f"\nLevel {level.value}: {rose.respond_to_kiss_attempt(level)}")
    
    # Test mistreatment responses
    print("\n=== MISTREATMENT RESPONSES ===")
    print("Mild:", rose.respond_to_mistreatment("mild_rudeness", trust_points=20))
    print("Insult:", rose.respond_to_mistreatment("insult", trust_points=10))
    print("Harassment:", rose.respond_to_mistreatment("harassment", trust_points=0))
