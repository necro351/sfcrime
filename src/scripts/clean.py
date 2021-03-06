#!/usr/bin/python

from collections import namedtuple
import re;
import sys
import time
import fileinput

# Example input:
line = """2003-01-06 00:31:00,"OTHER, OFFENSES","DRIVERS LICENSE, SUSPENDED OR REVOKED",Monday,RICHMOND,"ARREST, CITED",CLEMENT ST / 14TH AV,-122.472984835661,37.7825523645525"""

Example = namedtuple("Example", "time day district block street gpslat gpslon crime")
Address = namedtuple("Address", "block street")
districts = {}
crimes = {}
addresses = {}
numGroups = 10
a = re.compile("(\d\d\d\d-\d\d-\d\d) (\d\d:\d\d:\d\d)," # date and time
               "((?:[^,\"]+)|(?:\"(?:[^\"]+)\")),"      # crime
               "((?:[^,\"]+)|(?:\"(?:[^\"]+)\")),"      # description
               "(Monday|Tuesday|Wednesday|Thursday|"    
               "Friday|Saturday|Sunday),"               # day of week
               "([a-zA-Z0-9]*),"                        # district 
               "((?:[^,\"]+)|(?:\"(?:[^\"]+)\")),"      # resolution
               "((?:[^,\"]+)|(?:\"(?:[^\"]+)\")),"      # address
               "(-?\d+\.\d+),(-?\d+.\d+)")              # GPS coordinate

#b = re.compile("(.+) (?:(?:Block of (.+))|(?:/ (.+)))") # block and street pairs
b = re.compile("(.+) (?:(?:Block of)|(?:/(?: (.+))?))")

def classify(member, classes):
    memberCategory = -1
    if member in classes:
        memberCategory = classes[member]
    else:
        memberCategory = len(classes)
        classes[member] = memberCategory
        if classes is crimes:
            with open('/src/sfcrime/crimeNames.m', 'a') as f:
                f.write("'{:s}';\n".format(member))
    return memberCategory

def parseAddress(address):
    found = b.match(address)
    if not found:
        raise SyntaxError("address did not match: '" + address + "'")
    groups = found.groups()
    if len(groups) != 2:
        raise SyntaxError("did not find two groups as expected")
    return Address(groups[0], groups[1])

def parse(line):
    found = a.match(line)
    if not found:
        raise SyntaxError("line did not match: '" + line + "'")
    groups = found.groups()
    if len(groups) != numGroups:
        raise SyntaxError("unexpected number of groups, want {0}, got {1}".format(numGroups, len(groups)))
    curTime = time.strptime(groups[0] + " " + groups[1], "%Y-%m-%d %H:%M:%S")
    address = parseAddress(groups[7])
    return Example(time.mktime(curTime),
                   curTime.tm_mday,
                   classify(groups[5], districts),
                   classify(address.block, addresses),
                   classify(address.street, addresses),
                   float(groups[8]),
                   float(groups[9]),
                   classify(groups[2], crimes))

def main():
    with open('/src/sfcrime/crimeNames.m', 'a') as f:
        f.truncate(0)
        f.write("crimeNames=[\n")
    for line in fileinput.input():
        example = parse(line)
        print('{:f},{:d},{:d},{:d},{:d},{:f},{:f},{:d}'.format(example.time,
              example.day, example.district, example.block, example.street,
              example.gpslat, example.gpslon, example.crime))
    with open('/src/sfcrime/crimeNames.m', 'a') as f:
        f.write("];\n")

if __name__ == "__main__":
    main()
