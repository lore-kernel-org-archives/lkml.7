Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D0FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4769220869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfDLUQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:16:12 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:39139 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfDLUQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:16:11 -0400
Received: by mail-it1-f197.google.com with SMTP id z125so9711751itf.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 13:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JRJfdZ/9AW26ZH1DjkOcBersgSNKQQTupC9tV461ATU=;
        b=qmUw4psGHCSeJdQwt8JpETMrK0IroSSLgBya+DVJ7o77C+7AotXokNMYnkRYgW3GN2
         dOX/yw6F0pGxxCx26JcVSCDZIqS2+JRnMdttd7916jCyW6ZhboUsVWaP2uHLI/PZgbns
         UWHHKSXYwf+ui50f+/wPrl2X3S+lekt7C34ejiACOhNtrdNh8ztSIwBcRqhHBmQyzaZB
         LtiViD7x/Sig/hjGqqwQfxuMkres11TRJ7I4OJZDAyU5zgMC/hhR8bfTtOirRZl9Wnd+
         MC8SMVfqxyoapeTl/H6Fr2gnHTBKbWrGKAepr/w5iLcp+rUWoFz8QDQiN8HNPHwiEzhD
         q9qg==
X-Gm-Message-State: APjAAAVt/S0uP9//CNfaBTy0jzLZmihEWjvtZG+1DOHoYpyXXZZfi85o
        aDo2F/cewbA0LWX88hFMFSASoSSG3mvO4nVniBG0c4qV3HjD
X-Google-Smtp-Source: APXvYqyDo26rd2xE6EkrUtYdyBovt+hdisPpjKgAgI3GH0proUsSONU3TaSUnlBLYTdkJ/N7j2xKR7z8xMbVMP6fHRl+M6g1sJ0c
MIME-Version: 1.0
X-Received: by 2002:a24:3cd:: with SMTP id e196mr4212434ite.10.1555100170413;
 Fri, 12 Apr 2019 13:16:10 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:16:10 -0700
In-Reply-To: <0000000000001d4f78058656ecfb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f70b905865af968@google.com>
Subject: Re: INFO: trying to register non-static key in vmk80xx_detach
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

syzbot has found a reproducer for the following crash on:

HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan/tree/usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=11bed6fd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
dashboard link: https://syzkaller.appspot.com/bug?extid=54c2f58f15fe6876b6ad
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fdc6bf200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156dc2d3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+54c2f58f15fe6876b6ad@syzkaller.appspotmail.com

usb 1-1: config 0 has no interface number 0
usb 1-1: New USB device found, idVendor=10cf, idProduct=8068,  
bcdDevice=e6.8d
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
vmk80xx 1-1:0.117: driver 'vmk80xx' failed to auto-configure device.
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
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
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc4-319354-g9a33b36 #3
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:__list_add_valid+0x47/0xa0 lib/list_debug.c:26
Code: fa 48 c1 ea 03 80 3c 02 00 75 50 49 8b 54 24 08 48 39 f2 0f 85 59 01  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 75  
3a 48 8b 16 4c 39 e2 0f 85 5e 01 00 00 48 39 f5 0f
RSP: 0018:ffff8880a84a7110 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff888097143850 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888097143898
RBP: ffff8880a84a7170 R08: ffff8880a8491880 R09: ffffed1015094e31
R10: ffffed1015094e30 R11: 0000000000000003 R12: ffff888097143890
R13: 0000000000000000 R14: ffff888097143898 R15: ffff888097143890
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe70ec4d000 CR3: 000000009a600000 CR4: 00000000001406f0
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
  worker_thread+0x9b/0xe20 kernel/workqueue.c:2415
  kthread+0x313/0x420 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace a32085c9f9945bfb ]---
RIP: 0010:__list_add_valid+0x47/0xa0 lib/list_debug.c:26
Code: fa 48 c1 ea 03 80 3c 02 00 75 50 49 8b 54 24 08 48 39 f2 0f 85 59 01  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 75  
3a 48 8b 16 4c 39 e2 0f 85 5e 01 00 00 48 39 f5 0f
RSP: 0018:ffff8880a84a7110 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff888097143850 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888097143898
RBP: ffff8880a84a7170 R08: ffff8880a8491880 R09: ffffed1015094e31
R10: ffffed1015094e30 R11: 0000000000000003 R12: ffff888097143890
R13: 0000000000000000 R14: ffff888097143898 R15: ffff888097143890
FS:  0000000000000000(0000) GS:ffff8880ad000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe70ec4d000 CR3: 000000009a600000 CR4: 00000000001406f0

