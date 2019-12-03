Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB77C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF082053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLCI1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:27:09 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:51413 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCI1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:27:08 -0500
Received: by mail-io1-f72.google.com with SMTP id t18so1837794iob.18
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=3qLCreTXyZIsDgIjHfiKVMA4tqyANILldnEk8jfESE8=;
        b=S4kBcAA5+4F05RmGBqeUaaQ/qPVNeeQg3UIj0aFxdjnzL6ieUXftpcigiM4Dc2hgLT
         CjyCygcsom+Pgk0Oaa/8JD6zu3ttoWzZ9ZKhLhET5b5cf0x2mGZ7VNVRMlhcSZF1erUt
         saO8oMfod4ZGokNXJehc3fBrEVRB6Zh49w95MfJh0gxgFmcRc9MR8kqnqrkxj7UF6GfW
         U/UM44yLkpfQpeaZfNwSVS4n48KGtNBmXX+saxXPLRrql0rZG230+7lO04Jsv5e2sru2
         pcgGXBBpdZwkf+9Il59dEFKiATjPYP+uv44I9gO/T3Tpv78Wkk6zKEpg95iYySoOKWvT
         osuA==
X-Gm-Message-State: APjAAAXk/Zr+Wv2PAElhL+xGFQ3T5dZ5iEtKnvBTnBQYlpXk3zLBpcAR
        ji/IdXpZ9nCcSzLUamuj8UuPc++LdgFhVuqna5CHx4/bC6A1
X-Google-Smtp-Source: APXvYqwn+P6k3y9w6Cq0pzphn66uiLaaCHB0hMjNGHaoLl0AoPXQJbSORLXS3cfqLLkQishKB4NHhQc2aR6JXBBnz/gIGf2LlD9l
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41b:: with SMTP id q27mr4248351jap.135.1575361627739;
 Tue, 03 Dec 2019 00:27:07 -0800 (PST)
Date:   Tue, 03 Dec 2019 00:27:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036decf0598c8762e@google.com>
Subject: INFO: rcu detected stall in sys_kill
From:   syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, christian@kellner.me, cyphar@cyphar.com,
        elena.reshetova@intel.com, jgg@ziepe.ca, keescook@chromium.org,
        ldv@altlinux.org, linux-kernel@vger.kernel.org,
        luto@amacapital.net, mingo@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f11c2ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bbcda576154a4b4
dashboard link: https://syzkaller.appspot.com/bug?extid=de8d933e7d153aa0c1bb
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 1, t=10502 jiffies, g=6629, q=331)
rcu: All QSes seen, last rcu_preempt kthread activity 10503  
(4294953794-4294943291), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor.0  R  running task    24648  8293   8292 0x0000400a
Call Trace:
  <IRQ>
  sched_show_task+0x40f/0x560 kernel/sched/core.c:5954
  print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
  rcu_pending kernel/rcu/tree.c:2827 [inline]
  rcu_sched_clock_irq+0x1861/0x1ad0 kernel/rcu/tree.c:2271
  update_process_times+0x12d/0x180 kernel/time/timer.c:1726
  tick_sched_handle kernel/time/tick-sched.c:167 [inline]
  tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
  __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
  __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1576
  hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1638
  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
  smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:1135
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
  </IRQ>
RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x1c/0x50 kernel/kcov.c:102
Code: cc 07 48 89 de e8 64 02 3b 00 5b 5d c3 cc 48 8b 04 24 65 48 8b 0c 25  
c0 1d 02 00 65 8b 15 b8 81 8b 7e f7 c2 00 01 1f 00 75 2c <8b> 91 80 13 00  
00 83 fa 02 75 21 48 8b 91 88 13 00 00 48 8b 32 48
RSP: 0018:ffffc900021c7c28 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: ffffffff81487433 RBX: 0000000000000000 RCX: ffff88809428a100
RDX: 0000000000000001 RSI: 00000000fffffffc RDI: ffffea0002479240
RBP: ffffc900021c7c50 R08: dffffc0000000000 R09: fffffbfff1287025
R10: fffffbfff1287025 R11: 0000000000000000 R12: dffffc0000000000
R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff888091c57428
  free_thread_stack+0x168/0x590 kernel/fork.c:280
  release_task_stack kernel/fork.c:440 [inline]
  put_task_stack+0xa3/0x130 kernel/fork.c:451
  finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
  context_switch kernel/sched/core.c:3388 [inline]
  __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
  preempt_schedule_common kernel/sched/core.c:4236 [inline]
  preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
  ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
  __raw_read_unlock include/linux/rwlock_api_smp.h:227 [inline]
  _raw_read_unlock+0x3a/0x40 kernel/locking/spinlock.c:255
  kill_something_info kernel/signal.c:1586 [inline]
  __do_sys_kill kernel/signal.c:3640 [inline]
  __se_sys_kill+0x5e9/0x6c0 kernel/signal.c:3634
  __x64_sys_kill+0x5b/0x70 kernel/signal.c:3634
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x422a17
Code: 44 00 00 48 c7 c2 d4 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e  
0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 3e 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 dd 32 ff ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff38dca538 EFLAGS: 00000293 ORIG_RAX: 000000000000003e
RAX: ffffffffffffffda RBX: 0000000000000064 RCX: 0000000000422a17
RDX: 0000000000000bb8 RSI: 0000000000000009 RDI: 00000000fffffffe
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000001c62940
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000008
R13: 00007fff38dca570 R14: 000000000000f0b6 R15: 00007fff38dca580
rcu: rcu_preempt kthread starved for 10533 jiffies! g6629 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29032    10      2 0x80004008
Call Trace:
  context_switch kernel/sched/core.c:3388 [inline]
  __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
  schedule+0x181/0x210 kernel/sched/core.c:4155
  schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
  rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
  rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
