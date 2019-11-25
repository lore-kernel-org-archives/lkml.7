Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC5BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FFC207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKYJiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:38:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:35154 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfKYJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:38:02 -0500
Received: by mail-io1-f69.google.com with SMTP id x10so5565198iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:38:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fG9KqHLE4B6rJrt8WSTq/ExbnesyYPEwEQQKonf+qKA=;
        b=pIcLQ7mcvHYoVrvgb1WyE0WOL27umzyP+0uFtI1lhDC2wUMKVaORdvFnkIrruJlRPc
         OUl3qeUQjlz2EiLO/s3EBgm2iQcf74gYWpnnjiFYkmXPgnEMEap19DOSXXzqho87v4If
         fOTi87n1cXgZAHHTsh2Q4RLvVIcoSRPQEgxFLIpRti/6wujsUQ0zSJxwd/HFXTj6mRcu
         ox3jtBJ6Oy4YrXEnl8sqg3pSCFQRO9eYofUXo36ZxNPZ95gCS7rn/OPv61S27/dW8vVF
         pZJpcqt05cAttCzWO3GbfYeYKeQ5R/1VXvW4kQkxqKrpoxhTTa1g0KvovSdmR8fPQkMo
         wNuA==
X-Gm-Message-State: APjAAAW6J3Z+g2evKbk6nkmTIM5JlqfsQdLECU6ivrICcNq7VcMWnyA1
        OHOwmc8NQAL62sWjT0gM2qnyaaOuJsbXSsjhtSYygPVZxf+6
X-Google-Smtp-Source: APXvYqysEvhOU3FlrlkG6Qh8WLdk+WWWUZxt5N0WYkzf9xitUfAL1POuHUf1iCWn+W/dqDUNFjaqX/5F5jsOHUTMFd++GfEmClFL
MIME-Version: 1.0
X-Received: by 2002:a5d:9909:: with SMTP id x9mr9533544iol.93.1574674681278;
 Mon, 25 Nov 2019 01:38:01 -0800 (PST)
Date:   Mon, 25 Nov 2019 01:38:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.1911241115410.26037-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003b7c305982885e3@google.com>
Subject: Re: INFO: rcu detected stall in hub_event
From:   syzbot <syzbot+ec5f884c4a135aa0dbb9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
BUG: found invalid parent_idx

microsoft 0003:045E:07DA.0001: Field 0 ffff8881c0e00000 maxusage 4899
microsoft 0003:045E:07DA.0001: Usage 72 ffff8881c0e00730
microsoft 0003:045E:07DA.0001: collection 0 ffff8881d91be200 type 0 parent 0
microsoft 0003:045E:07DA.0001: BUG: found invalid parent_idx
microsoft 0003:045E:07DA.0001: Start report ffff8881cb82e000 maxfield 1
microsoft 0003:045E:07DA.0001: Field 0 ffff8881c0e00000 maxusage 4899
microsoft 0003:045E:07DA.0001: Usage 72 ffff8881c0e00730
microsoft 0003:045E:07DA.0001: collection 0 ffff8881d91be200 type 0 parent 0
microsoft 0003:045E:07DA.0001: BUG: found invalid parent_idx
microsoft 0003:045E:07DA.0001: No inputs registered, leaving
microsoft 0003:045E:07DA.0001: hidraw0: USB HID v0.00 Device [HID  
045e:07da] on usb-dummy_hcd.5-1/input0
microsoft 0003:045E:07DA.0001: no inputs found
microsoft 0003:045E:07DA.0001: could not initialize ff, continuing anyway
usb 6-1: USB disconnect, device number 3


Tested on:

commit:         46178223 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14bb93cee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99c88c44660624e7
dashboard link: https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c28d5ee00000

