Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B86C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7F920665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391223AbfIPUNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:13:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41450 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732965AbfIPUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:13:02 -0400
Received: by mail-io1-f72.google.com with SMTP id e6so1635783ios.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 13:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=l4OIlRI8e5kXyN9A1IopcKJhkWlrZc3Q+7bfrloPlRE=;
        b=uHwTe22OkFygLBl67FCTUU0Sti4zxM99Fm/kEXRM2YfXRSvgALzgkU2FZaoMdT+CEj
         AFmtZMbGIDQKMyHf3Iwj5mPQ4b+C1H4h19jLQIYFyrMIufp4boqjZnsaoB9jEbL/VKb9
         Fgg77yOjn+yjI27WlHBONah3euPxo2RkpB2W7qREbqq8bOA2ZoBB6G8tMIHwicryNTVG
         MyFCwciRcE5NoZ1q1MC52+4OIjV2OAtFCNz0KJ5DJGcQEw7fG7KlMc0/qKFmJqoIHUpH
         GSyRUuVDYDn7AbmgF2bxKXGOeCs38eL2Xeu5KzmsehzhRP7ph5Ha9omOcG7lufJOaziC
         mGag==
X-Gm-Message-State: APjAAAXZ6gD5qMI4gBLdLbhUub9M4/9/Htvrq4InGPopoZs5F22WFOhQ
        UGHmJdGlg+Mqh4qUgL/YWpN3DeDm12nSuWJpW6QUGD5PKZeu
X-Google-Smtp-Source: APXvYqwNlxokkyAMkxB+4hKfQugswka9/Tcy86ADgSBZzkYjrylB+j85zyyS+Rtk51JblDxjgrWrwY5Chk6LVXKx4r/sERNM42uc
MIME-Version: 1.0
X-Received: by 2002:a02:7113:: with SMTP id n19mr1961225jac.82.1568664781716;
 Mon, 16 Sep 2019 13:13:01 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:13:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909161551020.1489-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001603470592b13bfc@google.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
From:   syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, balbi@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
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
syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com

Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1267f9c3600000

Note: testing is done by a robot and is best-effort only.
