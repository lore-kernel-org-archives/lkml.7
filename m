Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ACEC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F322054F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 13:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfF2NMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 09:12:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56754 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfF2NMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 09:12:06 -0400
Received: by mail-io1-f69.google.com with SMTP id u25so9816464iol.23
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 06:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QF7ZegWJ1n5MPfTmqXNnQGuO4JOZBUIHhWo1sB5in0Y=;
        b=KAEndI7r/E9idxKioaZ4v2z47y7/sEir5z1BFPkJ/Rflg85hLKFSJ8tcBjFMDULnEK
         fajSysTrHYDdvZQd1hL6FOCdQ26oXmlMjiOizWJWqtOPN3x/OpeOT4ICXN9+IKv3ZC9z
         SpdCWh5NShstSpj978HDI8rpLWyac01uVHOfI72imLbF1PAKujEl9eQ2imy0BMlt+7Xu
         savZX9669zZbZZcm/c0qhP7spixxXGufV8/3dsbrhof8m0oDjYIayY+DuvUGXGdWbf5a
         mCCgzzyiWJXX2Vx8V2tNl7mU8QnF+2oE1VE3Cm3sxYOQqyEJaPyQclKwopIliAdEcl2Z
         vBQg==
X-Gm-Message-State: APjAAAXwO2mwgNL5QT1qm81F4CGhYAXh0JyEz12PT3Q/Z4G/F5zmIoz+
        vkaySl6Hjgr44ULDTpMiYtJ6GVBonrEUk+86s5EUbXAFGJ3o
X-Google-Smtp-Source: APXvYqwQIfzj7z82/c4IDnJoT5/I9JHDGXk91rbOyXthej9k54q/yE6x2zGDTOYij7mhBlbq99NAN1ZrqoU7BjYMK/nEphbWH3F/
MIME-Version: 1.0
X-Received: by 2002:a02:aa8f:: with SMTP id u15mr17334843jai.39.1561813925673;
 Sat, 29 Jun 2019 06:12:05 -0700 (PDT)
Date:   Sat, 29 Jun 2019 06:12:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ec128058c7624ec@google.com>
Subject: WARNING in kernfs_create_dir_ns
From:   syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    4b972a01 Linux 5.2-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14910879a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31528e58cc12e2
dashboard link: https://syzkaller.appspot.com/bug?extid=38f5d5cf7ae88c46b11a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 9071 at fs/kernfs/dir.c:493 kernfs_get  
fs/kernfs/dir.c:493 [inline]
WARNING: CPU: 0 PID: 9071 at fs/kernfs/dir.c:493 kernfs_new_node  
fs/kernfs/dir.c:700 [inline]
WARNING: CPU: 0 PID: 9071 at fs/kernfs/dir.c:493  
kernfs_create_dir_ns+0x205/0x230 fs/kernfs/dir.c:1022
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9071 Comm: syz-executor.1 Not tainted 5.2.0-rc6 #6
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x28a/0x7c9 kernel/panic.c:219
  __warn+0x216/0x220 kernel/panic.c:576
  report_bug+0x190/0x290 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x450 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:kernfs_get fs/kernfs/dir.c:493 [inline]
RIP: 0010:kernfs_new_node fs/kernfs/dir.c:700 [inline]
RIP: 0010:kernfs_create_dir_ns+0x205/0x230 fs/kernfs/dir.c:1022
Code: ff 4c 89 ff e8 7c cd ff ff 4c 63 fb eb 05 e8 e2 27 9a ff 4c 89 f8 48  
83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 cb 27 9a ff <0f> 0b e9 e9 fe  
ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c be fe ff
RSP: 0018:ffff88805a66f590 EFLAGS: 00010287
RAX: ffffffff81db8a25 RBX: ffff88808fad88c0 RCX: 0000000000040000
RDX: ffffc90007ff6000 RSI: 000000000001e1a2 RDI: 000000000001e1a3
RBP: ffff88805a66f5c8 R08: ffffffff81db8907 R09: ffffed1011f5b119
R10: ffffed1011f5b119 R11: 1ffff11011f5b118 R12: ffff888098366600
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff8880a8f66620
  sysfs_create_dir_ns+0x161/0x300 fs/sysfs/dir.c:59
  create_dir lib/kobject.c:89 [inline]
  kobject_add_internal+0x459/0xd50 lib/kobject.c:255
  kobject_add_varg lib/kobject.c:390 [inline]
  kobject_add+0x138/0x200 lib/kobject.c:442
  device_add+0x508/0x1570 drivers/base/core.c:2062
  hci_register_dev+0x331/0x6c0 net/bluetooth/hci_core.c:3305
  hci_uart_register_dev drivers/bluetooth/hci_ldisc.c:661 [inline]
  hci_uart_set_proto drivers/bluetooth/hci_ldisc.c:685 [inline]
  hci_uart_tty_ioctl+0x815/0x970 drivers/bluetooth/hci_ldisc.c:739
  tty_ioctl+0xf66/0x15d0 drivers/tty/tty_io.c:2664
  do_vfs_ioctl+0x7d4/0x1890 fs/ioctl.c:46
  ksys_ioctl fs/ioctl.c:713 [inline]
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0xe3/0x120 fs/ioctl.c:718
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459519
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb578425c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459519
RDX: 0000000000000009 RSI: 00000000400455c8 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb5784266d4
R13: 00000000004c21a5 R14: 00000000004d5330 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
