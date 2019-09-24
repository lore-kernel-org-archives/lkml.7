Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C9C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F345A2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 12:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440931AbfIXMJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 08:09:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35429 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfIXMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 08:09:11 -0400
Received: by mail-io1-f71.google.com with SMTP id r5so2739079iop.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 05:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VflEvtMKTJZm6UIwz/EKSbfBYk+H3uv1O+TxeI/B3uk=;
        b=ZJmnCX/9TPcjfN7n/GAsaveTIfNEwiu+hg7GfNFQ9m3kbqsHbeVJfLBIxZf+YF+97l
         qEzP1lpRcuIaQoEyDpeaK163m2X/xK2TqdG+DxQDdM13d8/YktRZimOB8L0Pf0grKtB/
         XyypZ3tWsBB8PtsN2kDYxo3O2TXyDvoK+PTk5p00AxWNk/qAiiFXFR63XDAZ/z5nVjD3
         4tG7KOhVEG+5dyFBPNXf2Y2QVDVm/ALCHpWsmawRADiacpPr4qrHWuh0g4vE5/0dO2w5
         PIYLIKjyXLKVM3tppI8lQDzFw2to5g+mNNcw3YOEK+RG9U+/179NzPYiPlhxZfI33oX5
         BQPw==
X-Gm-Message-State: APjAAAWVvkoReQh5fyHXncGpFP/G4pr0nQqphuyqjF5DZBitES1Twxbp
        xTi+s3S3vXZJ1QDU8xEoEEa+naaaxP20O1K9bzLGoxjxDDpM
X-Google-Smtp-Source: APXvYqzi13VJjfpQWgpOcGuMvwJ4sxVipz+oGIsbv8Bc/wpY9IG/EEWEZk4aWWbywpK02aD05umEVVJgUKJJjwKvH7C3ObVqMDuZ
MIME-Version: 1.0
X-Received: by 2002:a6b:5a1a:: with SMTP id o26mr2992720iob.65.1569326947244;
 Tue, 24 Sep 2019 05:09:07 -0700 (PDT)
Date:   Tue, 24 Sep 2019 05:09:07 -0700
In-Reply-To: <000000000000bd19720591aac025@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a22d605934b6722@google.com>
Subject: Re: INFO: trying to register non-static key in hci_uart_flush (2)
From:   syzbot <syzbot+576dfca25381fb6fbc5f@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    e94f8ccd Merge tag 'smack-for-5.4-rc1' of git://github.com..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16713de9600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df38eec565aab18d
dashboard link: https://syzkaller.appspot.com/bug?extid=576dfca25381fb6fbc5f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12881a9d600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+576dfca25381fb6fbc5f@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 9385 Comm: syz-executor.3 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  assign_lock_key kernel/locking/lockdep.c:881 [inline]
  register_lock_class+0x179e/0x1850 kernel/locking/lockdep.c:1190
  __lock_acquire+0xf4/0x4e70 kernel/locking/lockdep.c:3837
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
  hci_uart_flush+0x110/0x510 drivers/bluetooth/hci_ldisc.c:241
  hci_uart_close drivers/bluetooth/hci_ldisc.c:267 [inline]
  hci_uart_tty_close+0x8e/0x280 drivers/bluetooth/hci_ldisc.c:534
  tty_ldisc_close.isra.0+0x119/0x190 drivers/tty/tty_ldisc.c:494
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:642
  tty_ldisc_release+0xe9/0x2b0 drivers/tty/tty_ldisc.c:814
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1612
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1785
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x92f/0x2e50 kernel/exit.c:879
  do_group_exit+0x135/0x360 kernel/exit.c:983
  get_signal+0x47c/0x2500 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a09
Code: Bad RIP value.
RSP: 002b:00007fe8f55a0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000459a09
RDX: 0000000000000002 RSI: 00000000400455c8 RDI: 0000000000000006
RBP: 000000000075c118 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe8f55a16d4
R13: 00000000004c26f7 R14: 00000000004d5df8 R15: 00000000ffffffff
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9385 Comm: syz-executor.3 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0b 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff888097617698 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88809612eb38 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff138dcf6 RDI: 0000000000000000
RBP: ffff8880976176f0 R08: ffffffffffffffe8 R09: 0000000000000000
R10: ffffed1012ec2ece R11: 0000000000000003 R12: ffff88809612eb80
R13: ffff88809612eb30 R14: 0000000000000000 R15: ffff88809612eb38
FS:  00007fe8f55a1700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004599df CR3: 000000008ff2c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __wake_up_locked+0x11/0x20 kernel/sched/wait.c:151
  rcu_sync_func+0x16f/0x200 kernel/rcu/sync.c:87
  rcu_sync_enter+0x158/0x310 kernel/rcu/sync.c:150
  percpu_down_write+0x61/0x437 kernel/locking/percpu-rwsem.c:146
  hci_uart_tty_close+0x154/0x280 drivers/bluetooth/hci_ldisc.c:537
  tty_ldisc_close.isra.0+0x119/0x190 drivers/tty/tty_ldisc.c:494
  tty_ldisc_kill+0x9c/0x160 drivers/tty/tty_ldisc.c:642
  tty_ldisc_release+0xe9/0x2b0 drivers/tty/tty_ldisc.c:814
  tty_release_struct+0x1b/0x50 drivers/tty/tty_io.c:1612
  tty_release+0xbcb/0xe90 drivers/tty/tty_io.c:1785
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x92f/0x2e50 kernel/exit.c:879
  do_group_exit+0x135/0x360 kernel/exit.c:983
  get_signal+0x47c/0x2500 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a09
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe8f55a0c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000459a09
RDX: 0000000000000002 RSI: 00000000400455c8 RDI: 0000000000000006
RBP: 000000000075c118 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe8f55a16d4
R13: 00000000004c26f7 R14: 00000000004d5df8 R15: 00000000ffffffff
Modules linked in:
---[ end trace cf75381aeb7c112c ]---
RIP: 0010:__wake_up_common+0xdf/0x610 kernel/sched/wait.c:86
Code: 05 00 00 4c 8b 43 38 49 83 e8 18 49 8d 78 18 48 39 7d d0 0f 84 64 02  
00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <80> 3c 01 00 0f  
85 0b 05 00 00 49 8b 40 18 89 55 b0 31 db 49 bc 00
RSP: 0018:ffff888097617698 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88809612eb38 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 1ffffffff138dcf6 RDI: 0000000000000000
RBP: ffff8880976176f0 R08: ffffffffffffffe8 R09: 0000000000000000
R10: ffffed1012ec2ece R11: 0000000000000003 R12: ffff88809612eb80
R13: ffff88809612eb30 R14: 0000000000000000 R15: ffff88809612eb38
FS:  00007fe8f55a1700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004599df CR3: 000000008ff2c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

