import numpy as np
import matplotlib.pyplot as plt

# ====================== FOUR FACTORS ======================================================
# Dean Oliver's "Four Factors of Basketball Success": Shooting (40%), Turnovers (25%), Rebounding (20%), Free Throws (15%)

def analyze_four_factors(file_path):
    # --------------------- DATA ---------------------
    P = np.loadtxt(file_path)  # Load stat line data
    napu = P.shape
    n = np.arange(1, napu[0]+1)  # Game numbers

    # --------------------- Basic Possession Formula ---------------------
    poss = (0.44*(P[:,5]+P[:,15]) - (P[:,6]+P[:,16]) + 
            P[:,8]+P[:,18] + P[:,9]+P[:,19]) / 2

    plt.figure()
    plt.plot(n, poss, 'or')
    plt.axis([0, napu[0]+1, 0, 120])
    plt.grid(True)
    plt.title("Pace")
    plt.xlabel("Game")
    plt.ylabel("Possessions")
    plt.show()

    # --------------------- Offensive / Defensive Rating ---------------------
    ORtg = 100 * (P[:,0]*2 + P[:,2]*3 + P[:,4]) / poss
    DRtg = 100 * (P[:,10]*2 + P[:,12]*3 + P[:,14]) / poss

    plt.figure()
    plt.plot(n, ORtg, '-or', label='Team')
    plt.plot(n, DRtg, '-ob', label='Opponent')
    plt.axis([0, napu[0]+1, 0, 180])
    plt.grid(True)
    plt.title("Offensive rating")
    plt.xlabel("Game")
    plt.ylabel("ORtg")
    plt.legend()
    plt.show()

    NetRtg = np.sum(ORtg - DRtg) / napu[0]
    print(f"Net Rating: {NetRtg:.2f}")

    # --------------------- Shooting ---------------------
    P_eFGp = 100 * (P[:,0] + 1.5*P[:,2]) / P[:,9]
    Opp_eFGp = 100 * (P[:,10] + 1.5*P[:,12]) / P[:,19]

    plt.figure()
    plt.plot(n, Opp_eFGp, '-ob', label='Opponent')
    plt.plot(n, P_eFGp, '-or', label='Team')
    plt.axis([0, napu[0]+1, 0, 100])
    plt.grid(True)
    plt.title("Shooting")
    plt.xlabel("Game")
    plt.ylabel("eFG%")
    plt.legend()
    plt.show()

    # --------------------- Turnovers ---------------------
    P_TOVp = 100 * P[:,8] / (P[:,8] + 0.44*P[:,5] + P[:,9] - P[:,6])
    Opp_TOVp = 100 * P[:,18] / (P[:,18] + 0.44*P[:,15] + P[:,19] - P[:,16])

    plt.figure()
    plt.plot(n, Opp_TOVp, '-ob', label='Opponent')
    plt.plot(n, P_TOVp, '-or', label='Team')
    plt.axis([0, napu[0]+1, 0, 100])
    plt.grid(True)
    plt.title("Turnovers")
    plt.xlabel("Game")
    plt.ylabel("TOV%")
    plt.legend()
    plt.show()

    # --------------------- Rebounding ---------------------
    P_REBp = 100 * P[:,6] / (P[:,6] + P[:,17])
    Opp_REBp = 100 * P[:,16] / (P[:,16] + P[:,7])

    plt.figure()
    plt.plot(n, Opp_REBp, '-ob', label='Opponent')
    plt.plot(n, P_REBp, '-or', label='Team')
    plt.axis([0, napu[0]+1, 0, 100])
    plt.grid(True)
    plt.title("Rebounding")
    plt.xlabel("Game")
    plt.ylabel("ORB%")
    plt.legend()
    plt.show()

    # --------------------- Free Throws ---------------------
    P_FTGp = 100 * P[:,4] / P[:,9]
    Opp_FTGp = 100 * P[:,14] / P[:,19]

    plt.figure()
    plt.plot(n, Opp_FTGp, '-ob', label='Opponent')
    plt.plot(n, P_FTGp, '-or', label='Team')
    plt.axis([0, napu[0]+1, 0, 100])
    plt.grid(True)
    plt.title("Free Throws")
    plt.xlabel("Game")
    plt.ylabel("FT/FGA")
    plt.legend()
    plt.show()

# Example usage
if __name__ == "__main__":
    analyze_four_factors('stat_line_data.txt')
