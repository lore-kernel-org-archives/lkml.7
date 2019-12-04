Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B301BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7081A206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Kz1g1Crc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbfLDQFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:05:46 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:37739
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728241AbfLDQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1575475542; bh=k+BAi9fjX5OmRGQW5/id7fxc1e7g2zvKwS2UJK3hzrM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Kz1g1CrcGVmdxk7Mnp7IAXXfeTH3AZ+aQMRwbU+9OI/ZzG9wMVCe4okdI2+yS1PkMQ8hS4qgPAEBvfOwblqtyFFrwXJN78mosDHYl5Co9uCHrJ8hcmPYiKnZeynFHfFPdTnz2sNyzjsuRZyZ00aKmMpDze1Na/iQHZyg7b3RzIRqZU/FS73JxfX6lFwtpMeMxfbtySv4g+2/TDTRDXm+XxE55HlzSiVbTF9rUUIZyqurM5fS5sWXg2BfBS8iR/AEsWLDElWTSprWJyCfX2BLTDH/WlGCoWOCUzgzcxzg7HmpwmoHWmJb+/LPWIVfMxzmt/Iior4zM8IChyMn7O6DPw==
X-YMail-OSG: 0ffc_UMVM1nxKFI2WcR..eRp7OIuJKoSeCEOQMC7ZbIOLJ2OY6iKlaRr7P8Om6b
 X8VNxQAwNRZDwDsHcHGAk7OscDdDVE0zjmWY49qlnGnpuAEU5uWsrKlE3WEVbcqvIYbuOVyig4H4
 NwFHy3D1EYfAj05h1kGTXcbLMcr0WBPldA1T2r6qrEBzGhKQz8j4zqoZ282alfGmvg1SquKDD4.T
 .Yk4Dq0F1BUQIpRJPXBMQ1NHMBGqb665moKQwWJ5YFeZJ72SEAomvwy13l.yRJjyAwCp9JZfAFjE
 65kSdLJeqqYp.VqnWWtGx7Y4ayxiJkBnPi7Cz0jmEuWCwTaoAOwTk6CY7ENC2maj4z_AAvihzySw
 q45Yx.EHeWwvDQgqql.ghaFydxz0kP.7WscnPmSzGvP685tA6e3luJIA9qjdxDpD1egIXJkuougK
 lz1IqzUls43fHXIxhyZlU.9XKjYFaDgHcLDRZlnwkzbQRKA5LrtqXBq3PDWcvBAZr_OCQcrw3hzc
 vYu3YLaBZkFIN4rU9dZvnF84ih9_hQsOEg5ci.73Ap3h57kbd2s3Em4FfCQuZSyT.lG9t7n3B_CH
 _w.4cg8rIqjWvvBsEOPV6t5wUoyOv3_.u36dQKYEaoW2N0V43sIjyEtCzApQwS8UGy2ykoyJSNcF
 FTzAkXSThNkk4rx5ZkGCoqKQ3Y8.Sx8yL7N8RVX10ptaQ9L4bpoWRQu.43hQEhJuweWNKDbAXMtQ
 csbu1lXHDpU7FYeVqvZdsK4T2UCTAPRBef7lZZBt6VfGYAahUq5Llno5OgISR6DJmHjoxm5WyakM
 J89VkKdc.cBCqvo5Xe7orXbX4u.8bezHpQMxTNgyJ9lUZzC43y8h5wTqg3FMDGZ1YwmZeoXYI.0O
 XfhLFrVxGqupS5xfke_YTF8X984Gm11nL65JI9yxHRoUzYhtRJSSzDIojU7HshktIo0nFqz9nwrX
 N_getF1ezYkfMiVjluI.WM0koMhskra87jVjXoncfdLQkoIy_UBEgSLhN6SahWlw0.mM1cC5gHr1
 wXQ7K1fgoJiAWY7Kh2e7uZDi95HxR42BXEzw2b6h5BbmoSDVRbJUIt0r_FNo1IIZpHqz8VS0wts2
 oHRiENhE9gJ3M.3DgmsOAtCGLTkCpdm6ezI2uQxWpjVhks3OmMzV0YZKUDFv58W8RLlsooGypYto
 MJgeIX91YDffGBuqUHDVuCIETO85BmZ78yw_GPEOxVKLPYfgvlD52xZRIgDt5anOuE7qLg6EMm0k
 j460WnyWHGcRoMP8xiS3UR6m04ihxU9yUx_jQLJYZuFsL_vuvlaxV4weNapU4R9seRotbToO2GqF
 dbLaJ2FEfjkC.CPMV1UYLNpIdCz1BHjOkkUM638Z0FhRqsAZ9QS9VeIrNguyvctT7GWZa2JPiqeN
 U360zP_ipDvYT2pyGSr8zsuTgcEm2o2qFhIBQ9zZXUKNqPGrwR5HXWGtPtdvFB7_XD2YMz3Bk51H
 EHJmVjzHhkGo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Dec 2019 16:05:42 +0000
Received: by smtp413.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b58725de1f5cbe89f19632758fe0e8d6;
          Wed, 04 Dec 2019 16:05:41 +0000 (UTC)
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>, christian@kellner.me,
        cyphar@cyphar.com, "Reshetova, Elena" <elena.reshetova@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>, ldv@altlinux.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Drewry <wad@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <00000000000036decf0598c8762e@google.com>
 <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com>
Date:   Wed, 4 Dec 2019 08:05:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/2019 5:58 AM, Dmitry Vyukov wrote:
> On Tue, Dec 3, 2019 at 9:38 AM Dmitry Vyukov <dvyukov@google.com> wrote=
:
>> On Tue, Dec 3, 2019 at 9:27 AM syzbot
>> <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com> wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15f11c2ae=
00000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9bbcda576=
154a4b4
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dde8d933e7d1=
53aa0c1bb
>>> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
>>> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the co=
mmit:
>>> Reported-by: syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com
>> Something seriously broken in smack+kasan+vmap stacks, we now have 60
>> rcu stalls all over the place and counting. This is one of the
>> samples. I've duped 2 other samples to this one, you can see them on
>> the dashboard:
>> https://syzkaller.appspot.com/bug?extid=3Dde8d933e7d153aa0c1bb

There haven't been Smack changes recently, so this is
going to have been introduced elsewhere. I'm perfectly
willing to accept that Smack is doing something horribly
wrong WRT rcu, and that it needs repair, but its going to
be tough for me to track down. I hope someone else is looking
into this, as my chances of finding the problem are pretty
slim.

>>
>> I see 2 common this across all stalls:
>> 1. They all happen on the instance that uses smack (which is now
>> effectively dead), see smack instance here:
>> https://syzkaller.appspot.com/upstream
>> 2. They all contain this frame in the stack trace:
>> free_thread_stack+0x168/0x590 kernel/fork.c:280
>> The last commit that touches this file is "fork: support VMAP_STACK
>> with KASAN_VMALLOC".
>> That may be very likely the root cause. +Daniel
> I've stopped smack syzbot instance b/c it produces infinite stream of
> assorted crashes due to this.
> Please ping syzkaller@googlegroups.com when this is fixed, I will
> re-enable the instance.
>
>>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>>>         (detected by 1, t=3D10502 jiffies, g=3D6629, q=3D331)
>>> rcu: All QSes seen, last rcu_preempt kthread activity 10503
>>> (4294953794-4294943291), jiffies_till_next_fqs=3D1, root ->qsmask 0x0=

>>> syz-executor.0  R  running task    24648  8293   8292 0x0000400a
>>> Call Trace:
>>>   <IRQ>
>>>   sched_show_task+0x40f/0x560 kernel/sched/core.c:5954
>>>   print_other_cpu_stall kernel/rcu/tree_stall.h:410 [inline]
>>>   check_cpu_stall kernel/rcu/tree_stall.h:538 [inline]
>>>   rcu_pending kernel/rcu/tree.c:2827 [inline]
>>>   rcu_sched_clock_irq+0x1861/0x1ad0 kernel/rcu/tree.c:2271
>>>   update_process_times+0x12d/0x180 kernel/time/timer.c:1726
>>>   tick_sched_handle kernel/time/tick-sched.c:167 [inline]
>>>   tick_sched_timer+0x263/0x420 kernel/time/tick-sched.c:1310
>>>   __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
>>>   __hrtimer_run_queues+0x403/0x840 kernel/time/hrtimer.c:1576
>>>   hrtimer_interrupt+0x38c/0xda0 kernel/time/hrtimer.c:1638
>>>   local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline=
]
>>>   smp_apic_timer_interrupt+0x109/0x280 arch/x86/kernel/apic/apic.c:11=
35
>>>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>>>   </IRQ>
>>> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
>>> RIP: 0010:check_kcov_mode kernel/kcov.c:70 [inline]
>>> RIP: 0010:__sanitizer_cov_trace_pc+0x1c/0x50 kernel/kcov.c:102
>>> Code: cc 07 48 89 de e8 64 02 3b 00 5b 5d c3 cc 48 8b 04 24 65 48 8b =
0c 25
>>> c0 1d 02 00 65 8b 15 b8 81 8b 7e f7 c2 00 01 1f 00 75 2c <8b> 91 80 1=
3 00
>>> 00 83 fa 02 75 21 48 8b 91 88 13 00 00 48 8b 32 48
>>> RSP: 0018:ffffc900021c7c28 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff1=
3
>>> RAX: ffffffff81487433 RBX: 0000000000000000 RCX: ffff88809428a100
>>> RDX: 0000000000000001 RSI: 00000000fffffffc RDI: ffffea0002479240
>>> RBP: ffffc900021c7c50 R08: dffffc0000000000 R09: fffffbfff1287025
>>> R10: fffffbfff1287025 R11: 0000000000000000 R12: dffffc0000000000
>>> R13: dffffc0000000000 R14: 00000000fffffffc R15: ffff888091c57428
>>>   free_thread_stack+0x168/0x590 kernel/fork.c:280
>>>   release_task_stack kernel/fork.c:440 [inline]
>>>   put_task_stack+0xa3/0x130 kernel/fork.c:451
>>>   finish_task_switch+0x3f1/0x550 kernel/sched/core.c:3256
>>>   context_switch kernel/sched/core.c:3388 [inline]
>>>   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
>>>   preempt_schedule_common kernel/sched/core.c:4236 [inline]
>>>   preempt_schedule+0xdb/0x120 kernel/sched/core.c:4261
>>>   ___preempt_schedule+0x16/0x18 arch/x86/entry/thunk_64.S:50
>>>   __raw_read_unlock include/linux/rwlock_api_smp.h:227 [inline]
>>>   _raw_read_unlock+0x3a/0x40 kernel/locking/spinlock.c:255
>>>   kill_something_info kernel/signal.c:1586 [inline]
>>>   __do_sys_kill kernel/signal.c:3640 [inline]
>>>   __se_sys_kill+0x5e9/0x6c0 kernel/signal.c:3634
>>>   __x64_sys_kill+0x5b/0x70 kernel/signal.c:3634
>>>   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
>>>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>> RIP: 0033:0x422a17
>>> Code: 44 00 00 48 c7 c2 d4 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 =
66 2e
>>> 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 3e 00 00 00 0f 05 <48> 3d 01 f=
0 ff
>>> ff 0f 83 dd 32 ff ff c3 66 2e 0f 1f 84 00 00 00 00
>>> RSP: 002b:00007fff38dca538 EFLAGS: 00000293 ORIG_RAX: 000000000000003=
e
>>> RAX: ffffffffffffffda RBX: 0000000000000064 RCX: 0000000000422a17
>>> RDX: 0000000000000bb8 RSI: 0000000000000009 RDI: 00000000fffffffe
>>> RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000001c62940
>>> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000008
>>> R13: 00007fff38dca570 R14: 000000000000f0b6 R15: 00007fff38dca580
>>> rcu: rcu_preempt kthread starved for 10533 jiffies! g6629 f0x2
>>> RCU_GP_WAIT_FQS(5) ->state=3D0x0 ->cpu=3D0
>>> rcu: RCU grace-period kthread stack dump:
>>> rcu_preempt     R  running task    29032    10      2 0x80004008
>>> Call Trace:
>>>   context_switch kernel/sched/core.c:3388 [inline]
>>>   __schedule+0x9a8/0xcc0 kernel/sched/core.c:4081
>>>   schedule+0x181/0x210 kernel/sched/core.c:4155
>>>   schedule_timeout+0x14f/0x240 kernel/time/timer.c:1895
>>>   rcu_gp_fqs_loop kernel/rcu/tree.c:1661 [inline]
>>>   rcu_gp_kthread+0xed8/0x1770 kernel/rcu/tree.c:1821
>>>   kthread+0x332/0x350 kernel/kthread.c:255
>>>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
>>>
>>>
>>> ---
>>> This bug is generated by a bot. It may contain errors.
>>> See https://goo.gl/tpsmEJ for more information about syzbot.
>>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>>
>>> syzbot will keep track of this bug report. See:
>>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>>
>>> --
>>> You received this message because you are subscribed to the Google Gr=
oups "syzkaller-bugs" group.
>>> To unsubscribe from this group and stop receiving emails from it, sen=
d an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>>> To view this discussion on the web visit https://groups.google.com/d/=
msgid/syzkaller-bugs/00000000000036decf0598c8762e%40google.com.

