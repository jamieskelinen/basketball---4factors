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
P_TOVp = 100 * P(:,9)./(P(:,9)+0.44*P(:,6)+P(:,10))
Opp_TOVp = 100 * P(:,19)./(P(:,19)+0.44*P(:,16)+P(:,20))
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
P_REBp= 100 * P(:,7)./(P(:,7)+P(:,8))
Opp_REBp= 100 * P(:,17)./(P(:,17)+P(:,18))
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


% Basic Possession Formula=0.96*[(Field Goal Attempts)+(Turnovers)+0.44*(Free Throw Attempts)-(Offensive Rebounds)]
% What are the .44 and .96 Multipliers?
% .44 multiplier has to be taken into account because not all free throws take up a possession.
% Technical foul shots along with “and 1’s” do not, while there are more than two free throws on one possession with a three-shot foul.
% Research has determined that about 44% of all free throws take up possessions.
% The .96 multiplier accounts for Team offensive rebounds in situations where a missed shot is tipped out of bounds by a defensive player,
% continuing the possession without an offensive rebound being credited.
%poss = 0.96*(0.44*(P(:,6)+P(:,16))-(P(:,7)+P(:,17))+P(:,9)+P(:,19)+P(:,10)+P(:,20))/2
%figure()
%plot(n,poss,"-or")
%axis([0 napu(1)+1 50 120])
%grid()
%title ("Pace")
%xlabel("Game")
%ylabel("Possessions")

% 3P shots per 100 possessions
%P_3ppp = 100 * P(:,4)./poss
%Opp_3ppp = 100 * P(:,14)./poss
%figure()
%plot(n,Opp_3ppp,"-ob;Opponent;",P_3ppp,"-or;Team;")
%axis([0 napu(1)+1 0 100])
%grid()
%title ("3P shots per 100 possessions")
%xlabel("Game")
%ylabel("3P Shots")


P_eFGp_m = mean(P_eFGp)
P_eFGp_d = sqrt(var(P_eFGp))

P_TOVp_m = mean(P_TOVp)
P_TOVp_d = sqrt(var(P_TOVp))

P_REBp_m = mean(P_REBp)
P_REBp_d = sqrt(var(P_REBp))

P_FTGp_m = mean(P_FTGp)
P_FTGp_d = sqrt(var(P_FTGp))

%P_poss_m = mean(poss)
%P_poss_d = sqrt(var(poss))

%P_3ppp_m = mean(P_3ppp)
%P_3ppp_d = sqrt(var(P_3ppp))

% Team Per 100 Posse Stats
%P_pp100p = sum(P(:,1)*2+P(:,3)*3+P(:,5))/sum(poss)*100

% Opponent Per 100 Poss Stats
%O_pp100p = sum(P(:,11)*2+P(:,13)*3+P(:,15))/sum(poss)*100
