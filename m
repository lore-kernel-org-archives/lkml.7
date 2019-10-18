Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF3CA9EA8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29F221925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634113AbfJRONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:13:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:44072 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438273AbfJRONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:13:08 -0400
Received: by mail-il1-f197.google.com with SMTP id 13so1898408iln.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Z8+EZbNhF4UBXjpXIlZ4mXJoBsSBSlC91YWGVcrweOA=;
        b=b6r2syiOt2mj+AimzTE2fqt2HAna3TpazeEJW2PhZVjtoCDoeG8Wi33hY+kLBDP84P
         fZX0OQ5Ow/DEwmI5z+83kRKiOTpYtFranvC5BME6TskZkbXJRm+ZjBfRwbO7jyxNWwKF
         ZX0aP5AgyfEVCOdOU9muMhbxMDiVx8OEQNEIIfL7VyTX6PwbZj1HXxD4hNn6OYBTjHeQ
         TNopMtM0aAd6GPp41ZQjFwvp35cOTFehFT9iJqK9Uj4hxAxCpvXPbYqgSvCVrA+eRb5Z
         nHWYi6FkpWbgeADNyuzDEnjIF/+Ug5lRgnfJMJ1OByQ+VRaIlwkrN+17LK/PQRjvJnbS
         X1lw==
X-Gm-Message-State: APjAAAUulQ4QmJxEc3lLfd8mPeSgufvskL+ZethGyL2+/6tvF38mvGpA
        peIcMocBx6aCFqhqfIfM9c78u2MZK+iXzqKXdUfRUtjrdj7i
X-Google-Smtp-Source: APXvYqxdh1isQOact1ghAlshRmpIPuuj+f30ogyCHB1ah6qJeXSvGqHSqKAc8UkKdPgcvOgf4HuA8JJZJCofUTx7kDdrZBcCGC/L
MIME-Version: 1.0
X-Received: by 2002:a5d:9ed4:: with SMTP id a20mr8332916ioe.27.1571407988181;
 Fri, 18 Oct 2019 07:13:08 -0700 (PDT)
Date:   Fri, 18 Oct 2019 07:13:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eed19705952fee5a@google.com>
Subject: WARNING in check_corruption
From:   syzbot <syzbot+2e88d23c0143e90d8303@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wang.yi59@zte.com.cn, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ada228a Add linux-next specific files for 20191011
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=144265ab600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cf4eed5fe42c31a
dashboard link: https://syzkaller.appspot.com/bug?extid=2e88d23c0143e90d8303
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1249ad80e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ca6de7600000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=158d26d7600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=178d26d7600000
console output: https://syzkaller.appspot.com/x/log.txt?x=138d26d7600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e88d23c0143e90d8303@syzkaller.appspotmail.com

check: Corrupted low memory at 00000000b9a95c9f (2900 phys) = 000000e8
------------[ cut here ]------------
Memory corruption detected in low memory
WARNING: CPU: 0 PID: 3473 at arch/x86/kernel/check.c:161  
check_for_bios_corruption arch/x86/kernel/check.c:161 [inline]
WARNING: CPU: 0 PID: 3473 at arch/x86/kernel/check.c:161  
check_corruption+0x159/0x1fc arch/x86/kernel/check.c:169
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 3473 Comm: kworker/0:2 Not tainted 5.4.0-rc2-next-20191011 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events check_corruption
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:check_for_bios_corruption arch/x86/kernel/check.c:161 [inline]
RIP: 0010:check_corruption+0x159/0x1fc arch/x86/kernel/check.c:169
Code: 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 80 3d 8b 00 90 08 00 75 a2  
48 c7 c7 e0 6b a8 87 c6 05 7b 00 90 08 01 e8 af 0b 12 00 <0f> 0b eb 8b 48  
89 df 89 55 d0 e8 88 45 7c 00 8b 55 d0 e9 4e ff ff
RSP: 0018:ffff88809c8d7cf8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888000010000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cb3a6 RDI: ffffed101391af91
RBP: ffff88809c8d7d30 R08: ffff88809c8e2080 R09: ffffed1015d06161
R10: ffffed1015d06160 R11: ffff8880ae830b07 R12: ffff888000010000
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff888000000000
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
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
