Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A001BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A2121670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 11:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfIQLlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:41:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40726 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfIQLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:41:01 -0400
Received: by mail-io1-f71.google.com with SMTP id r20so741446ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 04:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TQhhyZzw4ZIrhNwvPs/n5pRvZA2rc0RlRwXQQDytjlk=;
        b=KIERLloY8GJwAs9p8C0mb8CoGo2UFDT9cTRvMk4H6gG+HI8nnvspS0ANV0VdDDJB+q
         0FoP2owIPwHRZsWoKKAmOFkp8rfWr/sNVeaKwFWvdDzNeVGf92cmCl9/2dSxuNe9VSRG
         NNRgNzdpY93UGEFOwtEses6BBQXpQdtB/uishKpCSxTQu9bA+AJGa2hVh/l3AGQREe7c
         M9KwNb+YrIYpWvKHCwub+gVqlL4BPYHzZwY4/GvBbWLWUyIF8koV9Lku+UXeQlJ9DV0/
         Gar7VQu/ADpjT3tMa9Pp9+dS1Mgytv/a1efgYNI5QoFlzMQyg7BK1WA2yRiycbhlffr0
         ClCA==
X-Gm-Message-State: APjAAAW5sSYz3lFpyIgruSHArHbwUTCVLMwvXwVVktIKnx5ZaTdoOKSD
        2fd+osyS+kgwdm2wS0J51FN3NOxmaHNdaTh5G6kyhuh8mOly
X-Google-Smtp-Source: APXvYqwbenYfz+8HvwnLFDOKoiAoxlPm+66Jbx8olwWU83VYq6sGheysqWYQO0WVHRMdPe+OjJsMSZuHPvPXxStFJVjfulg2ZCMU
MIME-Version: 1.0
X-Received: by 2002:a6b:b792:: with SMTP id h140mr2782768iof.225.1568720460772;
 Tue, 17 Sep 2019 04:41:00 -0700 (PDT)
Date:   Tue, 17 Sep 2019 04:41:00 -0700
In-Reply-To: <1568719373.23075.4.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d100350592be31e7@google.com>
Subject: Re: divide error in usbnet_update_max_qlen
From:   syzbot <syzbot+6102c120be558c885f04@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, oneukum@suse.com,
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
syzbot+6102c120be558c885f04@syzkaller.appspotmail.com

Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=6102c120be558c885f04
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148689be600000

Note: testing is done by a robot and is best-effort only.
