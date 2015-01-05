$client = new-object System.Net.WebClient
$client.DownloadFile("http://st05.uk.xensource.com:80/finished", "C:/finished")
