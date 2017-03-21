function seedGrowth = LsysExpand(numberOfIterations,seed,rules)
% LsysExpand: Expands from starting seed based on given parameters
% Inputs:
% numberOfIterations == number of times rules are applied
% seed == the initial point from which growth occurs
% rules == instructions for substitution
% original code at http://courses.cit.cornell.edu/bionb441/LSystem/index.html
% modified by Michael Robinette 2/1/2017

% check to see if probabilities are being used
usingProbabilities = contains(rules,'.');
if (usingProbabilities(2) == 1)
    usingProbabilities = true;
end

ruleTracker = 1;

if (usingProbabilities == 1)
    for i=1:length(rules)/3
        rulesParsed(i).before = cellstr(rules(ruleTracker));
        probabilities(i) = str2double(rules(ruleTracker+1));
        rulesParsed(i).after = cellstr(rules(ruleTracker+2));
        ruleTracker=ruleTracker+3;
    end
end

if (usingProbabilities == 0)
    for i=1:length(rules)/2
        rulesParsed(i).before = cellstr(rules(ruleTracker));
        rulesParsed(i).after = cellstr(rules(ruleTracker+1));
        ruleTracker=ruleTracker+2;
    end
end

% Tracking growth from the seed.
seedGrowth = seed;
counter = 1;
numberOfRules = length(rulesParsed);

if (usingProbabilities == 1)
    adjustedProbabilities = cumsum(probabilities);
end

    for i=1:numberOfIterations
    
        %one character/cell, with indexes the same as original seed string
        substitutionsList = cellstr(seedGrowth');
    
        for j=1:numberOfRules
            %the indexes of each 'before' string
            hit = strfind(seedGrowth, rulesParsed(j).before);
            if (usingProbabilities == 1)
                randomNumber = rand;
                generatedProbability = find(randomNumber<cumsum(adjustedProbabilities),1,'first');
            end

            if (length(hit)>=1)
                for k=hit
                    depthCounter = int2str(counter);
                    if (usingProbabilities == 1)
                        substitutionsList(k) = rulesParsed(generatedProbability).after;
                        substitutionsList(k) = insertBefore(substitutionsList(k),'|',depthCounter);
                    end
                    if (usingProbabilities == 0)
                        substitutionsList(k) = rulesParsed(j).after;
                        substitutionsList(k) = insertBefore(substitutionsList(k),'|',depthCounter);
                    end
                end
            end
        end
        counter = counter + 1;
   
        %now convert individual cells back to a string
        seedGrowth =[];
        seedGrowth = [seedGrowth,substitutionsList{:}];
        
    end
end    
