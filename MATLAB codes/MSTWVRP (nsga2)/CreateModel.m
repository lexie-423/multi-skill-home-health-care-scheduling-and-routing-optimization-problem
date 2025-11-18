function model=CreateModel()

model.N =10;
model.Puc = 30;
model.Puh = 15;

numskill = 3;

model.docskill = randi([1,2],model.N,1);
model.patskilluc = randi([1,numskill],model.Puc,1);
model.patskilluh = randi([1,numskill],model.Puh,1);

disp(model.docskill);
disp(model.patskilluc);
disp(model.patskilluh);

end


