Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079CFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED5D2083D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCBHHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 02:07:06 -0500
Received: from mail-it1-f199.google.com ([209.85.166.199]:57862 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfCBHHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 02:07:06 -0500
Received: by mail-it1-f199.google.com with SMTP id 190so273986itl.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 23:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/6TMDn9PbaIuBVOxa+WMIs3Et5X5nu4Owo0Kq3pnH+0=;
        b=OHy18psSl4wEFDzHEv45SUWkmuA6cTv7gFMbKphNNcoyZbkHtD/YRo5DbV+sIOtWW8
         6j22rbSkYX6FGPU2hGR9TtYOxh0Cw3DFKIeQ53pSG8IUzh1PYdx9WVGYJp6q00EVPkFJ
         BlH0Ft0siyxMzuH+5V5WlwcZN97FTQU5ZNVQzBMegeAyij9ZRyy76TixV74QrHN/QBkM
         kxC4ca4oebgggkrZkv8BR1pVaMlX8ilPLPtGVjN2jUSDqtaagO8X3h5TdaU0uheR3OYB
         feRjWwsZ4CJw9Qlftho9XCrGvAPRPznDUsk7q581z+ehV0504L+vmlteo/u3pxXKr8r7
         4aXQ==
X-Gm-Message-State: APjAAAWvKL9/0MLFbkE50Fdbo6kt8agPZeJDRGrdqnitQI3hs7RIK6Gc
        MYxG+DhPiYYVOli4c4ICSCOSqRwm5y04ch2QL2+xt1fOTzVL
X-Google-Smtp-Source: APXvYqxQWEmWhnWJkzEewcFzF1Kau8vhKUv5qFBQKD9Q1adH/NhDvCN0XpOKwsAV8lWpqiR/VrSZzON6OK36TQVdj+HLsWfqB6Cc
MIME-Version: 1.0
X-Received: by 2002:a02:4fda:: with SMTP id r87mr4865173jad.23.1551510424691;
 Fri, 01 Mar 2019 23:07:04 -0800 (PST)
Date:   Fri, 01 Mar 2019 23:07:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baab660583172b5c@google.com>
Subject: WARNING in lockdep_register_key
From:   syzbot <syzbot+072814ec793ff1946da1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c63e9e91a254 Add linux-next specific files for 20190301
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=160f18ecc00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5875f9dc6e009b2
dashboard link: https://syzkaller.appspot.com/bug?extid=072814ec793ff1946da1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+072814ec793ff1946da1@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 12512 at kernel/locking/lockdep.c:1024  
lockdep_register_key+0x10d/0x490 kernel/locking/lockdep.c:1024
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 12512 Comm: syz-executor.4 Not tainted 5.0.0-rc8-next-20190301  
#1
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
RIP: 0010:lockdep_register_key+0x10d/0x490 kernel/locking/lockdep.c:1024
Code: 75 23 e9 e5 01 00 00 48 89 da 48 c1 ea 03 42 80 3c 3a 00 0f 85 b1 02  
00 00 48 8b 1b 48 85 db 0f 84 c7 01 00 00 4c 39 e3 75 dd <0f> 0b 48 c7 c0  
f8 55 5e 89 48 ba 00 00 00 00 00 fc ff df 48 89 c1
RSP: 0000:ffff8881d7ce79a0 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88809152d698 RCX: 1ffffffff12bcabf
RDX: 1ffffffff146832f RSI: 0000000000000000 RDI: ffff88809f98ee3c
RBP: ffff8881d7ce79d0 R08: ffffffff8a341978 R09: ffffed103af9cf29
R10: ffffed103af9cf28 R11: 0000000000000003 R12: ffff88809152d698
R13: 0000000000000e5b R14: 0000000000000286 R15: dffffc0000000000
  wq_init_lockdep kernel/workqueue.c:3444 [inline]
  alloc_workqueue+0x427/0xe70 kernel/workqueue.c:4263
  tipc_topsrv_work_start net/tipc/topsrv.c:615 [inline]
  tipc_topsrv_start+0x536/0xb90 net/tipc/topsrv.c:659
  tipc_init_net+0x397/0x550 net/tipc/core.c:78
  ops_init+0xb6/0x410 net/core/net_namespace.c:129
  setup_net+0x2c5/0x730 net/core/net_namespace.c:314
  copy_net_ns+0x1d9/0x340 net/core/net_namespace.c:437
  create_new_namespaces+0x400/0x7b0 kernel/nsproxy.c:107
  unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:206
  ksys_unshare+0x440/0x980 kernel/fork.c:2550
  __do_sys_unshare kernel/fork.c:2618 [inline]
  __se_sys_unshare kernel/fork.c:2616 [inline]
  __x64_sys_unshare+0x31/0x40 kernel/fork.c:2616
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f58bcbbdc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000457e29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f58bcbbe6d4
R13: 00000000004c6c3b R14: 00000000004dc3f8 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
