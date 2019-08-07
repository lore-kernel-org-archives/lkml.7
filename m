Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1ADC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8945E21E6C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfHGONB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:13:01 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:45339 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfHGONB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:13:01 -0400
Received: by mail-ot1-f70.google.com with SMTP id b25so54914484otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+rvcyyJPT124CBjh50veSjwzTuKPjdB1gn6DdCRD4GQ=;
        b=MTCn1IQYl7vuJ5KjsJZRrv85hRW/xB2fMlYfEHzIh8VBKzkrs0X9nzEr7QQKqt4sAm
         OCWsG0LvgA9JF5wf2jYSXOJLlP5etuiL17WKb0GknGGd4S0MC03NwElgel31Uj9GCVaf
         kXZFXzYY1NjF89mLQD1nzuuWst/9ZRbInTsPvvK7MWAziQKwCEQYfz1EEis2q9i0K46k
         P0IOBouo70KPXz5AVKnE+rQdY9R3v3fXjAqXwq1fGLipHtXfIvv8zg9jCJaiNDJF+1rm
         7KBt89r6Fl8VXJwyMW7qNWZX1VaD//bXtBTBgQWPh8zK9lsy1LV87B5pFLW6B/2pVgYo
         sLiA==
X-Gm-Message-State: APjAAAUHP7ue6ACcwm2ap6vGFnENLda/mAp9xPQ2c1RuoGlc+CXdZP8i
        DwyE1nkPcFGjt5EL2HmUtyO0lVaIe/u6wH6HpOSbnyOSEX6n
X-Google-Smtp-Source: APXvYqydE+glsz2eL+FR6jE4ph1gTugBhAbEDDTDWgMZ8T6Wk5OyXx0b7GUWhjNN5KDpAYSMImNZ4sWO1khxy6jFYxnVm6NB2sNM
MIME-Version: 1.0
X-Received: by 2002:a6b:621a:: with SMTP id f26mr8317090iog.127.1565187180660;
 Wed, 07 Aug 2019 07:13:00 -0700 (PDT)
Date:   Wed, 07 Aug 2019 07:13:00 -0700
In-Reply-To: <CAAeHK+wV_w6f=zG4XSJkDRhR6b0aNPH0UTkBF3hmRQ6wxy9p2w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e90d40058f8789e1@google.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
From:   syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com

Tested on:

commit:         6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1245683c600000

Note: testing is done by a robot and is best-effort only.
