Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD2C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B325B22D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfHUQiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:38:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:33526 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfHUQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:38:01 -0400
Received: by mail-io1-f70.google.com with SMTP id 132so3212951iou.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hpnPsiFxnX4XDyKKrij/XCBcvslRJvlSawvX44PAZjY=;
        b=g2M/aWR82PErhMjlInbT6VRGqtO2QW/xmtOvWGehLW7znyzZcbSUHk9xv1WyVG2xlt
         zc3eeey5rxaaA6r1Dm3sLKapFbqRYDzGjowlfL8Cd3Ve5gR4xQakCJeuIBbAECsDeP/P
         V5r7BWWW+7hFLAKjZhqVGHWjym9eEXtKNQ6j5cBd98lOnQrub3tbeTjK2oWByAOva+BQ
         LYvy1YhysOR8RCc90QOVjikeZ/8j3wEn06zlN7XGRNoQ7l35ueZNRapJJkzMpUlpR86c
         9lMJ47pmz3zxD/QChrQMhXJxjGc1iH2SF0mqVJ9wqRfXUzWxOjiW/FP0Ej0nQU1yXo4L
         QE6w==
X-Gm-Message-State: APjAAAWTP8aB4kQzg8qWmOHDubtLqd54FODAuo8JrjMoy3qKFl0GKPhw
        E0IubvMY4tMyQ5G79wFI/GVYUeD47hqRqR9IW71J9pyHC85t
X-Google-Smtp-Source: APXvYqx76j7sCJ+5CJnRmQmxnncU7QrnrzyIHW9UZT25BmB9EFhFr67Nf77WFBvMwT2ZLgcFjF7Y00vDWQM4n7IxPoUjPsKnIg/l
MIME-Version: 1.0
X-Received: by 2002:a5e:9515:: with SMTP id r21mr14546609ioj.257.1566405480740;
 Wed, 21 Aug 2019 09:38:00 -0700 (PDT)
Date:   Wed, 21 Aug 2019 09:38:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1908211218550.1816-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040fec90590a33230@google.com>
Subject: Re: KASAN: use-after-free Read in hidraw_ioctl
From:   syzbot <syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
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
syzbot+ded1794a717e3b235226@syzkaller.appspotmail.com

Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126b9da6600000

Note: testing is done by a robot and is best-effort only.
