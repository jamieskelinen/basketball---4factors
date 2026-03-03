% ====================== FOUR FACTORS ==========================================================================================================
%
% How do basketball Teams win games?
% While searching for an answer to that question, Dean Oliver identified what he called the "Four Factors of Basketball Success":
%
% Shooting (40%)
% Turnovers (25%)
% Rebounding (20%)
% Free Throws (15%)
%
%The number in parentheses is the approximate weight Mr. Oliver assigned each factor.

% DATA
P = load('stat_line_data.txt')
napu = size(P)
n = [1:napu(1)]'

% Basic Possession Formula=0.(Field Goal Attempts)+(Turnovers)+0.44*(Free Throw Attempts)-(Offensive Rebounds)
% .44 multiplier has to be taken into account because not all free throws take up a possession.
% Technical foul shots along with “and 1’s” do not, while there are more than two free throws on one possession with a three-shot foul.
% Research has determined that about 44% of all free throws take up possessions.
poss = (0.44*(P(:,6)+P(:,16))-(P(:,7)+P(:,17))+P(:,9)+P(:,19)+P(:,10)+P(:,20))/2
figure()
plot(n,poss,"-or")
axis([0 napu(1)+1 0 120])
grid()
title ("Pace")
xlabel("Game")
ylabel("Possessions")

% Offensive / Defensive rating
ORtg = 100 * (P(:,1)*2+P(:,3)*3 + P(:,5))./poss
DRtg = 100 * (P(:,11)*2+P(:,13)*3 + P(:,15))./poss
figure()
plot(n,ORtg,"-or;Team;",DRtg,"-ob;Opponent;")
axis([0 napu(1)+1 0 180])
grid()
title ("Offensive rating")
xlabel("Game")
ylabel("ORtg")

NetRtg = sum(ORtg - DRtg)/napu(1)

% Shooting
% The shooting factor is measured using Effective Field Goal Percentage (eFG%).
% The formula for both offense and defense is (FG + 0.5 * 3P) / FGA.
P_eFGp = 100 * (P(:,1)+1.5*P(:,3))./P(:,10)
Opp_eFGp = 100 * (P(:,11)+1.5*P(:,13))./P(:,20)
figure()
plot(n,Opp_eFGp,"-ob;Opponent;",P_eFGp,"-or;Team;")
axis([0 napu(1)+1 0 100])
grid()
title ("Shooting")
xlabel("Game")
ylabel("eFG%")

% Turnovers
% The turnover factor is measured using Turnover Percentage (TOV%).
% The formula for both offense and defense is TOV / (FGA + 0.44 * FTA + TOV).
P_TOVp = 100 * P(:,9)./(P(:,9)+0.44*P(:,6)+P(:,10)-P(:,7))
Opp_TOVp = 100 * P(:,19)./(P(:,19)+0.44*P(:,16)+P(:,20)-P(:,17))
figure()
plot(n,Opp_TOVp,"-ob;Opponent;",P_TOVp,"-or;Team;")
axis([0 napu(1)+1 0 100])
grid()
title ("Turnovers")
xlabel("Game")
ylabel("TOV%")

% Rebounding
% The rebounding factor is measured using Offensive and Defensive Rebound Percentage (ORB% and DRB%, respectively).
% The formula for offense is ORB / (ORB + Opp DRB), while the formula for defense is DRB / (Opp ORB + DRB).
P_REBp= 100 * P(:,7)./(P(:,7)+P(:,18))
Opp_REBp= 100 * P(:,17)./(P(:,17)+P(:,8))
figure()
plot(n,Opp_REBp,"-ob;Opponent;",P_REBp,"-or;Team;")
axis([0 napu(1)+1 0 100])
grid()
title ("Rebounding")
xlabel("Game")
ylabel("ORB%")

% Free Throws
% The free throw factor is a measure of both how often a Team gets to the line and how often they make them.
% The formula for both offense and defense is FT / FGA.
P_FTGp= 100 * P(:,5)./P(:,10)
Opp_FTGp= 100 * P(:,15)./P(:,20)
figure()
plot(n,Opp_FTGp,"-ob;Opponent;",P_FTGp,"-or;Team;")
axis([0 napu(1)+1 0 100])
grid()
title ("Free Throws")
xlabel("Game")
ylabel("FT/FGA")




