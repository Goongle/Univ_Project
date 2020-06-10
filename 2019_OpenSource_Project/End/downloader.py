#!/usr/bin/env python
from __future__ import print_function
import sys
import os
import time
import json
import requests
import argparse
import lxml.html
import io
from urllib.parse import urlparse, parse_qs
from lxml.cssselect import CSSSelector
YOUTUBE_COMMENTS_URL = 'https://www.youtube.com/all_comments?v={youtube_id}'
YOUTUBE_COMMENTS_AJAX_URL = 'https://www.youtube.com/comment_ajax'
USER_AGENT = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36'
def find_value(html, key, num_chars=2):
    pos_begin = html.find(key) + len(key) + num_chars
    pos_end = html.find('"', pos_begin)
    return html[pos_begin: pos_end]
def extract_comments(html):
    tree = lxml.html.fromstring(html)
    item_sel = CSSSelector('.comment-item')
    text_sel = CSSSelector('.comment-text-content')
    time_sel = CSSSelector('.time')
    author_sel = CSSSelector('.user-name')
    for item in item_sel(tree):
        yield {'cid': item.get('data-cid'),
               'text': text_sel(item)[0].text_content(),
               'time': time_sel(item)[0].text_content().strip(),
               'author': author_sel(item)[0].text_content()}
def extract_reply_cids(html):
    tree = lxml.html.fromstring(html)
    sel = CSSSelector('.comment-replies-header > .load-comments')
    return [i.get('data-cid') for i in sel(tree)]
def ajax_request(session, url, params, data, retries=10, sleep=20):
    for _ in range(retries):
        response = session.post(url, params=params, data=data)
        if response.status_code == 200:
            response_dict = json.loads(response.text)
            return response_dict.get('page_token', None), response_dict['html_content']
        else:
            time.sleep(sleep)
def download_comments(youtube_id, sleep=1):
    session = requests.Session()
    session.headers['User-Agent'] = USER_AGENT
    # Get Youtube page with initial comments
    response = session.get(YOUTUBE_COMMENTS_URL.format(youtube_id=youtube_id))
    html = response.text
    reply_cids = extract_reply_cids(html)
    ret_cids = []
    for comment in extract_comments(html):
        ret_cids.append(comment['cid'])
        yield comment
    page_token = find_value(html, 'data-token')
    session_token = find_value(html, 'XSRF_TOKEN', 4)
    first_iteration = True
    # Get remaining comments (the same as pressing the 'Show more' button)
    while page_token:
        data = {'video_id': youtube_id,
                'session_token': session_token}
        params = {'action_load_comments': 1,
                  'order_by_time': True,
                  'filter': youtube_id}
        if first_iteration:
            params['order_menu'] = True
        else:
            data['page_token'] = page_token
        response = ajax_request(session, YOUTUBE_COMMENTS_AJAX_URL, params, data)
        if not response:
            break
        page_token, html = response
        reply_cids += extract_reply_cids(html)
        for comment in extract_comments(html):
            if comment['cid'] not in ret_cids:
                ret_cids.append(comment['cid'])
                yield comment
        first_iteration = False
        time.sleep(sleep)
    # Get replies (the same as pressing the 'View all X replies' link)
    for cid in reply_cids:
        data = {'comment_id': cid,
                'video_id': youtube_id,
                'can_reply': 1,
                'session_token': session_token}
        params = {'action_load_replies': 1,
                  'order_by_time': True,
                  'filter': youtube_id,
                  'tab': 'inbox'}
        response = ajax_request(session, YOUTUBE_COMMENTS_AJAX_URL, params, data)
        if not response:
            break
        _, html = response
        for comment in extract_comments(html):
            if comment['cid'] not in ret_cids:
                ret_cids.append(comment['cid'])
                yield comment
        time.sleep(sleep)
## input video 값 parsing
def video_id(value):
    query = urlparse(value)
    if query.hostname == 'youtu.be':
        return query.path[1:]
    if query.hostname in ('www.youtube.com', 'youtube.com'):
        if query.path == '/watch':
            p = parse_qs(query.query)
            return p['v'][0]
        if query.path[:7] == '/embed/':
            return query.path.split('/')[2]
        if query.path[:3] == '/v/':
            return query.path.split('/')[2]
    # fail?
    return None
def main():
    #parser = argparse.ArgumentParser(add_help=False, description=('Download Youtube comments without using the Youtube API'))
    #parser.add_argument('--help', '-h', action='help', default=argparse.SUPPRESS, help='Show this help message and exit')
    #parser.add_argument('--youtubeid', '-y', help='ID of Youtube video for which to download the comments')
    #parser.add_argument('--output', '-o', help='Output filename (output format is line delimited JSON)')
    #parser.add_argument('--limit', '-l', type=int, help='Limit the number of comments')
    Youtube_id1 = input('Youtube_ID 입력 :')
    ## Cutting Link를 받고 id만 딸 수 있도록
    Youtube_id2 = Youtube_id1
    Youtube_id1 = video_id(Youtube_id1)
    youtube_id = Youtube_id1
    try:
        # args = parser.parse_args(argv)
        #youtube_id = args.youtubeid
        #output = args.output
        #limit = args.limit
        result_List = []
    ## input 값을 받고 값에 할당
    ## Limit에 빈 값이 들어갈 경우 Default 값으로 100을 넣게 하였음
        if not youtube_id :
            #parser.print_usage()
            #raise ValueError('you need to specify a Youtube ID and an output filename')
            raise ValueError('올바른 입력 값을 입력하세요')
        print('Downloading Youtube comments for video:', youtube_id)
        Number = 1
        if Number == '0' :
            Output1 = input('결과를 받을 파일 입력 :')
            Limit1 = input('제한 갯수 입력 : ')
            if Limit1 == '' :
                Limit1 = 100
                Limit1 = int(Limit1)
            limit = int(Limit1)
            output = Output1
                ##### argument로 받지 않고 input으로 받기 위한 것
            with io.open(output, 'w', encoding='utf8') as fp:
                for comment in download_comments(youtube_id):
                    comment_json = json.dumps(comment, ensure_ascii=False)
                    print(comment_json.decode('utf-8') if isinstance(comment_json, bytes) else comment_json, file=fp)
                    count += 1
                    sys.stdout.flush()
                    if limit and count >= limit:
                        print('Downloaded {} comment(s)\r'.format(count))
                        print('\nDone!')
                        break
        else :
            count = 0
            i = 0
            limit = 100
            for comment in download_comments(youtube_id):
                dic = {}
                dic['cid'] = comment['cid']
                dic['text'] = str(comment['text'])
                dic['time'] = comment['time']
                dic['author'] = comment['author']
                dic['link'] = Youtube_id2
                result_List.append(dic)
                count += 1
                i += 1
                if limit  == count :
                    print(' Comment Thread 생성 완료')
                    print ('\n\n\n\n\n\n\n')
                    break
        return result_List
        #goto_Menu(result_List)
    except Exception as e:
        print('Error:', str(e))
        sys.exit(1)
if __name__ == "__main__":
    main()
