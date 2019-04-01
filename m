Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3250EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAD620830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbfDARnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:43:09 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:38832 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387648AbfDARgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:06 -0400
Received: by mail-it1-f200.google.com with SMTP id 79so218706itz.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BD99+p9JTxs+7dg6aeQJ42Oad+28HFaix5kytirea5c=;
        b=LvUqRVZ8vyDyafCwzKnCEb1fiuzxWUhP/x5yySBxP4Fawbhn2oF/I64fKVWb70EMaA
         hirOUgCz3qoTKB5k23gDGdIM8v5IZi3Bxe+iZC2Kq/3N85Ays9LBsFiBei9BMSda9HWQ
         ie7u2EL7YhXJ3g9Rp/HiW5c95WoHepnT9w2XAYOo6gE9yqQ+gcB786VMlJVAPjCZg5cM
         ats60w8bZGQR9wIrx4pkcreL2Bc5QaI5OsmKal9A9RgbfQcyoiu6QW53oqpzmv8Xnwoq
         eDN2OKqpVo5Nhi8dZM+0hTdhI6PQjRAqX/2VJNoOiImmvySR5skbCmF6x5Ob7vtei8A5
         aqzA==
X-Gm-Message-State: APjAAAUsCWgxMAFar1b0SzzmwaN3ANytc0rtPBBMtvQ5NEqj21kFWdNj
        sCVO00kMUrseiBx/zz7ruHllnH2Y0C6v5wP0G9jvRKsF4sTQ
X-Google-Smtp-Source: APXvYqyRMeEB5u45X5WEr4JHFQmuRnaMqCPTKm9E86TvTtQBNHBzzFAwsMRXLimzxavcQ602wgqxtm4vprTSnNeVKGiR0cOt8ARp
MIME-Version: 1.0
X-Received: by 2002:a24:612:: with SMTP id 18mr6984223itv.9.1554140165606;
 Mon, 01 Apr 2019 10:36:05 -0700 (PDT)
Date:   Mon, 01 Apr 2019 10:36:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008096f305857b74d1@google.com>
Subject: WARNING in cma_exit_net
From:   syzbot <syzbot+2e3e485d5697ea610460@syzkaller.appspotmail.com>
To:     danielj@mellanox.com, danitg@mellanox.com, dledford@redhat.com,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        swise@opengridcomputing.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e3ecb83e Add linux-next specific files for 20190401
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13bc36cd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db6c9f2bfeb91a99
dashboard link: https://syzkaller.appspot.com/bug?extid=2e3e485d5697ea610460
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2e3e485d5697ea610460@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 7 at drivers/infiniband/core/cma.c:4674  
cma_exit_net+0x327/0x390 drivers/infiniband/core/cma.c:4674
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.1.0-rc2-next-20190401 #15
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
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
RIP: 0010:cma_exit_net+0x327/0x390 drivers/infiniband/core/cma.c:4674
Code: 00 48 c7 c7 c0 4e ea 87 c6 05 89 86 4a 04 01 e8 ba cc 46 fc e9 c8 fd  
ff ff e8 25 6c 5f fc 0f 0b e9 d7 fe ff ff e8 19 6c 5f fc <0f> 0b e8 12 6c  
5f fc 48 8d 65 e8 5b 41 5c 41 5d 5d c3 e8 02 6c 5f
RSP: 0000:ffff8880aa267bf0 EFLAGS: 00010293
RAX: ffff8880aa2581c0 RBX: ffff8880a538d500 RCX: 1ffff1101544b146
RDX: 0000000000000000 RSI: ffffffff85111537 RDI: ffff8880a538d618
RBP: ffff8880aa267c08 R08: ffff8880aa2581c0 R09: 0000000000000004
R10: ffffed1015d25bcf R11: ffff8880ae92de7b R12: 0000000000000001
R13: ffff8880a90e84c0 R14: ffffffff891e29f8 R15: dffffc0000000000
  ops_exit_list.isra.0+0xb0/0x160 net/core/net_namespace.c:153
  cleanup_net+0x3fb/0x960 net/core/net_namespace.c:552
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2270
  worker_thread+0x98/0xe40 kernel/workqueue.c:2416
  kthread+0x357/0x430 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
