import requests
from bs4 import BeautifulSoup as bs

requests.adapters.DEFAULT_RETRIES = 10


class Paper:
    def __init__(self, name, url):
        self.name = name
        self.url = url

    def __str__(self):
        return f"{self.name}({self.url})"


def get_list(url):
    list = []
    soup = bs(requests.get(
        url,
        headers={
            'User-Agent':
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36'
        }).content, 'html.parser')
    for item in soup.find('ul', attrs={'class': 'paperslist'}).find_all('a'):
        list.append(Paper(item.text.strip(), url +
                    item.attrs['href'].replace(" ", "%20").replace("/", "") + "/"))
    return list


def download(name, url):
    with open(name, 'wb') as f:
        f.write(requests.get(
            url,
            headers={
                'User-Agent':
                'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36'
            }).content)


def loop(url):
    print()
    print("Choose an item from the following list:")
    print("Input 0 to QUIT")
    print()
    main_page = get_list(url)
    for counter, item in enumerate(main_page):
        print(f"{counter + 1}. {item.name}")
    print()
    choice = int(input()) - 1
    if choice != -1 and main_page[choice].name.find("pdf") == -1 and main_page[choice].name.find("docx") == -1:
        loop(main_page[choice].url)
    elif main_page[choice].name.find("pdf") != -1 or main_page[choice].name.find("docx") != -1:
        download(main_page[choice].name, main_page[choice].url[:-1])


loop("https://papers.gceguide.com/")
