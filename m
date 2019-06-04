Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F27C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D2F21873
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFDJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:32:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49745 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFDJcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:32:05 -0400
Received: by mail-io1-f70.google.com with SMTP id z15so8810347ioz.16
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ivcTbNOLSVJkCgfnAml1Bl3cpoZ2FnNP9EULXcKNdzg=;
        b=k5wWAAUBfsGBDpGww5xEEm4B51kAPXJnHdxfNo541YKsC9gtWndpuvxtMCVRLidQpq
         IdY5UCwq4RvhdjfzxSgwgbzhUSNlhcNfUmMftmR8l5ZBJvJPh9C804STVPGvWXZKlS78
         JVf0mdgHxRFwLFBKfEFOW8dHtaQEPSu/C0ec8rl0VPkgenlirD0q3OF4XaUCIcJEi/kP
         SHJ83UB2D9AJMoTk2hDLjA0duFrb07RnB5aKkLQsOcLTw1Ybs59gvdyr51IF0sCHLYBY
         WtF5pZqQs1mYP9Epb+bbEuAfDyj92hIGInMjQhQzXmbizcb2fjDJIQyBiuO6G82MVvAq
         8lrA==
X-Gm-Message-State: APjAAAXV2yDCb4iP+fa3iA7DOKplps+oVBhRmmr7XFdLI0J7DKb70yAe
        ngc+iEwicQz5wNZyQN0xh9+uKnUlQlvWlgnPKev8GNN6d5Wj
X-Google-Smtp-Source: APXvYqwQcz6dJ/4qMscpZD49MrOCJx7xWPhJ6GaCYfUYCAvsKsSXypDx+XzJfEtcusdEL7ujte9Gqak33jmQmutxVOm5ryBh4CVq
MIME-Version: 1.0
X-Received: by 2002:a24:8189:: with SMTP id q131mr9840390itd.27.1559640724773;
 Tue, 04 Jun 2019 02:32:04 -0700 (PDT)
Date:   Tue, 04 Jun 2019 02:32:04 -0700
In-Reply-To: <0000000000004da71e058a06318b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060a1fd058a7c2737@google.com>
Subject: Re: WARNING in submit_rx_urb/usb_submit_urb
From:   syzbot <syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=15a2f82ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=193d8457178b3229
dashboard link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f32f54a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1040360ea00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com

prism2_usb 1-1:0.188 (unnamed net_device) (uninitialized): prism2_usb:  
Checking for firmware prism2_ru.fw
usb 1-1: Direct firmware load for prism2_ru.fw failed with error -2
prism2_usb 1-1:0.188 (unnamed net_device) (uninitialized): prism2_usb:  
Firmware not available, but not essential
prism2_usb 1-1:0.188 (unnamed net_device) (uninitialized): prism2_usb: can  
continue to use card anyway.
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 1 PID: 21 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc1+ #10
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:218
  __warn.cold+0x20/0x4b kernel/panic.c:575
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 b8 06 e9 fd 4c 89 f7 e8 c0 44 13 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 20 1c 1a 86 e8 03 db be fd <0f> 0b e9 20 f4  
ff ff e8 8c 06 e9 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881d9efef98 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127e98d RDI: ffffed103b3dfde5
RBP: ffff8881d160f800 R08: ffff8881d9e36000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff8881cfcc5cd8 R14: ffff8881d0a9b3a0 R15: ffff8881c544c208
  submit_rx_urb+0x2e1/0x3e0 drivers/staging/wlan-ng/hfa384x_usb.c:353
  hfa384x_drvr_start+0x1cb/0x420 drivers/staging/wlan-ng/hfa384x_usb.c:2484
  prism2sta_ifstate+0x2ea/0x4a0 drivers/staging/wlan-ng/prism2sta.c:471
  prism2sta_probe_usb.cold+0x1c8/0x49e  
drivers/staging/wlan-ng/prism2usb.c:112
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:777
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1ada/0x3590 drivers/usb/core/hub.c:5432
  process_one_work+0x905/0x1570 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30b/0x410 kernel/kthread.c:254
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..

