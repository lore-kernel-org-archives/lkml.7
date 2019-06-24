Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20792C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5122083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfFXIxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:53:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37006 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXIxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:53:07 -0400
Received: by mail-io1-f71.google.com with SMTP id j18so21158105ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iP3hTe7vnfn2Gylds0a6rlCAQXQ2A+s7h1i13nkWL9o=;
        b=twlExBzVen1cj/+s0trakjWAc8fungtuf0f2LOPdv81H+m/7327+k3VWd+S9Rv01Ur
         jSRYH6RWXnkgR2sCL2wzoHCf/cq1zd3LUwR+PMrCk9UzyNQ4498k2iqKEZWh5fAkt2Rr
         +eHyNSVBAi22hvYLqnRCykgPD6ttdqwsXV66TKUNwLHiihUpCOZiLidzJ6aV7b0phYE9
         4vdbKDTIXcikk9K6/poXVI6lqtRxYLXtbsWoNoDWyawEJ0/dkwr/R8U9YZrJdTjiV0Oj
         nh5aXDS1fot/nttNuZC2y+HzMNo5Xpp6Qx1HNw6Qc8Rlqx3vaWkndnZ2rrDlY+S811ly
         VP6g==
X-Gm-Message-State: APjAAAXmHTxbtD5MQqyVCmuR0vhfcG1VOszhQsKOwQAt0CA2e0HmVmOE
        Lmdjco3VEYd4wjvYt1iH4hj0wkC91c/4PDNM4Ru0SW3LqH0Z
X-Google-Smtp-Source: APXvYqxqXMeIv47nNBDaztvsAk5OfwMLLeRFun3SGhftxIo68QWU/XVlYqSvKa/bkKGz2VP5TQNyOmOP3NRQ8+nYwE3GW8s41Xrz
MIME-Version: 1.0
X-Received: by 2002:a5d:915a:: with SMTP id y26mr22521898ioq.207.1561366386614;
 Mon, 24 Jun 2019 01:53:06 -0700 (PDT)
Date:   Mon, 24 Jun 2019 01:53:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6a8ba058c0df076@google.com>
Subject: WARNING: ODEBUG bug in netdev_freemem (2)
From:   syzbot <syzbot+c4521ac872a4ccc3afec@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, davem@davemloft.net,
        dmitry.torokhov@gmail.com, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tyhicks@canonical.com, wanghai26@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fd6b99fa Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144de256a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
dashboard link: https://syzkaller.appspot.com/bug?extid=c4521ac872a4ccc3afec
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c4521ac872a4ccc3afec@syzkaller.appspotmail.com

device hsr_slave_0 left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): Releasing backup interface bond_slave_1
bond0 (unregistering): Releasing backup interface bond_slave_0
bond0 (unregistering): Released all slaves
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint:  
delayed_work_timer_fn+0x0/0x90 arch/x86/include/asm/paravirt.h:767
WARNING: CPU: 1 PID: 25149 at lib/debugobjects.c:325  
debug_print_object+0x168/0x250 lib/debugobjects.c:325
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 25149 Comm: kworker/u4:1 Not tainted 5.2.0-rc4+ #31
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:219
  __warn.cold+0x20/0x4d kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:debug_print_object+0x168/0x250 lib/debugobjects.c:325
Code: dd e0 c9 a4 87 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b5 00 00 00 48  
8b 14 dd e0 c9 a4 87 48 c7 c7 80 bf a4 87 e8 16 75 0d fe <0f> 0b 83 05 4b  
46 4b 06 01 48 83 c4 20 5b 41 5c 41 5d 41 5e 5d c3
RSP: 0018:ffff888058c07838 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ac956 RDI: ffffed100b180ef9
RBP: ffff888058c07878 R08: ffff88805692a340 R09: ffffed1015d240f1
R10: ffffed1015d240f0 R11: ffff8880ae920787 R12: 0000000000000001
R13: ffffffff88bad1a0 R14: ffffffff816039d0 R15: ffff88805f992e60
  __debug_check_no_obj_freed lib/debugobjects.c:785 [inline]
  debug_check_no_obj_freed+0x29f/0x464 lib/debugobjects.c:817
  kfree+0xbd/0x220 mm/slab.c:3754
  kvfree+0x61/0x70 mm/util.c:460
  netdev_freemem+0x4c/0x60 net/core/dev.c:9070
  netdev_release+0x86/0xb0 net/core/net-sysfs.c:1635
  device_release+0x7a/0x210 drivers/base/core.c:1064
  kobject_cleanup lib/kobject.c:691 [inline]
  kobject_release lib/kobject.c:720 [inline]
  kref_put include/linux/kref.h:65 [inline]
  kobject_put.cold+0x289/0x2e6 lib/kobject.c:737
  netdev_run_todo+0x53b/0x7c0 net/core/dev.c:8975
  rtnl_unlock+0xe/0x10 net/core/rtnetlink.c:112
  default_device_exit_batch+0x358/0x410 net/core/dev.c:9756
  ops_exit_list.isra.0+0xfc/0x150 net/core/net_namespace.c:157
  cleanup_net+0x3fb/0x960 net/core/net_namespace.c:553
  process_one_work+0x989/0x1790 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

======================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
