Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A072C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BD12084C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfGSHwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:52:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:42967 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfGSHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:52:00 -0400
Received: by mail-io1-f70.google.com with SMTP id f22so33768982ioj.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=K7+ltczxOF5ec7xwUwwm0mcqoPFbc+qj4S9WQ778w3E=;
        b=m80XFroKHdtE2OqAqZFP91ANyqdj/eG8BAd0YiJ1hbQ/SvdH9qjjknb0M4gr1gwZUo
         HESMbeHEd6hN5mLyBP6xKrJQU/v2yKRPd9GY5B4vcxuNJDIKvzOF5GEd0UesTPOwAu/5
         QFn9P5FO6J3QeqSe9Q9GQwkkZ0agWNSca0fFGOq6GaR9kaukqjqyCEVL+4hLA2Ylm2+p
         1f+lSTNWRfL+g/+JzK5bcGMDC/dYOauCqWsbscKlp8TlqG2sVaxpuoe+pxGPtPFrvx3e
         qTq2LSVJmIujsYYmokDKUQRDnRQNBg4u0XnAnQ+dRjw9L2U2Rkg1dnp8/Lf+GBMUZqGu
         1WRg==
X-Gm-Message-State: APjAAAXfcrfqAzkmFruolL9TFNZ+kjlksJ34yrUfqewUjtXxhiGbyjXd
        7riY+47NtuSU9xzROD0+ip94q+gjlsWPEDqLvSt5RtXnq2TU
X-Google-Smtp-Source: APXvYqyupNDa+g+KEVhidPqN8odS/OREcVICYfkEh4Ipoej6+q4U3LM4sycHC9cn5h2fkqwp21trDBAioJv8oM9mfIt9XbnNd2ch
MIME-Version: 1.0
X-Received: by 2002:a5e:9701:: with SMTP id w1mr49010959ioj.294.1563522720182;
 Fri, 19 Jul 2019 00:52:00 -0700 (PDT)
Date:   Fri, 19 Jul 2019 00:52:00 -0700
In-Reply-To: <dd743f2b-4f86-196b-bdae-16c3286c8904@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055da8c058e04001c@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in dvb_pll_attach
From:   syzbot <syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com>
To:     allison@lohutok.net, bnvandana@gmail.com, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, rfontana@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tskd08@gmail.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com

Tested on:

commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=d90745bdf884fc0a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145eaa34600000

Note: testing is done by a robot and is best-effort only.
