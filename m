Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A747C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70F4229F3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404591AbfGYMSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:18:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:43724 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbfGYMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:18:06 -0400
Received: by mail-io1-f69.google.com with SMTP id q26so54650865ioi.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 05:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qrE9ah+MjGSmMicXx9vPsiTpT3sSnUl52kXsY/JR2Ro=;
        b=L7g1ZDuKcBxW8vWhnK3Upruydg9ztMBNeP4QUAdHJqrEvYf2Cy+YaqFuw5Tv+eZJ5P
         st/EPjphCcrnb0sbBe1yKj/i5gpEDVZOuQx1pCbuIezlEpqYtoPj9JMe9jqqZdIVp0EE
         P5OXo1HB31kzD+NN36iXEwrkHETcDWiKSpv/P7N4jdJ8XV7JiRa9bVsvG/kHRuGHk860
         P3/P5n7q3pHjgq93b0l988AVuEZNzP4Ub4698im0iD6OZ1XgSsHK2CRjlAubjwh0XWxg
         VwiRtuOez10Cews+PeP5zJ/k5nyNSVcIKbzLZtTI8W0cuIIvFpDmW8aftKfm8KkfkG+4
         zvkQ==
X-Gm-Message-State: APjAAAU6A4jIuuJnWFHkanVL81/YLPcwYYzE1LCGEnMVskQ6It1KzDWN
        xK5u/lW3OKALHZT7nfZ2FJ69cElAZ+3+jF3P8Fx28OlNqK1C
X-Google-Smtp-Source: APXvYqwJq+2EfA9s4jgQrrZZM8SkDKgC2emG6GmvtPMcLjIihb3Oak28gXeGEXZ03VLa2Dqdm8DhvpCVSM0c41/66jkczl+PhZEO
MIME-Version: 1.0
X-Received: by 2002:a5e:8a46:: with SMTP id o6mr48553383iom.36.1564057085298;
 Thu, 25 Jul 2019 05:18:05 -0700 (PDT)
Date:   Thu, 25 Jul 2019 05:18:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa5443058e806a1d@google.com>
Subject: general protection fault in gigaset_probe
From:   syzbot <syzbot+35b1c403a14f5c89eba7@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6a3599ce usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11865a5c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=700ca426ab83faae
dashboard link: https://syzkaller.appspot.com/bug?extid=35b1c403a14f5c89eba7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14004a7c600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139068cc600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+35b1c403a14f5c89eba7@syzkaller.appspotmail.com

usb 1-1: new high-speed USB device number 2 using dummy_hcd
usb 1-1: New USB device found, idVendor=0681, idProduct=0009,  
bcdDevice=ed.98
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
usb 1-1: gigaset_probe: Device matched ... !
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc6+ #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:gigaset_probe.cold+0x25d/0xd31  
drivers/isdn/gigaset/usb-gigaset.c:707
Code: e0 2a 80 3c 02 00 74 0a 48 8b 7c 24 08 e8 26 e6 1c fd 4d 8b 6f 18 ba  
ff ff 37 00 48 c1 e2 2a 49 8d 7d 04 48 89 f8 48 c1 e8 03 <0f> b6 0c 10 49  
8d 45 05 48 89 c6 48 c1 ee 03 0f b6 14 16 48 89 fe
RSP: 0018:ffff8881d9e0f2e0 EFLAGS: 00010247
RAX: 0000000000000000 RBX: ffff8881c6820880 RCX: ffffffff81ddae1d
RDX: dffffc0000000000 RSI: ffffffff83456ce6 RDI: 0000000000000004
RBP: ffff8881c68200a0 R08: ffff8881d9df9800 R09: ffffed103b3c1e43
R10: ffffed103b3c1e42 R11: 0000000000000003 R12: ffff8881d0f4df00
R13: 0000000000000000 R14: ffff8881d41aa100 R15: ffff8881d244f488
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f52a049b000 CR3: 00000001d342f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
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
  usb_new_device.cold+0x6a4/0xe61 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1abd/0x3550 drivers/usb/core/hub.c:5441
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
