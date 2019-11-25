Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B4C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457320674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 12:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfKYMPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:15:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:50723 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:15:01 -0500
Received: by mail-io1-f69.google.com with SMTP id t193so10686991iof.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jITXxrgjoInRktckRg5MiJg12GhimBajKoz0PrSCnvg=;
        b=n2Gh0CKbw54dPd671+u4nRQ8iX7gcVwFzUazXTRV2zytGAuwefB5eY8Kg4Z7BEckkU
         1TGOx1/94kgJhkIAu/qjUH3orsllGTwWL0BPcBnH8XI41EhEnKF55Tq/5cUsuNbRDRYC
         aCCG0vKQkezn8fy+AaTMm/Ectj9SGSHEAll7NzXZGeuwxcTqlI/C3LR3Au0PUfHJcOPz
         m7Nt0b3B0N3sDG6bAHOvX4qmW1bb8Mxj9Tem5kZSwiLmXRmOD54GrENPDFJmYBE0yfXB
         aPt2rXvRQOthLY3jYNzZQPi/f4nTBMhmJmQrPNuzO9iwfcB21x0S3I7QMwbqwuBjWREB
         60DA==
X-Gm-Message-State: APjAAAUwMATfuq/y3SpbbAM1oq6dLOYusuHq5XVXwoxXmrzzK1QXIyOv
        ohFKA5caoULS8w5hvsYQnsLrjy/7BgEKoVrclq3+IDezvKOQ
X-Google-Smtp-Source: APXvYqytxmBqTzxizQgvYzjWh0aeEOxa1I9xely09r7l/Ai4MyXcYekdIJPhLUEbto69BSj3w6vEBvOgUIpa+xIav/JGQfvdepWq
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2491:: with SMTP id g17mr23420075ioe.160.1574684101188;
 Mon, 25 Nov 2019 04:15:01 -0800 (PST)
Date:   Mon, 25 Nov 2019 04:15:01 -0800
In-Reply-To: <CAO-hwJL_P92-PvyDO2gEPovAQ3vmoH4jpQd-9w5G2ug1UPjc7A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c225e05982ab601@google.com>
Subject: Re: KMSAN: uninit-value in lg4ff_set_autocenter_default
From:   syzbot <syzbot+1234691fec1b8ceba8b1@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, glider@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
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
syzbot+1234691fec1b8ceba8b1@syzkaller.appspotmail.com

Tested on:

commit:         4a1d41e3 net: kasan: kmsan: support CONFIG_GENERIC_CSUM on..
git tree:       https://github.com/google/kmsan.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=a8247e2b2298af08
dashboard link: https://syzkaller.appspot.com/bug?extid=1234691fec1b8ceba8b1
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Note: testing is done by a robot and is best-effort only.
