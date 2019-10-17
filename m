Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45BAECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4C52089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 10:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408930AbfJQKpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 06:45:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35423 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408907AbfJQKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 06:45:01 -0400
Received: by mail-io1-f71.google.com with SMTP id r5so2731867iop.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 03:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cLtZFzSP9m7R2I1vAMkxi3v/5nEL2ccEzMTJgakEppk=;
        b=pzmSi9DHtuPlp1JmmRwyJG0nedBT/ixCi3FQ6TSI9DDfdr6n/L43c7PLm1jj+x1mQ6
         BsIQebrb1XsQ/kWB8/aEJ8IyuS4oCyhxEuCU2V19otcbliZ4tXZzBjEqzq06EAwU00o4
         IQEZFHZ1+6hZ2LA8Xe+CXzF7HKObPpkSyvcFo9bEEpBxWFPhc8NW9kWzcrct3nh3TDyE
         9HyfAedxYzXyFz+VTyQCcmewJn+GcFb+sShxis49CSVyTNvaq5+FUKgGvSdkhTEBw8E0
         UTdAi3IpGbJ/b1pWoznDswGebUDkd7WcpZ3nHYJZhxtbqFWtCOrjH80slFnttd0fw6AI
         6bGw==
X-Gm-Message-State: APjAAAWNKpXwd1OYAEK18oc5f11yAdxicKfop6Gm1zuJa9tYpxpfgTbK
        UK8Wl4s5ya+sCjPSOK2lp3VLaO5bcuvnXAGYc8mFtSfik9tt
X-Google-Smtp-Source: APXvYqxIpacbM5A9jSQhC7F/ycennX84VVTncbGbhy/C4MRDBmabXa6bs/FUQ8wlYAuZ3GWBbGxfyiMm3XJlQ+mCROX/w2DXO1gg
MIME-Version: 1.0
X-Received: by 2002:a6b:f40c:: with SMTP id i12mr2178740iog.14.1571309100419;
 Thu, 17 Oct 2019 03:45:00 -0700 (PDT)
Date:   Thu, 17 Oct 2019 03:45:00 -0700
In-Reply-To: <20191017102513.GC21827@localhost>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c34ea1059518e885@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ld_usb_read (3)
From:   syzbot <syzbot+6fe95b826644f7f12b0b@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, enric.balletbo@collabora.com,
        gregkh@linuxfoundation.org, johan@kernel.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux@roeck-us.net, logang@deltatee.com,
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
syzbot+6fe95b826644f7f12b0b@syzkaller.appspotmail.com

Tested on:

commit:         22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=6fe95b826644f7f12b0b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14745c87600000

Note: testing is done by a robot and is best-effort only.
