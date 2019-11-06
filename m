Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1106C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79C6217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfKFM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:26:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:49153 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfKFM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:26:01 -0500
Received: by mail-il1-f197.google.com with SMTP id c2so21493643ilj.16
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 04:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TuDU4N7KBIuKg05wOeBVNp8aWXiMZEYdUf0Wu4Ikdgg=;
        b=Uu1Lh4ZbgdCz56IaHXvladWnkuMctQm4SjHmnycTSPuUNeB8LwmkUktm+D1kGolhFw
         zyIRiVQUOsjuw0V1D1hz07PvQXAZgu4v3B67aA5A8p7chPz+TzzdscHDF0SE28KgL/IV
         bbTYyp4+G+VWxVNR1r845gadRDLlZgrOVXd6zChJ9YqWSiLBKaesYSPLok82lEYV9+UF
         EmpFNtvDr5apVFedROBwAIATvcgXaL2uzybppw8c4oG9XTQDJOu0PWNC4QI4mgI3RCPe
         BwUpJ3VoA1c2tZOza8IqJI4cnjpF2qZiUKJtyoMViOV9Nm6CH2/3Z/kXKYYGj7997eiW
         Bt6Q==
X-Gm-Message-State: APjAAAXWoCpZJMAbQ/9KWWBg9WpaLk4F4GNQIctbu4CN+1ij9JGLXIF3
        aqfZbp0+D27/g7udxZXv4T76iWKKdZv53FfqgnSfko5i4taL
X-Google-Smtp-Source: APXvYqyqNmFWaPRN4zNU+bC77MAPWIqH8BFH6dmLMx4fBBLupHK5Ar+vM701NhR+mDHy+ptQJbA58+bJgVH9AFZmD9yfP0LTsyLP
MIME-Version: 1.0
X-Received: by 2002:a5d:8156:: with SMTP id f22mr31826636ioo.234.1573043160641;
 Wed, 06 Nov 2019 04:26:00 -0800 (PST)
Date:   Wed, 06 Nov 2019 04:26:00 -0800
In-Reply-To: <1573040577.3090.22.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce75df0596aca681@google.com>
Subject: Re: KASAN: use-after-free Read in appledisplay_bl_get_brightness
From:   syzbot <syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com>
To:     2pi@mok.nu, alex.theissen@me.com, andreyknvl@google.com,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com,
        tranmanphong@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com

Tested on:

commit:         e0bd8d79 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8847e5384a16f66a
dashboard link: https://syzkaller.appspot.com/bug?extid=495dab1f175edc9c2f13
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14d463b2e00000

Note: testing is done by a robot and is best-effort only.
