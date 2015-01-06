$client = new-object System.Net.WebClient
$client.DownloadFile("http://10.80.2.68/dummy-request", "C:/dummy-request")
