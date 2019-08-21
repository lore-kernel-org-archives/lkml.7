Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E0C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1642082F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbfHUNJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:09:01 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:48781 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfHUNJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:09:01 -0400
Received: by mail-io1-f70.google.com with SMTP id 67so2570351iob.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 06:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=MRdtoTfzHIwJVxhX35Sc59foQp09KDcPOWTOEZaO7x8=;
        b=HqJzqeYGOEW5mqjPsi1jAV14UHfRBx+fMqmA13XTaGcSkAZPgVAq4BS8+LL0H29uua
         iC7gKp8A8pUe5HsBAGZkFKHKLmC/pvQtXWlhn5KmMTJd7HSkVbZiX1+3TjNz5lm53hT/
         WiU+K8YF8LaNZgeAlVHol82bIuvoZiTc13WiEZkuS2VB3lkeUJNSQ0KV+I4Mn0z2aSOy
         HpKBnzmyZx4rq7PwhXZcbAxbER/wM894K6aK3myRhvSgMWa4jis52rFNnzZEop0a26dm
         hTE9aTo2KwznLWAp1UdC+19ZceTDBbZGkJM8+mgPdFZJlGonRz/IY1R+JIiCAEhkaUDg
         rCAg==
X-Gm-Message-State: APjAAAU1nSnWOkaf80mihvsX8vTyfn1rfmK+wMx9MprV+yISliX0yc6u
        ePobvQqcG0rWW6PDoUGESoD2rB/dwk7YCGkIJD3HJkwGy401
X-Google-Smtp-Source: APXvYqzS78T/uhx6IUoEGdP0SfpaPU+rACUgLTB7aYQf7Q031U2NMTj0nJSIiooWOU5phAbHo/88+lym2ff9FXmSeqFbDw8yV1ST
MIME-Version: 1.0
X-Received: by 2002:a05:6638:310:: with SMTP id w16mr9829024jap.136.1566392940385;
 Wed, 21 Aug 2019 06:09:00 -0700 (PDT)
Date:   Wed, 21 Aug 2019 06:09:00 -0700
In-Reply-To: <CAAeHK+wkV7zpAHURRzdY_TMRkCv=P5=yfJqLf9tAoYJA35779A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca63880590a046e2@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
From:   syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, stern@rowland.harvard.edu,
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
syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com

Tested on:

commit:         7f7867ff usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=140148ca600000

Note: testing is done by a robot and is best-effort only.
