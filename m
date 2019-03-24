Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B937C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB56421741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCXGWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 02:22:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:40340 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXGWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 02:22:07 -0400
Received: by mail-it1-f197.google.com with SMTP id j8so5314847ita.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 23:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JgBehIPd0SstoKCpEs5/CiE2xmMN7/RVHQjZca+KoWY=;
        b=lyrbtPYXxy0VZaRCldCrkbGxOlkLlCfynmjbH/+IusGz5eZg5yk1fQFA5HHEf+VIps
         nElkZE/VQqpcLwjzXZ7cbgKNWJx7pjTvJy3qLKW4Lvt205kyCcAS035Hq85bhdvqGB2O
         4gB62FSJbPlbPdMU7l+vVSMFYiP4Ic16HrqJp4x6qFIL/j2nOsUiM0C4KY1hLuvOHl3R
         LcFuMEyICW6Dwqd+Z1S5vj9hV/S9xrt2c6hSGstjHopZ2FM3DxodbnF7cfhgRN82htnc
         tA+LDDaOYEjg6p3svZBP0ETcicD6LUPeeCO9Lk/Spce+ynoPR9PuLAjpsKGw4VBsSywL
         nDSQ==
X-Gm-Message-State: APjAAAUDlEDjQmSADSuN/J7XPDT1hYJPkvIacKF6XZGUp+5hAz1Qgbb0
        4JFkrAIh+o/Vwn5YvLPzykkqBxA2Bkmc8Z7qVYfnL0WgWfma
X-Google-Smtp-Source: APXvYqzfSdHvD4Ou8YDTaSeR56MletqWtmPLtkhWbn1n++TjKA99SoWhWz7Teo8c8bazt3Zrr7RKJqvIxnzXmblr728Aj8KBWiHA
MIME-Version: 1.0
X-Received: by 2002:a5e:830c:: with SMTP id x12mr12007961iom.224.1553408526096;
 Sat, 23 Mar 2019 23:22:06 -0700 (PDT)
Date:   Sat, 23 Mar 2019 23:22:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000639f6a0584d11b82@google.com>
Subject: WARNING in arch_install_hw_breakpoint
From:   syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>
To:     bp@alien8.de, frederic@kernel.org, gustavo@embeddedor.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fd1f297b Merge tag 'drm-fixes-2019-03-22' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1574f56d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=370a6b0f11867bf13515
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1157b7cf200000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10ca39b3200000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12ca39b3200000
console output: https://syzkaller.appspot.com/x/log.txt?x=14ca39b3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com

------------[ cut here ]------------
Can't find any breakpoint slot
WARNING: CPU: 0 PID: 8058 at arch/x86/kernel/hw_breakpoint.c:121  
arch_install_hw_breakpoint+0x2d6/0x3a0 arch/x86/kernel/hw_breakpoint.c:121
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8058 Comm: syz-executor.1 Not tainted 5.1.0-rc1+ #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:arch_install_hw_breakpoint+0x2d6/0x3a0  
arch/x86/kernel/hw_breakpoint.c:121
Code: c8 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 0f 0b 48 c7 c7  
40 23 65 87 89 45 d4 c6 05 ed 9d 32 08 01 e8 98 43 1b 00 <0f> 0b 8b 45 d4  
e9 bc fd ff ff 40 88 75 c8 e8 a7 8e 80 00 0f b6 75
RSP: 0018:ffff8880a512f6d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: ffff8880ae81ec98 RCX: 0000000000000000
RDX: 0000000040000000 RSI: ffffffff815ae266 RDI: ffffed1014a25ecd
RBP: ffff8880a512f718 R08: ffff8880857382c0 R09: fffffbfff11335f5
R10: fffffbfff11335f4 R11: ffffffff8899afa3 R12: ffff888085730380
R13: dffffc0000000000 R14: 0000000000000004 R15: 000000000001eca0
  hw_breakpoint_add+0xa7/0x130 kernel/events/hw_breakpoint.c:632
  event_sched_in kernel/events/core.c:2281 [inline]
  event_sched_in.isra.0+0x373/0xbf0 kernel/events/core.c:2245
  group_sched_in+0xe4/0x3d0 kernel/events/core.c:2317
  flexible_sched_in+0x615/0x9c0 kernel/events/core.c:3311
  visit_groups_merge+0x336/0x5d0 kernel/events/core.c:3259
  ctx_flexible_sched_in kernel/events/core.c:3345 [inline]
  ctx_sched_in+0x330/0x670 kernel/events/core.c:3390
  perf_event_sched_in+0x6e/0xa0 kernel/events/core.c:2426
  perf_event_context_sched_in kernel/events/core.c:3430 [inline]
  __perf_event_task_sched_in+0x609/0x820 kernel/events/core.c:3469
  perf_event_task_sched_in include/linux/perf_event.h:1115 [inline]
  finish_task_switch+0x2c2/0x780 kernel/sched/core.c:2725
  context_switch kernel/sched/core.c:2880 [inline]
  __schedule+0x81f/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  freezable_schedule include/linux/freezer.h:172 [inline]
  ptrace_stop+0x3fe/0x950 kernel/signal.c:2111
  do_jobctl_trap kernel/signal.c:2330 [inline]
  get_signal+0x1502/0x1d50 kernel/signal.c:2456
  do_signal+0x87/0x1940 arch/x86/kernel/signal.c:816
  exit_to_usermode_loop+0x244/0x2c0 arch/x86/entry/common.c:162
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458209
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6b1a2a8c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000129
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000458209
RDX: 0000000000000016 RSI: 000000000000002a RDI: 000000000000002a
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000100 R11: 0000000000000246 R12: 00007f6b1a2a96d4
R13: 00000000004c4f84 R14: 00000000004d8bd8 R15: 00000000ffffffff

======================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
