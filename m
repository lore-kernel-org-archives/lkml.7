Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5B1C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2BA216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405440AbfGHWDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:03:03 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50765 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405430AbfGHWDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:03:02 -0400
Received: by mail-io1-f70.google.com with SMTP id m26so20563389ioh.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=z6cwq6PdOuRGao2HTmJRcdKeNfyuLdRgf/WtADemwus=;
        b=C98QCc57QET25hlzEynmKg7YNEfsUiYfhwROI5RyvI9LesCTfPps+BTAHZnKCXmRXR
         crnAJvlaapjmcYl+R6Lt4Im/vq0yzuBarEuOy0vxKyg6XvnZWK6nSk48737iRiOF3PGK
         fXsxk1SZlL3GWvlPxuK1WLlx29ubSUzxZjgs2AyadSi/0UYdjVIN0RDiFSKy/0NFpklN
         AoUF/wiiorw3Y3//P5EpqGlYpuvlbFJ5JC+X7YL4GKh49NHjfV/bBt3rqzhFtR3FObOL
         qD2puXWuPQ7mdMEZP9Q5ibyd+apbM5gBEeVKbFFwbzl/ijHOVbmJRJPsGpYkIT+gV32c
         sdJw==
X-Gm-Message-State: APjAAAUfQjEIIgQwgWFXpOFy3GKS32z45i/htv2cRhuoe5fJrWQzGj4D
        u9TrNneOGAV6/61SMDGRZIeYZwxOdlGwaWy/Ms3kSWNAQrh2
X-Google-Smtp-Source: APXvYqy4sReXWU5IIbQAJc6iyOim2vvJNjJ/YlULz5+YklC4nQ+DcwMW68/p8jMVJRSzZru+nJffT8mahNqxZKHIrjoxXFVte2t5
MIME-Version: 1.0
X-Received: by 2002:a05:6602:c7:: with SMTP id z7mr2108074ioe.130.1562623381127;
 Mon, 08 Jul 2019 15:03:01 -0700 (PDT)
Date:   Mon, 08 Jul 2019 15:03:01 -0700
In-Reply-To: <5d236d7dc1db6_75f52af7c83505bcc3@john-XPS-13-9370.notmuch>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ccb1a058d329b72@google.com>
Subject: Re: WARNING in mark_lock
From:   syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, ebiggers@kernel.org, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com

Tested on:

commit:         17b3f125 tls: working code
git tree:       git://github.com/cilium/linux fix-unhash
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd16b8dc9d0d210c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
