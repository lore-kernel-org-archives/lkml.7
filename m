Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1328BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E125F2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfCYIAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:00:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:39089 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfCYIAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:00:06 -0400
Received: by mail-it1-f199.google.com with SMTP id e124so8043677ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6K/hkoOV5Rq1rRjxV3zTpaRUeKYp9Wt4WWKr0Elh8Ls=;
        b=CkFr8Kh8VdjiAvq5qcmHVb2IBLe3TyUwIzNh3lNC/hw/gqB4bOKzbCzwX8sD242zrO
         wpuEGFbIvlZwuXQEi4l67U65CVh2rp8xnqb56tGAQno7u39+LHzGWLcKDsNXTyKvdiZP
         LfnobBBBcaHP7BnucESSUlWGXMK8V+IZbx9StGJcYTjYttQZbWcGJrYwx1cDENfwUFyq
         Q0h6HPYW0dWzTrkZ3RRBRB2x0wYUotyDR88IkL5FdvgPvdLE5QBx7VsNEJZVf3vmcDI2
         A8VR1O4Ji7J1zjEe75wjocXOFtZaFN0cwaFOq3EyfHZ6gjPWSfCVKBD0XuMd45XKMmQ1
         XFyg==
X-Gm-Message-State: APjAAAWkYBJU3Pc6ybP8ouyaBL3EAXMLHf9mlcqHPbLTLoB3gFe/gdz+
        dnj3l0CJY6WmD8GKQXbrAQKA/QP+6FmClzxxpXhuioDfhQ5D
X-Google-Smtp-Source: APXvYqyB8xmFCnOZnuqOzp5OgBLa2WV6EdOycFcMeTIEp0zLMNNg4Ec7Mcqv9iAm7XqbD+60zmvHOclF6+m4vfc6mTa4oVQAKc1F
MIME-Version: 1.0
X-Received: by 2002:a6b:ab05:: with SMTP id u5mr11776935ioe.180.1553500805228;
 Mon, 25 Mar 2019 01:00:05 -0700 (PDT)
Date:   Mon, 25 Mar 2019 01:00:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7944f0584e697e2@google.com>
Subject: WARNING in zap_class
From:   syzbot <syzbot+740dcc3824577fb40563@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    babf09c3 Merge tag 'tag-chrome-platform-fixes-for-v5.1-rc2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1509f28b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=740dcc3824577fb40563
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+740dcc3824577fb40563@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 24046 at kernel/locking/lockdep.c:4548  
remove_class_from_lock_chain kernel/locking/lockdep.c:4528 [inline]
WARNING: CPU: 0 PID: 24046 at kernel/locking/lockdep.c:4548  
remove_class_from_lock_chains kernel/locking/lockdep.c:4568 [inline]
WARNING: CPU: 0 PID: 24046 at kernel/locking/lockdep.c:4548  
zap_class+0x741/0xe20 kernel/locking/lockdep.c:4607
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 24046 Comm: kworker/0:1 Not tainted 5.1.0-rc1+ #30
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events pwq_unbound_release_workfn
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
RIP: 0010:remove_class_from_lock_chain kernel/locking/lockdep.c:4548  
[inline]
RIP: 0010:remove_class_from_lock_chains kernel/locking/lockdep.c:4568  
[inline]
RIP: 0010:zap_class+0x741/0xe20 kernel/locking/lockdep.c:4607
Code: 0f b6 14 38 4c 89 e0 83 e0 07 83 c0 01 38 d0 0f 8c 79 ff ff ff 84 d2  
0f 84 71 ff ff ff 4c 89 e7 e8 04 e8 51 00 e9 64 ff ff ff <0f> 0b e8 78 82  
d6 01 e9 4e fb ff ff 48 89 55 c0 4c 89 4d c8 e8 26
RSP: 0018:ffff88807a9e7c10 EFLAGS: 00010012
RAX: 0000000000010000 RBX: 11a523fb5c4fd01d RCX: ffffffff832ee40e
RDX: 00000000000035a5 RSI: ffffffff832ee45a RDI: 0000000000000006
RBP: ffff88807a9e7c68 R08: ffff88805a856280 R09: ffffffff8a08a408
R10: 0000000000960392 R11: 0000000003920adb R12: ffffffff89c19ec8
R13: 0000000000000000 R14: ffffffff89c19ec0 R15: dffffc0000000000
  __lockdep_free_key_range+0x64/0x120 kernel/locking/lockdep.c:4730
  lockdep_unregister_key+0x201/0x4c0 kernel/locking/lockdep.c:4926
  wq_unregister_lockdep kernel/workqueue.c:3455 [inline]
  pwq_unbound_release_workfn+0x233/0x2f0 kernel/workqueue.c:3675
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
