Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A953C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8B2205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfE2MsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:48:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:56705 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfE2MsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:48:05 -0400
Received: by mail-it1-f197.google.com with SMTP id l124so1723741itg.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 05:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LJlloA+Fuq61yxLWLoC8LnijZCRp6jYSZKHjIzT4Rj4=;
        b=Ded2pAwnryxuDPdsNafse8BbhrA91PswNAEuhitJjc+aVKZbAS3RkQYQiN+khSVfl2
         hMnytodA1in+8rWmF3mkxNb43F1Dv9kG1sa43cEHWJxGtJWX8gwHZAiMg/bfHh23hKtZ
         kr3WGlxS4gxryrri2rVNCyu7Z8/6EKnJQAUSALkXqY/8jJpXt+XhrBy5Swr9BmrDxpiM
         JY9MdT3GRlBKFhMuF7UGJz64fT6FeBU9mya4ata78a3c8EqjxH8AslUSjJDN005IK3ji
         IjM8Z6QasuTsz29ZxCkAx/0Cvtf9Ym38hD8pjM3pocNxFfJCOPAdOmGCN/KnMx8sraJe
         WNlg==
X-Gm-Message-State: APjAAAUvoev2DZxnU31xQEjh23aT0wDJWakJ5JPsTLEgOsT8rSJsuG10
        pPPCLaPf7TOfhFtuqGU1x+DVNm7cQoOkm3IfY+u7CG9St1rG
X-Google-Smtp-Source: APXvYqyOoTnHVSkJDjxHibUr474OVj6vvt6MAXKF+4YVBPM5Hi2U/LhNcsb9y9jjVeB1NhB7UdUot499yQCcLdYVyXWIs8/Ej9hW
MIME-Version: 1.0
X-Received: by 2002:a5e:c00a:: with SMTP id u10mr6141490iol.24.1559134085160;
 Wed, 29 May 2019 05:48:05 -0700 (PDT)
Date:   Wed, 29 May 2019 05:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004da71e058a06318b@google.com>
Subject: WARNING in submit_rx_urb/usb_submit_urb
From:   syzbot <syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=143d5972a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c309d28e15db39c5
dashboard link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com

usb 2-1: Direct firmware load for prism2_ru.fw failed with error -2
prism2_usb 2-1:0.191 (unnamed net_device) (uninitialized): prism2_usb:  
Firmware not available, but not essential
prism2_usb 2-1:0.191 (unnamed net_device) (uninitialized): prism2_usb: can  
continue to use card anyway.
------------[ cut here ]------------
usb 2-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 5587 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 5587 Comm: kworker/0:2 Not tainted 5.2.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x292/0x6df kernel/panic.c:218
  __warn.cold+0x20/0x45 kernel/panic.c:575
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 b8 de e5 fd 4c 89 f7 e8 b0 7e 11 ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 80 a3 17 86 e8 73 9b bb fd <0f> 0b e9 20 f4  
ff ff e8 8c de e5 fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881cb876f98 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff812824fd RDI: ffffed103970ede5
RBP: ffff8881d33a5c00 R08: ffff8881cbf5b000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff8881d2fa3918 R14: ffff8881d5feab20 R15: ffff8881d60e8008
  submit_rx_urb+0x2e1/0x3e0 drivers/staging/wlan-ng/hfa384x_usb.c:353
  hfa384x_drvr_start+0x1cb/0x420 drivers/staging/wlan-ng/hfa384x_usb.c:2484
  prism2sta_ifstate+0x2ea/0x4a0 drivers/staging/wlan-ng/prism2sta.c:471
  prism2sta_probe_usb.cold+0x1c8/0x49e  
drivers/staging/wlan-ng/prism2usb.c:112
  usb_probe_interface+0x30b/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x287/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:777
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e6/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x1700 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0xa2/0x100 drivers/usb/core/driver.c:266
  really_probe+0x287/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:777
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e6/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x1700 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1adc/0x35a0 drivers/usb/core/hub.c:5432
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30e/0x420 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
