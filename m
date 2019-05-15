Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E1FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB03020657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfEOL7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:59:05 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54668 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbfEOL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:59:02 -0400
Received: by mail-io1-f69.google.com with SMTP id t7so1595570iof.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 04:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wLlE37yrPzANdfG8Iq9EHwFi5Q9N85cm606vgS2oU/4=;
        b=O4xdWYL6z2aN7QqTbIx/Q3XUhynuQHbVUiXnUOW4g+kvuxxLCwmMG+bdLiOgutzfNS
         OuL9Uxx347rYnb+I7L6dqkzOCGubWcusKMdh3iswwXPniZk9X3t5ixl2UH1nHKNliwrd
         H83LJUdED1TDwuAl+gCoPF3ijgL/MQ453UedoA+dj6qI/aUqAs8IGZCesVGs3YWOiHNR
         yt2bOZ3fS3QC7Uv8GGM5z+Jb8UHJNnHlyRZynQl88ZfeNls5NfPlvuWrW0SK8hbZ/P58
         ee1fJUjAAU58eXmZDZy2lk4NJThfJ2Wf8WEZgdRkrgguailAjyLT9+uYR+PNN3xh72t7
         3ORg==
X-Gm-Message-State: APjAAAX3wioyKDzMiTAfG1i3ey4lg77MJLORedCC0j566CbC7phJuu5Y
        EOfmXkQBaHvVLfK8xzrwD8MRdsrOjjIyo7nk+fQ3wxjTsVy7
X-Google-Smtp-Source: APXvYqxhuea74sT72yLEr885VWUmC0yDDZPYDcDl1CPKw5tL3esMrV9W9iAbuAnr0eDXBy6JlimI1pULYWtWhNarz5FlgldoTSCn
MIME-Version: 1.0
X-Received: by 2002:a24:f68b:: with SMTP id u133mr7534350ith.139.1557921541063;
 Wed, 15 May 2019 04:59:01 -0700 (PDT)
Date:   Wed, 15 May 2019 04:59:01 -0700
In-Reply-To: <20190515102133.GA16193@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b0c360588ebe04f@google.com>
Subject: Re: INFO: task hung in __get_super
From:   syzbot <syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+10007d66ca02b08f0e60@syzkaller.appspotmail.com

Tested on:

commit:         e93c9c99 Linux 5.1
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.1
kernel config:  https://syzkaller.appspot.com/x/.config?x=5edd1df52e9bc982
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133626d8a00000

Note: testing is done by a robot and is best-effort only.
