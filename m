Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86482C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAEB2068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:28:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54978 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfLCI2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:28:09 -0500
Received: by mail-il1-f198.google.com with SMTP id t4so2228438ili.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 00:28:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=I7rcQmwfIbeK/2kSIo/uGzZ2sonRERQMbPH4M/WIWxY=;
        b=lxEErllP7X1al94mX79k53vAz2cimJKpgOCcu6+i/Wsk7vfRNMqyyZgBAbt6iX01Jb
         imf+BTDhY8YbcEhMJGmxy6a/49DZiBnEMtKvjvVHf6tW+kl3DHSXZ6YhcmeqoNxKaI4D
         woNgzut12Su76t87dmS66cS80RJJP0JrFaHFcmPNraaK23IgQcNJQ4JExVcJj79CcLRO
         4g5ZFPauDi3yXnBqN/5yAc9b0f27fZ9XJOeGO14fZrUMDGTDSE4gmomZIuBVc8P6Z7vd
         +xgimh0YNG7BgOqPJlEWyTsT2oBG+pw/sL7HRNjpQTLG4sZPrJ6PQbsnjpei2pZH30+y
         N0KQ==
X-Gm-Message-State: APjAAAXqTJxnAOy7XGVHm8tQtSRuhRniyrO2WKytpREENahxQUXM/qHC
        96HGKw3Tt43BFWbwQCumtgznMg5w25mGslIyDi/44KvakXzE
X-Google-Smtp-Source: APXvYqzz+jr2ngWD+O6pNZnko3OMXR7AyyQ7x6CZVU3AzDUZSdcgSccP2RdPDc0H+rIcCCDaIoR2/3PDhDgHwjGP6uufuugR3mp3
MIME-Version: 1.0
X-Received: by 2002:a6b:7846:: with SMTP id h6mr1280845iop.33.1575361688479;
 Tue, 03 Dec 2019 00:28:08 -0800 (PST)
Date:   Tue, 03 Dec 2019 00:28:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5b2330598c87921@google.com>
Subject: INFO: rcu detected stall in security_file_free
From:   syzbot <syzbot+6176df02eb1a01d00646@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1327942ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bbcda576154a4b4
dashboard link: https://syzkaller.appspot.com/bug?extid=6176df02eb1a01d00646
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6176df02eb1a01d00646@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	0-...!: (10499 ticks this GP) idle=f6a/1/0x4000000000000002  
softirq=9928/9928 fqs=38
	(t=10501 jiffies g=6205 q=398)
rcu: rcu_preempt kthread starved for 10424 jiffies! g6205 f0x0  
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: RCU grace-period kthread stack dump:
rcu_preempt     R  running task    29032    10      2 0x80004000
Call Trace:
  context_switch kernel/sched/core.c:3385 [inline]
  __schedule+0x9a0/0xcc0 kernel/sched/core.c:4081
  schedule+0x181/0x210 kernel/sched/core.c:4155
  schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
  rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
  rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
  kthread+0x332/0x350 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
NMI backtrace for cpu 0
CPU: 0 PID: 8045 Comm: syz-executor.5 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  <IRQ>
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1fb/0x318 lib/dump_stack.c:118
  nmi_cpu_backtrace+0xaf/0x1a0 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x174/0x290 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x10/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
  rcu_dump_cpu_stacks+0x15a/0x220 kernel/rcu/tree_stall.h:254
  print_cpu_stall kernel/rcu/tree_stall.h:455 [inline]
  check_cpu_stall kernel/rcu/tree_stall.h:529 [inline]
  rcu_pending kernel/rcu/tree.c:2827 [inline]
  rcu_sched_clock_irq+0xe25/0x1ad0 kernel/rcu/tree.c:2271
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
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x50 kernel/kcov.c:98
Code: 66 2e 0f 1f 84 00 00 00 00 00 55 48 89 e5 53 48 89 fb e8 13 00 00 00  
48 8b 3d 34 e7 cc 07 48 89 de e8 64 02 3b 00 5b 5d c3 cc <48> 8b 04 24 65  
48 8b 0c 25 c0 1d 02 00 65 8b 15 b8 81 8b 7e f7 c2
RSP: 0018:ffffc90001f87a90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 1ffff11013f36931 RBX: ffffea00029e3f40 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 00000000fffffffc RDI: ffffea00029e3f40
RBP: ffffc90001f87ab8 R08: dffffc0000000000 R09: fffffbfff120248a
R10: fffffbfff120248a R11: 0000000000000000 R12: ffff88809f9b4a20
R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff8880a8747628
  free_thread_stack+0x168/0x590 kernel/fork.c:280
  release_task_stack kernel/fork.c:440 [inline]
  put_task_stack+0xa3/0x130 kernel/fork.c:451
  finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
  context_switch kernel/sched/core.c:3388 [inline]
  __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
  preempt_schedule_irq+0xc1/0x140 kernel/sched/core.c:4338
  retint_kernel+0x1b/0x2b
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752  
[inline]
RIP: 0010:kmem_cache_free+0xc8/0xf0 mm/slab.c:3695
Code: 58 07 00 74 42 4c 89 f7 57 9d 0f 1f 44 00 00 e8 0e 98 ca ff eb 19 e8  
a7 95 ca ff 48 83 3d 07 f7 58 07 00 74 24 4c 89 f7 57 9d <0f> 1f 44 00 00  
4c 89 e7 4c 89 fe e8 58 01 00 00 5b 41 5c 41 5e 41
RSP: 0018:ffffc90001f87d10 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: ffff88809753ced4 RBX: ffff8880aa9eb000 RCX: ffff88809753c640
RDX: 0000000000000000 RSI: ffffffff83474bc4 RDI: 0000000000000286
RBP: ffffc90001f87d30 R08: ffff88809753ce98 R09: ffffc90001f87b14
R10: 000000000000000b R11: 0000000000000000 R12: ffffffff83474bc4
R13: ffff888095bf2cc0 R14: 0000000000000286 R15: ffff8880a304d1f8
  security_file_free+0xc4/0xe0 security/security.c:1403
  file_free fs/file_table.c:55 [inline]
  __fput+0x506/0x740 fs/file_table.c:298
  ____fput+0x15/0x20 fs/file_table.c:313
  task_work_run+0x17e/0x1b0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop arch/x86/entry/common.c:164 [inline]
  prepare_exit_to_usermode+0x483/0x5b0 arch/x86/entry/common.c:195
  syscall_return_slowpath+0x113/0x4a0 arch/x86/entry/common.c:278
  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45e433
Code: 48 89 ee 48 89 e7 e8 2c 1f fa ff 31 c0 48 89 e2 be 33 89 00 00 89 df  
e8 bb c0 ff ff 85 c0 78 17 48 63 fb b8 03 00 00 00 0f 05 <8b> 44 24 10 48  
83 c4 38 5b 5d c3 66 90 48 c7 c2 d4 ff ff ff 48 63
RSP: 002b:00007ffe95171aa0 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 000000000045e433
RDX: 00007ffe95171aa0 RSI: 0000000000008933 RDI: 0000000000000004
RBP: 00000000004bfb19 R08: 000000000000000a R09: 000000000000000a
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000006 R14: 0000000000000000 R15: 00007ffe95171d30


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
