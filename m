Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B92C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3772067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgAHSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:43:02 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34274 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgAHSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:43:02 -0500
Received: by mail-il1-f199.google.com with SMTP id l13so2772147ils.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 10:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gsmhaJiI7IosyrLbk8vnuiA+k0qhktKDo7fbqvkMYO8=;
        b=kl9Y5yHS2nbmayQxlYWrF2ZZeXubhgfiRZmryPGDoBTUI7d3XZfISa6+38REzCUN72
         JBadvH1aPasB0nlV6K/YXqswQz+pCmiK8FUytZto19CXMhvYiy7eyKZtjd2R76EJBCBH
         qOSjjAClJlxOkzLqmZl7IAXB7qIkwPx/40La1ejbomfkMeiXBFJqz/3SmfBQ73oT6Qtz
         YFm8Ig2lMV8+lHr0eHn07FNo9S7kI+iSg/8im/aa/TXBBQczBoh7BEdtorfW4RVxiWOq
         tf777e3R+HVJnkdJJOiqBLS27LzzXS2isfdW2fFCIKiWZVGamozv7vv7Gx8T3wgqm6xK
         g9JA==
X-Gm-Message-State: APjAAAVJ9tpaay0xSsmSlz0G/LGHpJ5Ho0yTe8uiAkiHvDEpd6N5Gjat
        5MeOP4z+sZBrkV/5Mkum5pGZsgEN8uYsja4ACy2+RUYlheYg
X-Google-Smtp-Source: APXvYqxKYtLzbfqyaoDRR2KCFDYl//WXawATjjjbkROCvej4q2Dpbzny1vJo/YnpX4N4MXb2NMJgKVp5e90UuK6XRdSrl8qOlYy2
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c5:: with SMTP id g5mr4478792iov.161.1578508981277;
 Wed, 08 Jan 2020 10:43:01 -0800 (PST)
Date:   Wed, 08 Jan 2020 10:43:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.2001081314471.1468-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b53f8059ba5431a@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
From:   syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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
syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com

Tested on:

commit:         ecdf2214 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1583963ee00000

Note: testing is done by a robot and is best-effort only.
