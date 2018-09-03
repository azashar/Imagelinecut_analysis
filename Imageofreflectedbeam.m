clc;
maxi=2000;

x=0.122*(0:402);
y=0.122*(0:402);

for(i=73:1:101)
    
    im=imread('Image3_run4.tif',i);
    imcrp=im(63:465,112:514);
    delay=num2str(((i-73)*420*6.67)/1000);
    
    imgsmth=smooth2(imcrp,5);
    imrsp=reshape(imgsmth,162409,1);
    
    for(k=1:1:162409)
        
         if (imrsp(k)<=400)
             imrsp(k)=0;
         end 
         
    end
    
    im1=reshape(imrsp,403,403);
    figure
    surf(x,y,im1);
    caxis([0 maxi]);
    axis([0 49.044 0 49.044 0 maxi]);
    xlabel('X length (micron)');
    ylabel('Y length (micron)');
    zlabel('Z lenght (Intensity(arb. unit))');
    title(strcat('image No =',num2str(i),' Delay =',num2str(delay),'ps'));
    shading interp;
    view(0,90);
    colorbar; 
    saveas(gcf,strcat('image No =',num2str(i),'_200mJ Bkside imgs_micronscaled.jpg'));
    csvwrite(horzcat('image No =',num2str(i),'_200mJ Bkside imgs_micronscaled.txt'),im1);
    pause;
    close(gcf);
     
    
end