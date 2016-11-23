quant=45;                                                                   %numero de imagens
media=0;
nclasses=quant/5;
thre=0;
for i=1:quant
     imagem=imread(strcat('foto (',int2str(i),').jpg'));
	 imagem=rgb2gray(imagem);
     media=media+imagem/quant;      
end
a=0;
for cont=1:quant
    imagem=imread(strcat('foto (',int2str(cont),').jpg'));
	imagem=rgb2gray(imagem);                                                                        
    dif=imagem-media;
    for i=1:256                                                                        
         for j=1:256                                                                    
             a(cont,j+256*(i-1))=dif(i,j);
         end
     end
end
l=a*a';
[v,d]=eig( l );
d1 = eig(l);
thre = inv(min(d1));
clear('l','a','cont','imagem','j')
somaomega=0;
cont=0;
cont2=0;
autoface=0;
for n=1:quant
    for i=1:12                                                             %numero de autofaces
		for k=1:quant
            imagem=imread(strcat('foto (',int2str(k),').jpg'));
			imagem=rgb2gray(imagem);
			dif=imagem-media;
			autoface=autoface+(v(i,k)*dif);
        end
		imagem=imread(strcat('foto (',int2str(n),').jpg'));
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
    somaomega=somaomega+omega2/5;
    cont=cont+1;
    if(cont==5)
       cont2=cont2+1;
       save (strcat('classes',int2str(cont2)), 'somaomega');
       cont=0;
       somaomega=0;
    end
end
save variables v d media quant nclasses thre
clear