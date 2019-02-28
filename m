Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4EBC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22862183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbfB1KLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:11:38 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:23942 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbfB1KLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:11:38 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1SABKBE089969;
        Thu, 28 Feb 2019 19:11:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Thu, 28 Feb 2019 19:11:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1SABFjK089866
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 28 Feb 2019 19:11:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: kernel panic: MAC Initialization failed. (2)
To:     syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
References: <0000000000009c92240582ee96ce@google.com>
Cc:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        takedakn@nttdata.co.jp
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bd185896-d78e-ce2c-ed70-5998e05545e2@i-love.sakura.ne.jp>
Date:   Thu, 28 Feb 2019 19:11:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0000000000009c92240582ee96ce@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/28 15:42, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    7b827ff9af88 Add linux-next specific files for 20190227
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f71894c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa6b8975759dcc5
> dashboard link: https://syzkaller.appspot.com/bug?extid=29569ed06425fcf67a95
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a8242c00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154d6bd0c00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com
> 

Memory allocation failure due to fault injection before loading policy.

#syz dup: kernel panic: MAC Initialization failed.
