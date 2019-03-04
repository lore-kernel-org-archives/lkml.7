Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C34C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15682070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfCDMbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:31:04 -0500
Received: from www62.your-server.de ([213.133.104.62]:43616 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfCDMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:31:00 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0mkE-0005YO-0O; Mon, 04 Mar 2019 13:30:58 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0mkD-0008QA-MD; Mon, 04 Mar 2019 13:30:57 +0100
Subject: Re: BUG: unable to handle kernel paging request in
 bpf_prog_kallsyms_add
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+c827a78260579449ad39@syzkaller.appspotmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000009417ef0575802d44@google.com>
 <CACT4Y+ZcD0MqNiYsoSJ+sB3Qkz8Tsh_hOr9rb3NhW3W3EA57mw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f2a635d2-c8cf-a465-aba7-2b7e3eed5f85@iogearbox.net>
Date:   Mon, 4 Mar 2019 13:30:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZcD0MqNiYsoSJ+sB3Qkz8Tsh_hOr9rb3NhW3W3EA57mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25378/Mon Mar  4 11:47:26 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 08:45 AM, Dmitry Vyukov wrote:
> On Mon, Sep 10, 2018 at 10:31 AM syzbot
> <syzbot+c827a78260579449ad39@syzkaller.appspotmail.com> wrote:
>>
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    f6f3bac08ff9 tools/bpf: bpftool: add net support
>> git tree:       bpf-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17940056400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c827a78260579449ad39
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1611c7e1400000
> 
> This is still very actively happening. See the dashboard link for info
> about more crashes.

I'll take a look at it this week, thanks!
