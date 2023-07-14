syms y
syms t
syms x
fileid=fopen("input2.txt",'r');
formatSpec= '%f';
formatSpec1= '%f\n';
formatspec2='%s\n';
sizef = [1,1];
f = fscanf(fileid,formatspec2,sizef);
f=str2sym(f);
sizei=[1,2];
ivp = fscanf(fileid,formatSpec1,sizei);
sizefn=[1,1];
fin=fscanf(fileid,formatSpec1,sizefn);
sizeh=[1,1];
h = fscanf(fileid,formatSpec1,sizeh);
sizec=[1,1];
ch = input('Select the method:- \n 1.Euler Forward \n 2.2nd R-K \n 3.4th R-K \n');
%ch=fscanf(fileid,formatSpec1,sizec);
if (ch==1)
    fileID = fopen('output_euler.txt','w');
    n=(fin-ivp(1))/h;
    yo=ivp(2);
    to=ivp(1);
    for i=1:n+1
        yn= yo+h*subs(f,[t y],[to yo]);
        yn=round(yn,8);
   
        sol=[to,yo];
        hold on
        plot(to,yo,"^")
        grid on
        xlabel("t")
        ylabel("y")
        title("euler forward")
        fprintf(fileID,"%f %f\n",sol');
        %fprintf("%f %f\n",sol)
        to=to+h;
        yo=yn;
    end
end
if (ch==2)
    fileID = fopen('output_RK2.txt','w');
    n=(fin-ivp(1))/h;
    yo=ivp(2);
    to=ivp(1);
    for i=1:n+1
        k1=subs(f,[t y],[to,yo]);
        k2=subs(f,[t,y],[to+h/2 yo+k1*h/2]);
        slope=0.5*(k1+k2);
        yn=yo+h*slope;
        yn=round(yn,8);
        sol=[to,yo];
        hold on
        plot(to,yo,"^")
        grid on
        xlabel("t")
        ylabel("y")
        title("2nd Order Runge Kutta")
        %fprintf("%f %f\n",sol)
        fprintf(fileID,"%f %f\n",sol');
        to=to+h;
        yo=yn;
    end
end
if(ch==3) 
    fileID = fopen('output_RK4.txt','w');
    n=(fin-ivp(1))/h;
    yo=ivp(2);
    to=ivp(1);
    for i=1:n+1
        k1=subs(f,[t y],[to,yo]);
        k2=subs(f,[t,y],[to+h/2 yo+k1*h/2]);
        k3=subs(f,[t,y],[to+h/2 yo+k2*h/2]);
        k4=subs(f,[t,y],[to+h yo+k3*h]);
        slope=(k1+2*k2+2*k3+k4)/6;
        yn=yo+h*slope;
        yn=round(yn,8);
        sol=[to,yo];
        hold on
        plot(to,yo,"^")
        grid on
        xlabel("t")
        ylabel("y")
        title("4th Order Runge Kutta")
        %fprintf("%f %f\n",sol)
        fprintf(fileID,"%f %f\n",sol');
        to=to+h;
        yo=yn;
    end
end