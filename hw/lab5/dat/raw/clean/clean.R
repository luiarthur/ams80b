dat = read.csv("../INC01.csv", sep=';')
small_dat = dat[,c('Area_name', 'INC110179D', 'INC110189D', 'INC110199D')]

mast = read.csv("../Mastdata.csv", sep=';')

raw_id = colnames(small_dat)[-1]
id = sapply(raw_id, function(rid) as.character(mast[which(mast['Item_Id']==rid),'Item_Description']))
id = sapply(id, function(x) gsub(' ', '_', x))

new_dat = small_dat
idx = sapply(as.character(dat[,1]), function(x) grepl(',', x))
new_dat = small_dat[idx, ]
colnames(new_dat)[-1] = id
new_dat[,'Abv'] = sapply(as.character(new_dat[,1]), function(x) substr(x, nchar(x)-1, nchar(x)))

write.table(new_dat, 'INC01_clean.csv', quote=F, sep=';', row.names=F)
