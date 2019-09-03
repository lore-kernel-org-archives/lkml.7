Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC9BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B13221897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfICTEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:04:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33118 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfICTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:04:08 -0400
Received: by mail-io1-f71.google.com with SMTP id 5so24273690ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ggJvVtMwVhNhQHN6gDzzosmGm7u52Y8RU1Pq44M1vzo=;
        b=H5LWES62uXCy1HwXdnA5Nb+j/SNCvFk9BM6jC57F0F0VedYzrMC+jcTKrzaOcQzmBj
         pRg+JbmvFGQjxUTR2HWvFEJmgQzDh9+RQWjfWFNer+iRd1Etzcqs4R/Id2YMtHvLPEuc
         45h8bl1F/n/LJFFiYWF4E/x2aZGMwqh8SCP1+30XDs2GcMZU0f9e/BV6MpgE4ZRlcKZ0
         /kOHgsi0o50yfrTp23wMbPRQQyMZEVoMXYpJ/0pLgMXXwze4nyzoeqcMDnWSaJoq9c9C
         T1u2UZ95epycXFXGwvYlHL8FCz4sSl9X/DXkpKtDtcFRpbJHWeV7xdo0yUry51PA+tp1
         G/Ng==
X-Gm-Message-State: APjAAAVE4NWSKT42ufRICWH+43PbBAZtphSw9+/HmcxtD0gbg9CGDH6r
        sNeEo2ASdslrXpM37hAn8AAIIxE2xAV12lSl6joaTQw8xmJt
X-Google-Smtp-Source: APXvYqyAr4lM/K4Q36xxiGHskjtOJEqbMJ9j3gJ54NOxeX+uXRdjwaRPWkvo+iiAXHLNGTu8f+KGdo106jiu2gxQjugcnR1HgHuJ
MIME-Version: 1.0
X-Received: by 2002:a5e:d80e:: with SMTP id l14mr1179553iok.217.1567537447635;
 Tue, 03 Sep 2019 12:04:07 -0700 (PDT)
Date:   Tue, 03 Sep 2019 12:04:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd19720591aac025@google.com>
Subject: INFO: trying to register non-static key in hci_uart_flush (2)
From:   syzbot <syzbot+576dfca25381fb6fbc5f@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6d028043 Add linux-next specific files for 20190830
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141d6cae600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82a6bec43ab0cb69
dashboard link: https://syzkaller.appspot.com/bug?extid=576dfca25381fb6fbc5f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+576dfca25381fb6fbc5f@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 31436 Comm: syz-executor.2 Not tainted 5.3.0-rc6-next-20190830  
#75
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:881 [inline]
  register_lock_class+0x179e/0x1850 kernel/locking/lockdep.c:1190
  __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3837
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
  hci_uart_flush+0x110/0x510 drivers/bluetooth/hci_ldisc.c:241
  hci_uart_close drivers/bluetooth/hci_ldisc.c:267 [inline]
  hci_uart_tty_close+0x8e/0x280 drivers/bluetooth/hci_ldisc.c:534
  tty_ldisc_close.isra.0+0x119/0x1a0 drivers/tty/tty_ldisc.c:494
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:642
  tty_ldisc_release+0xe9/0x2b0 drivers/tty/tty_ldisc.c:814
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1612
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1785
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  get_signal+0x2078/0x2500 kernel/signal.c:2528
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459879
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5b36328c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000459879
RDX: 0000000000000002 RSI: 00000000400455c8 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5b363296d4
R13: 00000000004c2586 R14: 00000000004d5ae8 R15: 00000000ffffffff
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 31436 Comm: syz-executor.2 Not tainted 5.3.0-rc6-next-20190830  
#75
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0d 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff8880979bf818 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880a7ff48b8 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff138b536 RDI: 0000000000000000
RBP: ffff8880979bf870 R08: ffffffffffffffe8 R09: 0000000000000000
R10: ffffed1012f37efe R11: 0000000000000003 R12: ffff8880a7ff4900
R13: ffff8880a7ff48b0 R14: 0000000000000000 R15: ffff8880a7ff48b8
FS:  00007f5b36329700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a81a2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __wake_up_locked+0x11/0x20 kernel/sched/wait.c:151
  rcu_sync_func+0x16f/0x200 kernel/rcu/sync.c:87
  rcu_sync_enter+0x158/0x310 kernel/rcu/sync.c:150
  percpu_down_write+0x61/0x440 kernel/locking/percpu-rwsem.c:146
  hci_uart_tty_close+0x154/0x280 drivers/bluetooth/hci_ldisc.c:537
  tty_ldisc_close.isra.0+0x119/0x1a0 drivers/tty/tty_ldisc.c:494
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:642
  tty_ldisc_release+0xe9/0x2b0 drivers/tty/tty_ldisc.c:814
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1612
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1785
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  get_signal+0x2078/0x2500 kernel/signal.c:2528
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459879
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5b36328c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000459879
RDX: 0000000000000002 RSI: 00000000400455c8 RDI: 0000000000000003
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5b363296d4
R13: 00000000004c2586 R14: 00000000004d5ae8 R15: 00000000ffffffff
Modules linked in:
---[ end trace d1da9c36c5e69966 ]---
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0d 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff8880979bf818 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff8880a7ff48b8 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff138b536 RDI: 0000000000000000
RBP: ffff8880979bf870 R08: ffffffffffffffe8 R09: 0000000000000000
R10: ffffed1012f37efe R11: 0000000000000003 R12: ffff8880a7ff4900
R13: ffff8880a7ff48b0 R14: 0000000000000000 R15: ffff8880a7ff48b8
FS:  00007f5b36329700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffff600400 CR3: 00000000a81a2000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
