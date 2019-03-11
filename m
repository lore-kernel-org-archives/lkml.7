Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D64AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EDD2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfCKMFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:05:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44080 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCKMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:05:02 -0400
Received: by mail-io1-f72.google.com with SMTP id c2so3922015ioh.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5SguhSjRaBeKASDnq4NS1UTdP8TVYxXJzl38J97xMJM=;
        b=POB2yHsQ3KJHkFV4VL3OBs8CRl7dNNbt7EOUX9Da9suhTzUsCMx6kUoTFNfZK2a9vA
         m/8siI4dbuT1SaxazV/m5W3b7kkjXTKVJ1mUMYob54LwoYg0gngN1lX40tKG/Td4aaPc
         tHEGgpoXRvtRtiztQpty0Uk/aOM8DkRAIiHv+gy59pIDXzS5ZorcIb2qpkxW/91auJSm
         Y7hhj1UXeiAItUDa4Ue1rF7qmqflKVPDB7LqMC5bCu7g7deUMBDYjstFdAjk5wEJfGkC
         v73VbMHhPZMes0o6AVqYk1tVVukWnvfSKW/tGmNY+V7J17iP0iSA7mZrdkKzYckNJ6g2
         Hncg==
X-Gm-Message-State: APjAAAUaPqCxjPb6J87/eTqqLTPM1Dl04ExJmXDxluYVnoOdFuMxD13j
        j9koOhBqBHQYa6AMO1v3iXiJpu1la+6IBj65mAG4eiEsBnJK
X-Google-Smtp-Source: APXvYqxAgg4CY/6X+NYFcNCjALwOra4mKDAR8vW6tOKXWLXyDKBMNOujUhu8EY1e1csGLq3vLQLtxvBWW/7fEkCcjga1BcFP1/t8
MIME-Version: 1.0
X-Received: by 2002:a24:5e94:: with SMTP id h142mr20081820itb.35.1552305901110;
 Mon, 11 Mar 2019 05:05:01 -0700 (PDT)
Date:   Mon, 11 Mar 2019 05:05:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d18aec0583d061b7@google.com>
Subject: WARNING in vkms_vblank_simulate
From:   syzbot <syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        hamohammed.sa@gmail.com, linux-kernel@vger.kernel.org,
        rodrigosiqueiramelo@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 09ef09b4ab95dc405ad4171ec2cd8a4ff5227108
Author: Shayenne Moura <shayenneluzmoura@gmail.com>
Date:   Wed Feb 6 20:08:13 2019 +0000

     drm/vkms: WARN when hrtimer_forward_now fails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128448cf200000
start commit:   09ef09b4 drm/vkms: WARN when hrtimer_forward_now fails
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=118448cf200000
console output: https://syzkaller.appspot.com/x/log.txt?x=168448cf200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1e0e0ec44d1e5ff
dashboard link: https://syzkaller.appspot.com/bug?extid=0871b14ca2e2fb64f6e3
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1787db8d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fc9883200000

Reported-by: syzbot+0871b14ca2e2fb64f6e3@syzkaller.appspotmail.com
Fixes: 09ef09b4 ("drm/vkms: WARN when hrtimer_forward_now fails")
