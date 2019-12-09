Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D18C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143FE207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLIRTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:19:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:36873 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:19:10 -0500
Received: by mail-io1-f70.google.com with SMTP id p2so11209523iof.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ZGmLGR8RQMhvLkJMgnWmDVmAcCNn1ByHkQQ3qWq1qls=;
        b=NPVDcL9CASG4+I2RBF0K6ca/p/fXP9rFgY6ao79R19J1HNFjlCKlHz3nG34LGzIj4f
         uQOaO09Vu0yxfawuFjB+n+mlbTJ1L/EnvKlnSTuEq1/fnyiP4hNZBzPJv1/vT9AcAIm8
         hMk/x/enLmJcujaEat/1KDLCtdlgFU/y8dHeL4nwqWm6fhLTcE0BrKmTVXa/UsnbQT6I
         C0LLrQlXRI6KCyJ93CZ1Di2QsyIz6lTVgCQa6LL4HlDcQgk4KJRikvA8y8GqMI8mWoBb
         ZzQZyeosxZ/FkC/1fJ7qcZ73B+yPidLd+GXbHN9qrjTQMVWHFUC9xM6mOiBJzpzMtVnJ
         djTA==
X-Gm-Message-State: APjAAAWaIjcjHMmE98HCVTpqBi8j9wuMY8SCheBt7oXQyM17nPlwZDhU
        8Ht8L/zMkZ5HwdxPfO/3V/zKQnDGkJT7GOn/hKXfLwuAoD7F
X-Google-Smtp-Source: APXvYqzYIPn0SwpO+WwH9NiHtAsHoZQVL0zzOl1xuHT7b8Tqqz2HRbeJiSWQEHh6ew2pK0WoQV+NLQRDuXvQ/IhSwNQCuLDcLdox
MIME-Version: 1.0
X-Received: by 2002:a92:8141:: with SMTP id e62mr28304159ild.119.1575911949346;
 Mon, 09 Dec 2019 09:19:09 -0800 (PST)
Date:   Mon, 09 Dec 2019 09:19:09 -0800
In-Reply-To: <000000000000a968ef059944263f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f02ffa05994897f1@google.com>
Subject: Re: BUG: unable to handle kernel paging request in do_con_trol
From:   syzbot <syzbot+9bce437b96dc287eafef@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, mpatocka@redhat.com,
        nico@fluxnic.net, okash.khawaja@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    e42617b8 Linux 5.5-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1018aaeae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=9bce437b96dc287eafef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d65c2ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111cd4b6e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bce437b96dc287eafef@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 000000010000000e
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9fe71067 P4D 9fe71067 PUD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9069 Comm: syz-executor976 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_K drivers/tty/vt/vt.c:1558 [inline]
RIP: 0010:do_con_trol+0x47ea/0x61b0 drivers/tty/vt/vt.c:2370
Code: 08 2c 01 0f 8e b1 00 00 00 4c 8b bd 08 ff ff ff 48 63 db 44 89 e9 41  
0f b7 84 24 c8 03 00 00 48 01 db d1 e9 49 01 df 4c 89 ff <f3> 66 ab 49 8d  
bc 24 78 04 00 00 b8 ff ff 37 00 48 89 fa 48 c1 e0
RSP: 0018:ffffc90007a8f8b0 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff11012a0fe79 RSI: ffffffff83e103ed RDI: 000000010000000e
RBP: ffffc90007a8f9d0 R08: ffff8880a88b6000 R09: ffff8880a88b6890
R10: fffffbfff14f3330 R11: ffffffff8a799987 R12: ffff88809507f000
R13: 0000000000000002 R14: 0000000000000001 R15: 000000010000000e
FS:  0000000001de2880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 00000000957c3000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_con_write.part.0+0xfd9/0x1ef0 drivers/tty/vt/vt.c:2797
  do_con_write drivers/tty/vt/vt.c:2565 [inline]
  con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe6223d8b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404f9
RDX: 0000000000000078 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 000000010000000e
---[ end trace 21a0d6437741ca8e ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_K drivers/tty/vt/vt.c:1558 [inline]
RIP: 0010:do_con_trol+0x47ea/0x61b0 drivers/tty/vt/vt.c:2370
Code: 08 2c 01 0f 8e b1 00 00 00 4c 8b bd 08 ff ff ff 48 63 db 44 89 e9 41  
0f b7 84 24 c8 03 00 00 48 01 db d1 e9 49 01 df 4c 89 ff <f3> 66 ab 49 8d  
bc 24 78 04 00 00 b8 ff ff 37 00 48 89 fa 48 c1 e0
RSP: 0018:ffffc90007a8f8b0 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff11012a0fe79 RSI: ffffffff83e103ed RDI: 000000010000000e
RBP: ffffc90007a8f9d0 R08: ffff8880a88b6000 R09: ffff8880a88b6890
R10: fffffbfff14f3330 R11: ffffffff8a799987 R12: ffff88809507f000
R13: 0000000000000002 R14: 0000000000000001 R15: 000000010000000e
FS:  0000000001de2880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 00000000957c3000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

