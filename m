Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D2CC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FD320873
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 18:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfERSbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 14:31:02 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:42493 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfERSbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 14:31:01 -0400
Received: by mail-it1-f199.google.com with SMTP id s18so7323360itl.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 11:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5UxPqyqpEqIg/qruEb6a7Im9QP9xMl5nRiEBDpgwPDQ=;
        b=EsYWF6MgQIUTk4qch4wSl0A5rvNGPZ8NhbrQbDlbhV2b+jRdwbqMcnQkVadhTdHa6T
         CJLzm4cgonOHXWFoLYDpIT5P7CNOL2hwv2Y2Yx/moezzrSaPhu976Y4wK8U2L97b8eaN
         Sn3tdMSzZDcysag1bEzFvAuDO+E+05uy5kyhAAeXBol6rIC25woOO7LaICqswfbk/ThT
         CcJf78tv+v93NUQ2BTX6UMbqahsmYMCXp2gM1j1BxvXVNXA4hfSfjqNcG9Lx4knLj/yJ
         hntrfN4KLqtipVp4aJHVwUcMVvHzd/BK8ePgnb/0UVT5AyjbcAm4Iw8eGlkCV42AmOm0
         HPTw==
X-Gm-Message-State: APjAAAXWK9piNhX5LG8iYBu2EkEAkmv+MWOJ8JYmwFMAm8Jmf+iPYz7O
        ONzSstPq3KK4D144uaLDS1zGhwM6p23i93sqzPRTV+Ysk59v
X-Google-Smtp-Source: APXvYqxyoPxBCWAJcC7wBdzP5ONzNf8bm0M0WJRQqXxOkD/QkxdxnSlvE17v680NI9Hn+ZjaeUejDcigqV9rbTj2Ln+qA8flWavS
MIME-Version: 1.0
X-Received: by 2002:a6b:4e17:: with SMTP id c23mr9854089iob.178.1558204260940;
 Sat, 18 May 2019 11:31:00 -0700 (PDT)
Date:   Sat, 18 May 2019 11:31:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1905181346380.10594-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076047305892db3f2@google.com>
Subject: Re: KASAN: use-after-free Read in p54u_load_firmware_cb
From:   syzbot <syzbot+200d4bb11b23d929335f@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, chunkeey@gmail.com, chunkeey@googlemail.com,
        davem@davemloft.net, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+200d4bb11b23d929335f@syzkaller.appspotmail.com

Tested on:

commit:         43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e42018a00000

Note: testing is done by a robot and is best-effort only.
