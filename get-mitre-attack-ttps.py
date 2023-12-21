import collections
import json
import re
import time
import requests
from bs4 import BeautifulSoup


def get_tid(t):
    return t["href"].replace("/techniques/", "").replace("/", ".")


def get_techniques(techniques_url, tac):
    soup = BeautifulSoup(requests.get(techniques_url).text, features="html.parser")
    techs = soup.find_all("a", href=re.compile("techniques/T"))
    techs = [t for t in techs if not re.match(r"T?\.?\d+$", t.text.strip())]
    techniques = [t for t in techs if "." not in get_tid(t)]
    techniques = {get_tid(t): t.text.strip() for t in techniques}
    sub_techniques = [t for t in techs if "." in get_tid(t)]
    sub_techniques = {get_tid(t): t.text.strip() for t in sub_techniques}
    result = collections.OrderedDict()
    for sub_tid, name in sub_techniques.items():
        tid = re.sub(r"\..*", "", sub_tid)
        if tid not in techniques:
            continue
        result[sub_tid] = {
            "Tactic": tac,
            "Technique": techniques[tid],
            "Sub-Technique": name
        }
    for tid, name in techniques.items():
        result[tid] = {
            "Tactic": tac,
            "Technique": name,
            "Sub-Technique": "-"
        }
    return result


if __name__ == '__main__':
    start_time = time.time()
    base_url = "https://attack.mitre.org/tactics/enterprise"
    soup = BeautifulSoup(requests.get(base_url).text, features="html.parser")
    tactics_links = soup.find_all("a", href=re.compile("tactics/TA"), string=lambda s: "TA" not in s)
    mitre_json = {}
    tactics_names = []
    for tac in tactics_links:
        tid = str(tac['href']).replace("/tactics/", "")
        url = f"{base_url.replace('/enterprise', '/')}{tid}"
        name = tac.text.strip()
        techniques = get_techniques(url, name)
        tactics = collections.OrderedDict()
        tactics[tid] = {
            "Tactic": name,
            "Technique": "-",
            "Sub-Technique": "-"
        }
        tactics_names.append(name)
        mitre_json = mitre_json | tactics
        mitre_json = mitre_json | techniques
    with open('mitre-attack.json', 'w') as f:
        json.dump(mitre_json, f, indent=4, sort_keys=True)
    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"elapsed_time: {elapsed_time:.2f} seconds")