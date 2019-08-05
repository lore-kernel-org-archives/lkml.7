Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0A1C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0340C2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfHEL6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:58:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42153 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbfHEL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:58:07 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so91926683ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E0HDlQzbSlE7/q7GGhIjN7XOM4kiHha/WldHPep5EoY=;
        b=YX/aPgg6lGrSsIMSLF7clG/HOMiFu85cY/iKJL7LMpyon8L7xIWrmL+3l9suXXtRMD
         QTOo89nOPDWNrxbVBSX9Iu3G7lBpbW0+pBoGk+AVijFQMSMgs7NItvGxfBS9v9n7G1L3
         ks8eE6aig1seIXc4N++aiUt1UWun20VtKPEx32IA9Pee0GKgP97RUSHaoBAvp2HvaKKX
         hHsiwZs0Zaq0oTYGcb9B7uNzXcEVqpvtBwb1yves7GQsin4hRfQZhs6/tzwynxo/OScs
         slFIlErEk4Jn2QzsrQFVn+JJ+YPjvUkzJh5uu8c+18yEbUpElmQmzqVddnqrx8yvETt+
         /VDg==
X-Gm-Message-State: APjAAAVYA/a/x5NK/kjpfklhcGsOvUbHgPnan7OE0sGueQxojixdSVxM
        ict32EnlVYK2yZN8KvySb3voglOF1zeU1vvo3u8GKYWJqhth
X-Google-Smtp-Source: APXvYqyyyfnGwSOKyWHJqjjfQ+jylPBfbb9wlXv9C82KDjh++E0QKW3zIdZv6aGs+oOISpUz9yXhUz3tjrO/U8q7NDhzW2s6C+qJ
MIME-Version: 1.0
X-Received: by 2002:a02:7121:: with SMTP id n33mr149347643jac.19.1565006286345;
 Mon, 05 Aug 2019 04:58:06 -0700 (PDT)
Date:   Mon, 05 Aug 2019 04:58:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4df6a058f5d6b70@google.com>
Subject: WARNING in __iforce_usb_xmit/usb_submit_urb
From:   syzbot <syzbot+5efc10c005014d061a74@syzkaller.appspotmail.com>
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

HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=10809e0c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
dashboard link: https://syzkaller.appspot.com/bug?extid=5efc10c005014d061a74
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e40b1a600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174a69d8600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5efc10c005014d061a74@syzkaller.appspotmail.com

iforce 1-1:0.225: usb_submit_urb failed: -71
iforce 1-1:0.225: usb_submit_urb failed: -71
iforce 1-1:0.225: usb_submit_urb failed: -71
iforce 1-1:0.225: usb_submit_urb failed: -71
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 22 at drivers/usb/core/urb.c:477  
usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 22 Comm: kworker/1:1 Not tainted 5.3.0-rc2+ #25
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2a3/0x6da kernel/panic.c:219
  __warn.cold+0x20/0x4a kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
RIP: 0010:usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:477
Code: 4d 85 ed 74 2c e8 28 76 ed fd 4c 89 f7 e8 c0 6d 1a ff 41 89 d8 44 89  
e1 4c 89 ea 48 89 c6 48 c7 c7 60 e7 18 86 e8 3d 47 c3 fd <0f> 0b e9 20 f4  
ff ff e8 fc 75 ed fd 4c 89 f2 48 b8 00 00 00 00 00
RSP: 0018:ffff8881da34f048 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128a0fd RDI: ffffed103b469dfb
RBP: ffff8881d598fd50 R08: ffff8881da340000 R09: ffffed103b663ee7
R10: ffffed103b663ee6 R11: ffff8881db31f737 R12: 0000000000000001
R13: ffff8881cda8d720 R14: ffff8881d67d22a0 R15: ffff8881d598f900
  __iforce_usb_xmit+0x31a/0x490 drivers/input/joystick/iforce/iforce-usb.c:60
  iforce_usb_xmit+0x49/0x50 drivers/input/joystick/iforce/iforce-usb.c:75
  iforce_send_packet+0x277/0x2f0  
drivers/input/joystick/iforce/iforce-packets.c:81
  iforce_set_autocenter+0x9e/0x100  
drivers/input/joystick/iforce/iforce-main.c:95
  iforce_init_device+0x7db/0x13d7  
drivers/input/joystick/iforce/iforce-main.c:314
  iforce_usb_probe+0x757/0xab0 drivers/input/joystick/iforce/iforce-usb.c:233
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x650 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:709
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:816
  bus_for_each_drv+0x15c/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:882
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2114
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
