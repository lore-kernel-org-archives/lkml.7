Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CFC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C942F206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgACQ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:57:04 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:37069 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgACQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:57:03 -0500
Received: by mail-io1-f69.google.com with SMTP id t70so27337334iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 08:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CV8CkChElFjf0jDvkRmO/Avuy2yoeDOeDMEHSWAyFO8=;
        b=YoC/yDFcHBEm0tl8iFtNJ5LsFrgZ82rJLmhQP49Q3OYdIaN4Vdzydd5KSnhJKafaL5
         wMsjnWB/tPS/iXfmFQ9w4LyhmwPqMkahNrWG60SJyL2PEScPbyxMRwzvhq3UcU6OGEQZ
         9rzX94vmOlmkiXAe7Jg/VoBS7lrsVnnZQKzDQxEj2LMJXjK4AthI7J2r4BOjHok16B8M
         R3Qj0dv7h6M25oQH8Sesf/0UVP1a3ehd+OoaSRYdEpayciPiEatngJoyLRFz+hCJb0uv
         G1RpDo+4SFC5qDdincCwiTosC25CUywxF6aLlz0ZYr7HS1uz8bQeJiF4q35zlOGNUPOe
         u7LQ==
X-Gm-Message-State: APjAAAUhRdlz91D5nhMhN/W4YeVDqCXWGArTo7t5FqdKMEmWQBAZy9QE
        IClTupNbshv1/cxeIdpKd2B2zFJIzXQ7L4WkO6urNzKNRLry
X-Google-Smtp-Source: APXvYqx7P/ms+QWeGK7fF3ZjlJWamv6WKPaEzHR2v2UJEcHFQ/rUZIhA4hcdyh1xvvPjmodbWjlUXFEMQuyp8rnVj9u0+67bUzE8
MIME-Version: 1.0
X-Received: by 2002:a92:9c48:: with SMTP id h69mr68019925ili.222.1578070621457;
 Fri, 03 Jan 2020 08:57:01 -0800 (PST)
Date:   Fri, 03 Jan 2020 08:57:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.2001031133050.1560-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d29687059b3f32aa@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177f06e1e00000

Note: testing is done by a robot and is best-effort only.
