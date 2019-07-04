Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AC0C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CAB218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfGDOJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:09:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44510 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfGDOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:09:06 -0400
Received: by mail-io1-f70.google.com with SMTP id s9so3329936iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 07:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ihONyH8UAyP8YEt7eORDaqs5Q56aaulsoMnZyH6j0Ek=;
        b=p6IZyJzMVInVA2RFBJrlqAtRU+cquCx5SbMyomokdRoOE6sP+IdvJ/kOBitLtgydI4
         bB9rn8NP3JMbQtHRkISd87Cvu3/gRSE25SWue6fBPEIAOXwo0mcMBlifDdXZD/jnbo5k
         nXxDH45qCA+Z9FTeQpQxtgK5U10a1/qFTISBbBlgDO6bJXYlCRVmjdj58GYgd2pFHKbA
         Er/Ay51Ks1FPejMSA/H1Qk6P/LC/iUr7emHmLP9HI5yo97WLjdf9MtYK6rKX3JL6aH5+
         w7kSuFaULJLXf2rxjPf1njw7akZjOCKnwA0zacNEVBeP+r4jsQw2BFPf+fY7ZTOV9O/h
         HqcQ==
X-Gm-Message-State: APjAAAV51DEuKCLeJ/BW8QgUvdG0xEvGrEk2HA1OwiBnYCnOL4oKXS1B
        iWAT78Bqe8pUE1nLFJbgeley/HPzF//SzKcVfuNmuwk+45fA
X-Google-Smtp-Source: APXvYqzzTMgKs5gdQbfrqCY/mlGs0xnXZ9P+2aRYZ+z7FjaeXEihcDHvIMKMCU2+fqjMo4FHvgULPwB0CeLYufrWziX6K6g/zDFD
MIME-Version: 1.0
X-Received: by 2002:a02:22c6:: with SMTP id o189mr4144787jao.35.1562249345637;
 Thu, 04 Jul 2019 07:09:05 -0700 (PDT)
Date:   Thu, 04 Jul 2019 07:09:05 -0700
In-Reply-To: <000000000000a0b1df058cb460c8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c2556058cdb850c@google.com>
Subject: Re: WARNING in sisusb_send_bulk_msg/usb_submit_urb
From:   syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=12e5bf93a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6d4561982f71f63
dashboard link: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11effc85a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=172189aba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com

usb 1-1: string descriptor 0 read error: -22
usb 1-1: New USB device found, idVendor=0711, idProduct=0550,  
bcdDevice=da.7e
usb 1-1: New USB device strings: Mfr=37, Product=1, SerialNumber=1
usb 1-1: USB2VGA dongle found at address 2
usb 1-1: Allocated 8 output buffers
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 1 PID: 21 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.2.0-rc6+ #13
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6c9 kernel/panic.c:219
  __warn.cold+0x20/0x4b kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 78 db e8 fd 4c 89 f7 e8 a0 36 13 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 80 23 1a 86 e8 03 a0 be fd <0f> 0b e9 20 f4  
ff ff e8 4c db e8 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881d9efed28 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8127ef3d RDI: ffffed103b3dfd97
RBP: ffff8881d09bbb80 R08: ffff8881d9e36000 R09: ffffed103b665d30
R10: ffffed103b665d2f R11: ffff8881db32e97f R12: 0000000000000003
R13: ffff8881ccdd79a8 R14: ffff8881d03711a0 R15: ffff8881d9449000
  sisusb_bulkout_msg drivers/usb/misc/sisusbvga/sisusb.c:238 [inline]
  sisusb_send_bulk_msg.constprop.0+0x88a/0x1030  
drivers/usb/misc/sisusbvga/sisusb.c:393
  sisusb_send_bridge_packet.constprop.0+0x11c/0x240  
drivers/usb/misc/sisusbvga/sisusb.c:581
  sisusb_do_init_gfxdevice+0x8a/0x450  
drivers/usb/misc/sisusbvga/sisusb.c:2137
  sisusb_init_gfxdevice+0xe0/0x18d0 drivers/usb/misc/sisusbvga/sisusb.c:2237
  sisusb_probe+0x924/0xbcb drivers/usb/misc/sisusbvga/sisusb.c:3122
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
  process_one_work+0x905/0x1570 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x30b/0x410 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..

