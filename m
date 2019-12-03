Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC74BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01862053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLCI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:28:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:47639 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:28:09 -0500
Received: by mail-io1-f69.google.com with SMTP id y16so1871604ior.14
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YkkGLFmV25ExSsW2LOMdoHYVSZ68ffMoAv41ZrGcmhQ=;
        b=mI/2cChw/kwMoaJhT8EvoZmAG4ygKK5g4lfHHmKmvGXaJfbjYqYStA/WkM0U4rvLHG
         RrEu/9+vRYKnIQLHcQQA97eh4cHekuZT78/n3T7nyC0oGLiYOgu2sdn5g7MwYK4vYH5N
         gxRqsM8l3evLrPAwGOIyl9U7YVvEL85Ff3NugtltBncem0SZAuEBOXRhu3bQOQPtpenJ
         Of9T6zya2hpONwtuCkT8WuYe6PAnKY0l+f+LZaTH9PIhh0OoKqeZCJo8ZEWDfPFfg4kl
         5Is8r+8MrL9m/4iiN6ihjdOY+mmyEncF2p74VwtWrSd13lq8KwfHLfuw3Wteg7X52tT4
         gfuQ==
X-Gm-Message-State: APjAAAURZ5j977JRBsYuiZifr1NEhP577aoLnC0AAoYso1E9mbFDdsmN
        4ZcGcnZNlr3JonE4+9On5PkwKNnPzjxH4SMHs6eF+NeUIoeZ
X-Google-Smtp-Source: APXvYqwS36E42Ua2rCbA8fXqwyEP/EdnFjNqnVzWNcLRviagM+QR/cw5f7VMLV1tYB6GDk8QEzHniXCwqDwH4OVPhr8JX0oChkWu
MIME-Version: 1.0
X-Received: by 2002:a92:9f97:: with SMTP id z23mr3387778ilk.21.1575361688272;
 Tue, 03 Dec 2019 00:28:08 -0800 (PST)
Date:   Tue, 03 Dec 2019 00:28:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2a8cc0598c8798f@google.com>
Subject: INFO: rcu detected stall in pipe_read
From:   syzbot <syzbot+7047406d4ba783c8eb7b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17b1af36e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bbcda576154a4b4
dashboard link: https://syzkaller.appspot.com/bug?extid=7047406d4ba783c8eb7b
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7047406d4ba783c8eb7b@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
	(detected by 0, t=10502 jiffies, g=5977, q=61)
rcu: All QSes seen, last rcu_preempt kthread activity 10503  
(4294953644-4294943141), jiffies_till_next_fqs=1, root ->qsmask 0x0
syz-executor.0  R  running task    24296  8125   8124 0x0000400a
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
RIP: 0010:mod_memcg_page_state+0x2b/0x190 include/linux/memcontrol.h:653
Code: 48 89 e5 41 57 41 56 41 54 53 41 89 f6 48 89 fb e8 da 28 2e 00 48 83  
c3 38 48 89 d8 48 c1 e8 03 49 bc 00 00 00 00 00 fc ff df <42> 80 3c 20 00  
74 08 48 89 df e8 b6 9f 69 00 48 8b 1b 48 85 db 0f
RSP: 0018:ffffc90001f27998 EFLAGS: 00000a02 ORIG_RAX: ffffffffffffff13
RAX: 1ffffd40005452bf RBX: ffffea0002a295f8 RCX: ffff88808f094580
RDX: 0000000000000000 RSI: 00000000fffffffc RDI: ffffea0002a295c0
RBP: ffffc90001f279b8 R08: dffffc0000000000 R09: fffffbfff1287025
R10: fffffbfff1287025 R11: 0000000000000000 R12: dffffc0000000000
R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff8880a8a6f4a8
  free_thread_stack+0x168/0x590 kernel/fork.c:280
  release_task_stack kernel/fork.c:440 [inline]
  put_task_stack+0xa3/0x130 kernel/fork.c:451
  finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
  context_switch kernel/sched/core.c:3388 [inline]
  __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
  preempt_schedule_common kernel/sched/core.c:4236 [inline]
  preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
  ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
  _raw_spin_unlock_irqrestore+0xcc/0xe0 kernel/locking/spinlock.c:191
  spin_unlock_irqrestore include/linux/spinlock.h:393 [inline]
  __wake_up_common_lock kernel/sched/wait.c:125 [inline]
  __wake_up+0xe1/0x150 kernel/sched/wait.c:142
  pipe_read+0x8e1/0x9e0 fs/pipe.c:374
  call_read_iter include/linux/fs.h:1896 [inline]
  new_sync_read fs/read_write.c:414 [inline]
  __vfs_read+0x59e/0x730 fs/read_write.c:427
  vfs_read+0x1dd/0x420 fs/read_write.c:461
  ksys_read+0x117/0x220 fs/read_write.c:587
  __do_sys_read fs/read_write.c:597 [inline]
  __se_sys_read fs/read_write.c:595 [inline]
  __x64_sys_read+0x7b/0x90 fs/read_write.c:595
  do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x414190
Code: 01 f0 ff ff 0f 83 90 1b 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f  
44 00 00 83 3d dd 42 66 00 00 75 14 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 64 1b 00 00 c3 48 83 ec 08 e8 6a fc ff ff
RSP: 002b:00007fff84902588 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000414190
RDX: 0000000000000038 RSI: 0000000000758040 RDI: 00000000000000f9
RBP: 0000000000000002 R08: 00000000000003b8 R09: 0000000000004000
R10: 0000000000717660 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff849025c0 R14: 000000000000e9c4 R15: 00007fff849025d0
rcu: rcu_preempt kthread starved for 10534 jiffies! g5977 f0x2  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29104    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x9a0/0xcc0 kernel/sched/core.c:4081
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
