clc;
nm=0;
mx=0;
for(i=1:1:101)
        
    img=imread('Image3_run4.tif',i);
    imgcrp=img(63:465,112:514);
    mxm=max(max(imgcrp));
    if(mx<mxm)
        mx=mxm;
    end 
end
for(i=1:1:101)
    mr=0;
    rwn=0;
    im=imread('Image3_run4.tif',i);
    imcrp=im(63:465,112:514);
    imrsp=reshape(imcrp,162409,1);
    delay=num2str(((i-73)*420*6.67)/1000);
    for(k=1:1:162409)
         if (imrsp(k)<=400)
             imrsp(k)=0;
         end 
    end    
    im1=reshape(imrsp,403,403);    
    for(j=1:1:403)
             r1=im1(j,:);
            [m n]=size(find(r1>400));
            if(n>mr)
                mr=n;
                rwn=j;
            end
    end
    slrw=im1(rwn,:);
    slrwsmth=smooth(double(slrw));
    figure
    plot((0:402)*0.122,slrwsmth);
    axis([0 49.044 0 mx]);
    xlabel('X length (mm)');
    ylabel('Y length (intensity)');
    title(strcat(num2str(i),'image No & raw No =',num2str(rwn),'Delay =',num2str(delay),'ps'));
    saveas(gcf,strcat(num2str(i),'image No & raw No =',num2str(rwn),'_taken@centre.jpg'));
    csvwrite(horzcat(num2str(i),'image No & raw No =',num2str(rwn),'_taken@centre.txt'),slrw');
    pause;
    close(gcf);       
    end
