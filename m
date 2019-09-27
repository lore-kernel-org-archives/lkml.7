Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C26C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C35217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 17:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfI0RTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 13:19:11 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:44524 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0RTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 13:19:11 -0400
Received: by mail-io1-f70.google.com with SMTP id k13so5357145ioc.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 10:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zxeLCqjDaKeujGz+PQqWI0G/tePghEgmDsXcOaH+Ukc=;
        b=BtNzbEhQElNAyOOOZ7U20rHIdZLuVDFydJUJRb/+lnRqEi7xSKQtkIJexJJ0N7EOQV
         1HgwlIcLEgaFnTfnPc+jt1msQi9wwcBcxNERRwJRKFEBuC5qcaung1fhDOqaraAvVmFY
         GZFbh8cSNAwmwOkqvy7TnKi4ev5yRuUnt8nOYWFQxBBTMgEGs7yLgHBQ5b8T7zJnrOe3
         recLBNZbDWOLM5IwErPqq0qUvkuabujIY/nPi1yBgmBH7wBs/1B0dsVZrSqSIqkWJ8sA
         sjqClYhsNZX103SheywazqQ0S5gzwr53WqoQqDyiwktUMgQmIiopwN9H3HoiLmERWU4v
         h/BA==
X-Gm-Message-State: APjAAAUKFwMi/h/uhP+J8IgCuZXVJScSj5VnS70KFYUgdott6lJwtbHD
        2KfAY1MtF36azD3z2v/6qipsg1fmdvYjBfwh+MWCiQoBdcVU
X-Google-Smtp-Source: APXvYqwWP8m5BBxC3dkBytp7j3WEAgQXsJw0NxI7m/wMePsgOlACjIQ4wlL1I0diJHh8s/38cY9F+r9wvNuPW1fF8EQ7UvkV55rC
MIME-Version: 1.0
X-Received: by 2002:a5d:9956:: with SMTP id v22mr20080ios.27.1569604748454;
 Fri, 27 Sep 2019 10:19:08 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:19:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007831a205938c15a0@google.com>
Subject: WARNING in hso_probe
From:   syzbot <syzbot+f00009d1881ba5ac45f8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    2994c077 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=145faaf3600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69ddefac6929256a
dashboard link: https://syzkaller.appspot.com/bug?extid=f00009d1881ba5ac45f8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149c5aa9600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1318fa39600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f00009d1881ba5ac45f8@syzkaller.appspotmail.com

sysfs group 'power' not found for kobject 'ttyHS0'
WARNING: CPU: 0 PID: 12 at fs/sysfs/group.c:278 sysfs_remove_group  
fs/sysfs/group.c:278 [inline]
WARNING: CPU: 0 PID: 12 at fs/sysfs/group.c:278  
sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0+ #0
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
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:sysfs_remove_group fs/sysfs/group.c:278 [inline]
RIP: 0010:sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c  
01 00 75 41 48 8b 33 48 c7 c7 20 de d0 85 e8 20 29 8a ff <0f> 0b eb 95 e8  
12 b3 db ff e9 d2 fe ff ff 48 89 df e8 05 b3 db ff
RSP: 0018:ffff8881da20f150 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff85f34640 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8128d3fd RDI: ffffed103b441e1c
RBP: 0000000000000000 R08: ffff8881da1f9800 R09: fffffbfff11f45ae
R10: fffffbfff11f45ad R11: ffffffff88fa2d6f R12: ffff8881d909b300
R13: ffffffff85f34be0 R14: ffff8881d9099980 R15: ffff8881d909eef0
  dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:741
  device_del+0x12a/0xb10 drivers/base/core.c:2352
  device_unregister drivers/base/core.c:2407 [inline]
  device_destroy+0x96/0xe0 drivers/base/core.c:2986
  tty_unregister_device+0x7e/0x1a0 drivers/tty/tty_io.c:3185
  hso_serial_tty_unregister drivers/net/usb/hso.c:2231 [inline]
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2668 [inline]
  hso_probe.cold+0xc8/0x121 drivers/net/usb/hso.c:2934
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x104/0x210 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:430
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:490
  device_add+0xae6/0x16f0 drivers/base/core.c:2201
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
