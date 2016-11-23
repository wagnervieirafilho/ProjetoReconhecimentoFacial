% new face's recognition beginning
load variables
autoface=0;
%thre=100000; %57471
omega=0;
omega2=0;
somaomega=0;
%cam;
for i=1:12
		for k=1:quant
            imagem=imread(strcat('foto (',int2str(k),').jpg'));
			imagem=rgb2gray(imagem);
			dif=imagem-media;
			autoface=autoface+(v(i,k)*dif);
        end
        imagem=imread(strcat('teste.jpg'));
        imagem=rgb2gray(imagem);
		dif=imagem-media;        
		omega=times(autoface',dif);                                                  
        for b=1:256                                                                        
            for c=1:256                                                                    
                omega2(i,c+256*(b-1))=omega(b,c);
            end
        end
        autoface=0;
end
clear('b','c','autoface','imagem','dif','omega','k','i','sigautvetor','media')
load classes1;
somaomega=double(somaomega);
e=norm(omega2-somaomega);
a=1;
clear('somaomega');
for i=2:nclasses                                                                  
    load (strcat('classes',int2str(i)));
    somaomega=double(somaomega);
    b=norm(omega2-somaomega);
    if(b<e)
        e=b;
        a=i;
    end
end
%vetor(o)=e;
clear('somaomega');
%if(e<thre)
%   figure
      imshow(strcat('foto (',int2str((a-1)*5+1),').jpg'));
%else
%   imshow('unknown.jpg');
clear
%end