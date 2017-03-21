function LsysDraw(expansion,delta,len,title)
% LsysDraw: Draw the expanded L-system string using Turtle Graphics
% Inputs:
% expansion == expanded string containing instructions
% delta == scalar incremental angle size in Degrees
% len == length of the base line segments corresponding to the symbols F and G
% colorVar == line color
% Outputs:
% No outputs
% Upper case (e.g. F or G) causes a line to be drawn in the current direction of the turtle
% Lower case causes a move with no draw
% angle +operator means turn left; -operator means turn right
% sample call: LsysDraw(x,25,1,'Title')
% original code at http://courses.cit.cornell.edu/bionb441/LSystem/index.html
% modified by Michael Robinette 2/1/2017

% Init the turtle
xT = 0;
yT = 0;
aT = 0;
da = degtorad(delta); %convert degrees to radians

barLen = len;
cases = {'F','G'};
numericCases = {'0','1','2','3','4','5','6','7','8','9'};

% tracks usage of signs
signTracker = 1;

% init the turtle stack
stkPtr = 1;

% integer multiplier
num = 0;

% helps track integer multipliers
intIndex = 1;

% looking for integers followed by a + or - sign in the expansion
intHit = regexp(expansion,'(\d+)([+-])','Match');

% looking for integers followed by a bar sign
barIntHit = regexp(expansion,'(\d+)([|])','Match');

% helps track depth
d = 1;


hold on

for i=1:length(expansion)
    direction = expansion(i);
    switch direction   
    case cases
        newxT = xT + len*cos(aT);
        newyT = yT + len*sin(aT);
        if (direction == 'G')
            line([yT newyT],[xT newxT],'color','g','linewidth',1);
        end
        if (direction == 'F')
            line([yT newyT],[xT newxT],'color','[.7 .5 0]','linewidth',1);
        end
        xT = newxT;
        yT = newyT;
    case numericCases
        for k=i+1:length(expansion)
            if (expansion(k) == '|')
                break
            end
            if (signTracker == intIndex)
                num = str2double(regexp(intHit{intIndex},'(\d*)','match'));
                break
            end
        end
    case '|' 
        depth = str2double(regexp(barIntHit{d},'(\d*)','match'));
        len = barLen^depth;
        newxT = xT + len*cos(aT);
        newyT = yT + len*sin(aT);
        line([yT newyT],[xT newxT],'color','[.7 .5 0]','linewidth',1);
        xT = newxT;
        yT = newyT;
        d = d+1;
    case '+'
        if (num > 0)
            aT = aT + num*da;
            signTracker = signTracker + 1;
            intIndex = intIndex + 1;
            num = 0;
        else
             aT = aT + da;
        end 
    case '-'
        if (num > 0)
            aT = aT - num*da;
            signTracker = signTracker + 1;
            intIndex = intIndex + 1;
            num = 0;
        else
             aT = aT - da;
        end
    case '[' %push the stack
        stack(stkPtr).xT = xT ;
        stack(stkPtr).yT = yT ;
        stack(stkPtr).aT = aT ;
        stkPtr = stkPtr +1 ;
    case ']' %pop the stack
        stkPtr = stkPtr -1 ;
        xT = stack(stkPtr).xT ;
        yT = stack(stkPtr).yT ;
        aT = stack(stkPtr).aT ;
    otherwise
        disp('error')
        return
    end
end

axis equal;
set(gcf,'numbertitle','off','name',title); 
figure(gcf);

end
