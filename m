Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4673FC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206862084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfEMP3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:29:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:33714 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731295AbfEMP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:29:01 -0400
Received: by mail-it1-f198.google.com with SMTP id x3so163959itj.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3VZ4p/YISWcz91SuVCC0Sel7mLneKp5LD5Zz/ePb6Zs=;
        b=ja5hiUsV5paAxSSOyLf/HdXHl2LezHJfVDunk158QYWJrhDgfbEUzY4jVs8l1eT2rP
         YVVnLxVDU2a2DF9hTjkfPJie7Q9emrXy+nyh6AXzdLlMytlIe6BCpJuxDa60otpZs43K
         hoccNYeGgOFsSYz/YNDhWyvJqxpBP+XUZdO9nzra6g6PkXQ+BZfuqe05F4r5WAk7rI9J
         HWOO9FLjgQ6yf6KflaDHTBNcK143CI4nn7VWl4aNcPMxiIXsAt+rq3COX4ithVlZAtZd
         19Fk5TZ6zqWUw/qqwGQZ9RWgoeANSaAf6kAOADm8qU7XZRCATi68WEDIjo6kOrHccplO
         S7Xg==
X-Gm-Message-State: APjAAAX9u9qVVSJrqtmw2bOcbMVQvJ12FKEgJkZCIo1tA7Mwq6cK9r5+
        BAQK+bhS6TgahnGLLMANwpRPSRtWLcmKSowvxNFEAEzHB3/6
X-Google-Smtp-Source: APXvYqzhnwgnI+7XB9cPfmqZVvcdHah0xlT4kcjVKXz/Qf4DKOW4yChduCTqpqesYU5a7etL6kRCLS1kRtSqh/cNsjA9kKuMglZO
MIME-Version: 1.0
X-Received: by 2002:a24:5dc8:: with SMTP id w191mr18348892ita.136.1557761341111;
 Mon, 13 May 2019 08:29:01 -0700 (PDT)
Date:   Mon, 13 May 2019 08:29:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1905131046130.1478-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061c7cd0588c6933c@google.com>
Subject: Re: KASAN: slab-out-of-bounds Write in usb_get_bos_descriptor
From:   syzbot <syzbot+71f1e64501a309fcc012@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        suwan.kim027@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+71f1e64501a309fcc012@syzkaller.appspotmail.com

Tested on:

commit:         43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15912100a00000

Note: testing is done by a robot and is best-effort only.
