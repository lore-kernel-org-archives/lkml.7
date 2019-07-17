Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E380C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3817820880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfGQM3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:29:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46708 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfGQM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:29:02 -0400
Received: by mail-io1-f69.google.com with SMTP id s83so26939735iod.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 05:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AByShyV8MxugdrVAP52bTC11/zp2agBi1wk+fUcF/g8=;
        b=unkCs5dn8cylSpufM4CmCsfsRh4aVyseCllFHs1WKp7sDcgyjjBFsgikFX0Eudhro7
         jV9eTYb/K6VE0sJIS67LQ1+F9aNmotmQwWnOjt3RVZdsLAUXdNhDN6HDKfP/cefTKth7
         O15PiFVTzrZ2fdKP1tJtHg8FJ9CDZzH6g1LUi4WopsMsGDN54eGUeUmUry6xFvoQNQn3
         s0A1f3d342LmRhcWdH0llzyd9Wli+3goPKSu20ZiZl/oXs36oxrycgNRO70636swKcmj
         QFx6ymKwLEVixEqOd51WDkkoKieJ7ADSR5/fawIUhuP2PAxLob/9zvCHBoFeMmCMVjRZ
         9uKg==
X-Gm-Message-State: APjAAAX9gnhhzcndrhwxuBgJH1D1nkeje9OSBaZTJM+6cedGMACMV9wK
        tQTRV3H1nox2y77om17C5ls/ekZQg9w3YCyvUdRAqUCX4tcQ
X-Google-Smtp-Source: APXvYqxoVSLYclq8vROH6mYIXxVdmTx0TM+Zs7tz/C19ac1rQJfL74aTHycQ78ufw/LQNLLowRXhr3VuOu/dGV+La6CLKhQSGzQp
MIME-Version: 1.0
X-Received: by 2002:a6b:90c1:: with SMTP id s184mr1909577iod.244.1563366541028;
 Wed, 17 Jul 2019 05:29:01 -0700 (PDT)
Date:   Wed, 17 Jul 2019 05:29:01 -0700
In-Reply-To: <CAAeHK+zPDgvDr_Bao9dz_7hGEg+Ud6-tj7pZaihKeYHJ8M386Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054f8bd058ddfa341@google.com>
Subject: Re: KASAN: global-out-of-bounds Read in dvb_pll_attach
From:   syzbot <syzbot+8a8f48672560c8ca59dd@syzkaller.appspotmail.com>
To:     allison@lohutok.net, andreyknvl@google.com, bnvandana@gmail.com,
        hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, rfontana@redhat.com,
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1454f4d0600000

Note: testing is done by a robot and is best-effort only.
