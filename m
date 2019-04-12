Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F47121872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDLP0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:26:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:42028 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDLP0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:26:11 -0400
Received: by mail-io1-f69.google.com with SMTP id i1so8139329ioq.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=nDaFKC51wjVgHRBwEGOQJqWb5B+azud/kYNJfqssm2w=;
        b=p3cXXJNwwPyCf0JPYJDll1b/lLUpCtpN8LZYGF/yhkxZEKHvtJ2kpVsMN6C4ET2DH/
         OEIM6mrb2IIY3TZuq1RXuldO5VogsbnErLHU+CN5EkHbsgo0nxzWqsr6TSZv9M8UNWs3
         3A5HW5gXLh95VyKhwvpekB+jZdkANVRAZqRjfV5w5cyVL4GyfBiGnhwOMpQYA+RDSB81
         63D96wpaoiA4Dsrd8iJyUITjU4mO4GMwcWdORH7l3UWFZernTeVoG+6wx8GwQKPDNYof
         POcD2Son6ZM9V5G4XM4d6vqqlO0v8OkR1k4+gKIner3v5ST6VcQg6bUyB5Xy1p0VOSbn
         G66w==
X-Gm-Message-State: APjAAAX/vGD6DuOcQXJBexjoqFK54BY62J2iMOtmJ3SU2JNEnoySJ9uy
        q+FIWQzFCHOlBewGi+JewgGeaC0nVBnNOh2vA0kxOeSoxGDN
X-Google-Smtp-Source: APXvYqw9ztCAZmKh/fqZzf09IjVm9iPY1QX8wrIhXmU5z3dXHvkxCYyhWMA7r9GO0RxiBSdTEu7QEhYKXXN3AEk32AymmZyGbdq8
MIME-Version: 1.0
X-Received: by 2002:a24:9884:: with SMTP id n126mr3600370itd.30.1555082770203;
 Fri, 12 Apr 2019 08:26:10 -0700 (PDT)
Date:   Fri, 12 Apr 2019 08:26:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d4f78058656ecfb@google.com>
Subject: INFO: trying to register non-static key in vmk80xx_detach
From:   syzbot <syzbot+54c2f58f15fe6876b6ad@syzkaller.appspotmail.com>
To:     abbotti@mev.co.uk, andreyknvl@google.com,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=15ecc1af200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=54c2f58f15fe6876b6ad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+54c2f58f15fe6876b6ad@syzkaller.appspotmail.com

usb 3-1: config 0 interface 134 has no altsetting 0
usb 3-1: New USB device found, idVendor=10cf, idProduct=8065,  
bcdDevice=63.d7
usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 3-1: config 0 descriptor??
vmk80xx 3-1:0.134: driver 'vmk80xx' failed to auto-configure device.
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xe8/0x16e lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:786 [inline]
  register_lock_class+0x11b8/0x1250 kernel/locking/lockdep.c:1095
  __lock_acquire+0xfb/0x37c0 kernel/locking/lockdep.c:3582
  lock_acquire+0x10d/0x2f0 kernel/locking/lockdep.c:4211
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x44/0x60 kernel/locking/spinlock.c:152
  down+0x12/0x80 kernel/locking/semaphore.c:58
  vmk80xx_detach+0x59/0x100 drivers/staging/comedi/drivers/vmk80xx.c:829
  comedi_device_detach+0xed/0x800 drivers/staging/comedi/drivers.c:204
  comedi_device_cleanup.part.0+0x68/0x140  
drivers/staging/comedi/comedi_fops.c:156
  comedi_device_cleanup drivers/staging/comedi/comedi_fops.c:187 [inline]
  comedi_free_board_dev.part.0+0x16/0x90  
drivers/staging/comedi/comedi_fops.c:190
  comedi_free_board_dev drivers/staging/comedi/comedi_fops.c:189 [inline]
  comedi_release_hardware_device+0x111/0x140  
drivers/staging/comedi/comedi_fops.c:2880
  comedi_auto_config.cold+0x124/0x1b0 drivers/staging/comedi/drivers.c:1068
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_add_valid+0x47/0xa0 lib/list_debug.c:26
Code: fa 48 c1 ea 03 80 3c 02 00 75 50 49 8b 54 24 08 48 39 f2 0f 85 59 01  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 75  
3a 48 8b 16 4c 39 e2 0f 85 5e 01 00 00 48 39 f5 0f
RSP: 0018:ffff8880a846f110 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880a7dba790 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880a7dba7d8
RBP: ffff8880a846f170 R08: ffff8880a8444980 R09: ffffed101508de31
R10: ffffed101508de30 R11: 0000000000000003 R12: ffff8880a7dba7d0
R13: 0000000000000000 R14: ffff8880a7dba7d8 R15: ffff8880a7dba7d0
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc1d507000 CR3: 0000000082728000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __list_add include/linux/list.h:60 [inline]
  list_add_tail include/linux/list.h:93 [inline]
  __down_common kernel/locking/semaphore.c:210 [inline]
  __down+0xa7/0x2c0 kernel/locking/semaphore.c:238
  down+0x5c/0x80 kernel/locking/semaphore.c:62
  vmk80xx_detach+0x59/0x100 drivers/staging/comedi/drivers/vmk80xx.c:829
  comedi_device_detach+0xed/0x800 drivers/staging/comedi/drivers.c:204
  comedi_device_cleanup.part.0+0x68/0x140  
drivers/staging/comedi/comedi_fops.c:156
  comedi_device_cleanup drivers/staging/comedi/comedi_fops.c:187 [inline]
  comedi_free_board_dev.part.0+0x16/0x90  
drivers/staging/comedi/comedi_fops.c:190
  comedi_free_board_dev drivers/staging/comedi/comedi_fops.c:189 [inline]
  comedi_release_hardware_device+0x111/0x140  
drivers/staging/comedi/comedi_fops.c:2880
  comedi_auto_config.cold+0x124/0x1b0 drivers/staging/comedi/drivers.c:1068
  usb_probe_interface+0x31d/0x820 drivers/usb/core/driver.c:361
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_set_configuration+0xdf7/0x1740 drivers/usb/core/message.c:2021
  generic_probe+0xa2/0xda drivers/usb/core/generic.c:210
  usb_probe_device+0xc0/0x150 drivers/usb/core/driver.c:266
  really_probe+0x2da/0xb10 drivers/base/dd.c:509
  driver_probe_device+0x21d/0x350 drivers/base/dd.c:671
  __device_attach_driver+0x1d8/0x290 drivers/base/dd.c:778
  bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:454
  __device_attach+0x223/0x3a0 drivers/base/dd.c:844
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:514
  device_add+0xad2/0x16e0 drivers/base/core.c:2106
  usb_new_device.cold+0x537/0xccf drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x138e/0x3b00 drivers/usb/core/hub.c:5432
  process_one_work+0x90f/0x1580 kernel/workqueue.c:2269
  process_scheduled_works kernel/workqueue.c:2331 [inline]
  worker_thread+0x7b0/0xe20 kernel/workqueue.c:2417
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace baf4250c4ca185f3 ]---
RIP: 0010:__list_add_valid+0x47/0xa0 lib/list_debug.c:26
Code: fa 48 c1 ea 03 80 3c 02 00 75 50 49 8b 54 24 08 48 39 f2 0f 85 59 01  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 75  
3a 48 8b 16 4c 39 e2 0f 85 5e 01 00 00 48 39 f5 0f
RSP: 0018:ffff8880a846f110 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880a7dba790 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8880a7dba7d8
RBP: ffff8880a846f170 R08: ffff8880a8444980 R09: ffffed101508de31
R10: ffffed101508de30 R11: 0000000000000003 R12: ffff8880a7dba7d0
R13: 0000000000000000 R14: ffff8880a7dba7d8 R15: ffff8880a7dba7d0
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcc1d507000 CR3: 0000000082728000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
