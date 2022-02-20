import httplib2

a_file = open("wpfuxx.txt", "r")

wplist = []
for line in a_file:
  stripped_line = line.strip()
  line_list = stripped_line.split(",")
  wplist.append(line_list)

a_file.close()

domain = input('Input Domain: ')


for dir in wplist:
  strdir= "".join(map(str, dir))
  url = 'https://' + domain +'/' + strdir
  #print("URL:"+url)
  ht = httplib2.Http()


  resp = ht.request(url, 'HEAD')


  if int(resp[0]['status'])  == 200:
      print("URL:"+url)
      print("Response Code: "+resp[0]['status'])

  #else:
      
      #print("Response Code: "+resp[0]['status'])


   
