Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9768C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD8C208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfICMJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:09:06 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49011 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbfICMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:10 -0400
Received: by mail-io1-f70.google.com with SMTP id p1so8363073iom.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+TyJ0OG+pPp/DvJlej8bfcgO9uWPlVMHlJBQUM4x4e4=;
        b=Nj0Wzp4LvAz3CNPiD9+CRuPfGMovsZT52AfYnDTLa1sfyvr3EFy+sksvkKNLjpvrq9
         S47XWETy+xUNtZoTafa39bj4UO4drbTpu7JQi374sJG7sQfM16M+BbHPWLdCr48USFVq
         RI3WVad3MEh/WD5Y4VGo1AxJn3boxyDz3HaDhWrJQG2G0tpYu0oPzEsEO+oF+PwsgrXB
         sm3VnmkozNFRGB5t+Q2ucX4/7rdlYKERKVIK/PPU+9uA0g9ixY1qE68q02QqmjGC6rYd
         U7QoaQmUnO7Yy39jQQLKf2T1AZJqisyoUmGwjqWKoPiLFWtYr0LAU05MiMhijCxMFRaT
         s4zA==
X-Gm-Message-State: APjAAAVc7o8owbwVACGSQCRZbWrVvUL8ntbrKYZi3T2rme8P9t9jTIGI
        fBqDYKZ5JsxQIZrwVIEEzQF5szrxWCD6biCscOakaGDOEZZ4
X-Google-Smtp-Source: APXvYqwoaPI8LWTk3EClq2Sd2SgccAwr6DL1QApT7yvnOxkC1F2kOs7555u/MDme+whxIW+TPpWRqTspOTNuEf+TULLMgC0UsAcx
MIME-Version: 1.0
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr10372843iok.217.1567512490089;
 Tue, 03 Sep 2019 05:08:10 -0700 (PDT)
Date:   Tue, 03 Sep 2019 05:08:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002725f40591a4f118@google.com>
Subject: general protection fault in pk_probe
From:   syzbot <syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=14c3589e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=1088533649dafa1c9004
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1667cc66600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f30dbc600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com

prodikeys 0003:041E:2801.0001: unknown main item tag 0x0
prodikeys 0003:041E:2801.0001: unknown main item tag 0x0
prodikeys 0003:041E:2801.0001: hidraw0: USB HID v0.00 Device [HID  
041e:2801] on usb-dummy_hcd.0-1/input1
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:pcmidi_submit_output_report drivers/hid/hid-prodikeys.c:300  
[inline]
RIP: 0010:pcmidi_set_operational drivers/hid/hid-prodikeys.c:558 [inline]
RIP: 0010:pcmidi_snd_initialise drivers/hid/hid-prodikeys.c:686 [inline]
RIP: 0010:pk_probe+0xb51/0xfd0 drivers/hid/hid-prodikeys.c:836
Code: 0f 85 50 04 00 00 48 8b 04 24 4c 89 7d 10 48 8b 58 08 e8 b2 53 e4 fc  
48 8b 54 24 20 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 13 04 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff8881da20ee10 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8881d2d40000 RCX: ffffffff8459833e
RDX: 0000000000000006 RSI: ffffffff8459862e RDI: ffff8881d2aee610
RBP: ffff8881d2aee600 R08: ffff8881da1f9800 R09: ffffed103b64677c
R10: ffffed103b64677b R11: ffff8881db233bdb R12: ffff8881d2d40000
R13: 0000000000000000 R14: ffff8881d4ec4ab0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fc6afa518 CR3: 00000001d099d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  hid_device_probe+0x2be/0x3f0 drivers/hid/hid-core.c:2209
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  hid_add_device+0x33c/0x990 drivers/hid/hid-core.c:2365
  usbhid_probe+0xa81/0xfa0 drivers/hid/usbhid/hid-core.c:1386
  usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0x99/0x100 drivers/usb/core/driver.c:266
  really_probe+0x281/0x6d0 drivers/base/dd.c:548
  driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
  __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:828
  bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:894
  bus_probe_device+0x1e4/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x16f0 drivers/base/core.c:2165
  usb_new_device.cold+0x6a4/0xe79 drivers/usb/core/hub.c:2536
  hub_port_connect drivers/usb/core/hub.c:5098 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5213 [inline]
  port_event drivers/usb/core/hub.c:5359 [inline]
  hub_event+0x1b5c/0x3640 drivers/usb/core/hub.c:5441
  process_one_work+0x92b/0x1530 kernel/workqueue.c:2269
  worker_thread+0x96/0xe20 kernel/workqueue.c:2415
  kthread+0x318/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 57a1aecde3464295 ]---
RIP: 0010:pcmidi_submit_output_report drivers/hid/hid-prodikeys.c:300  
[inline]
RIP: 0010:pcmidi_set_operational drivers/hid/hid-prodikeys.c:558 [inline]
RIP: 0010:pcmidi_snd_initialise drivers/hid/hid-prodikeys.c:686 [inline]
RIP: 0010:pk_probe+0xb51/0xfd0 drivers/hid/hid-prodikeys.c:836
Code: 0f 85 50 04 00 00 48 8b 04 24 4c 89 7d 10 48 8b 58 08 e8 b2 53 e4 fc  
48 8b 54 24 20 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f  
85 13 04 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff8881da20ee10 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8881d2d40000 RCX: ffffffff8459833e
RDX: 0000000000000006 RSI: ffffffff8459862e RDI: ffff8881d2aee610
RBP: ffff8881d2aee600 R08: ffff8881da1f9800 R09: ffffed103b64677c
R10: ffffed103b64677b R11: ffff8881db233bdb R12: ffff8881d2d40000
R13: 0000000000000000 R14: ffff8881d4ec4ab0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2fc6afa518 CR3: 00000001d099d000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
