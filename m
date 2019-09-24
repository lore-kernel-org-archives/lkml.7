Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E28C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336E021906
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 08:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504038AbfIXIGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 04:06:09 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39997 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503934AbfIXIGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 04:06:08 -0400
Received: by mail-io1-f72.google.com with SMTP id r20so1788849ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 01:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GqvdOrn4bCaeW46Vp64HQvAmLWjeyXNtcqKXSxDqmzs=;
        b=EysvqsAM6jtVF1n9HObbhTfpYt5kmt1C/LBP3lp7Kg9T2geBrrkgiv3b4l4bYoLDA8
         fnfUXkU2snSYN3ToJzpA57o+DI5vtNP6/s5TXBklAAYsRBduw2W54AgKY4zZYhaVzMe3
         2dlhnWzwmos+mSxz6bI0ClvZ6iqj2LN8jYktCag65Lqd7woi1ov3Uzz3FBlgY+E6ByIW
         LlobMCsp0W4+l4v6LH4LGAJY0BcXcncw4rnrJ4/f4vgVVtN5pM4WsiAs9u7fMhbYNTKT
         WggZyRyJv/caEEqEan4Z4inPKR7KmDnG+dlZu2W5mRhl+OqiDMgjnokQgj5ezMX+Im4b
         lA7Q==
X-Gm-Message-State: APjAAAUmJ8Ibet4LrcSMsJF19DmRXCRgc4qQEivYtuEXS8uu5EhkXNyW
        Un/v/ad6TNVlRPzS9Zpj9Fp5eNfaUOImGaJoXxbfYnOUtl2/
X-Google-Smtp-Source: APXvYqzIhHdkXtvQLhH4qAE1kLzCbK7ohlK3BMtaG1Dqfyi9RSEyEPN+s8ld70cRrLhV7laCs8bexrhU4xFuMTLrlokyFczbjnYx
MIME-Version: 1.0
X-Received: by 2002:a5d:85da:: with SMTP id e26mr2184470ios.101.1569312366485;
 Tue, 24 Sep 2019 01:06:06 -0700 (PDT)
Date:   Tue, 24 Sep 2019 01:06:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025669e05934802d6@google.com>
Subject: WARNING in mark_lock (2)
From:   syzbot <syzbot+ef8a7c8214359d969c69@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b41dae06 Merge tag 'xfs-5.4-merge-7' of git://git.kernel.o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b6d8e9600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfcf592db22b9132
dashboard link: https://syzkaller.appspot.com/bug?extid=ef8a7c8214359d969c69
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ef8a7c8214359d969c69@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 20740 at kernel/locking/lockdep.c:167 hlock_class  
kernel/locking/lockdep.c:167 [inline]
WARNING: CPU: 1 PID: 20740 at kernel/locking/lockdep.c:167 hlock_class  
kernel/locking/lockdep.c:156 [inline]
WARNING: CPU: 1 PID: 20740 at kernel/locking/lockdep.c:167  
mark_lock+0x22b/0x1220 kernel/locking/lockdep.c:3643
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 20740 Comm: kworker/u4:10 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:hlock_class kernel/locking/lockdep.c:167 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:156 [inline]
RIP: 0010:mark_lock+0x22b/0x1220 kernel/locking/lockdep.c:3643
Code: d0 7c 08 84 d2 0f 85 a8 0e 00 00 44 8b 1d 9d 6d 6e 08 45 85 db 75 b6  
48 c7 c6 a0 26 ac 87 48 c7 c7 e0 26 ac 87 e8 2d 79 eb ff <0f> 0b 31 db e9  
aa fe ff ff 48 c7 c7 e0 60 ae 8a e8 30 8e 54 00 e9
RSP: 0018:ffff88805d72f8d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c26d6 RDI: ffffed100bae5f0d
RBP: ffff88805d72f928 R08: ffff88806aefa480 R09: fffffbfff11f40b9
R10: fffffbfff11f40b8 R11: ffffffff88fa05c3 R12: 0000000000000008
R13: ffff88806aefad68 R14: 0000000000000000 R15: 00000000000c095a
  mark_usage kernel/locking/lockdep.c:3592 [inline]
  __lock_acquire+0x538/0x4e70 kernel/locking/lockdep.c:3909
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
  __wake_up_common_lock+0xc8/0x150 kernel/sched/wait.c:122
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  finish_writeback_work.isra.0+0xf6/0x120 fs/fs-writeback.c:168
  wb_do_writeback fs/fs-writeback.c:2030 [inline]
  wb_workfn+0x34f/0x11e0 fs/fs-writeback.c:2070
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
