Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD2C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794F206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfJNGJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:09:10 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:39783 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfJNGJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:09:09 -0400
Received: by mail-io1-f70.google.com with SMTP id f9so25012602ioh.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 23:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=zQBM4sNdfY9lXEhTYJI3wv+fJOdi3XC1aRMZjKKZaxQ=;
        b=plOvKtlkq+ybpoU6CewVAYqTmu+RlciyjEwjZDzMuncXgWltyBQXKGrdZtT0Zh2bvr
         cQK7Xgs+yW121BGZy/wqhqKttduDx4/6JwHlqplWVQ2WHd6afskAzY9gUkV2pUuX5gCn
         19z1wAdssaHz2ff48sTPZuw7pvdIIbi4jkEfvHI6M7RT2He4790rdg49KrBeOL7aj75f
         NH9sxLrKV3gMWmEVqtDfg/rx0r0vZXjQ59ayA+o+mOuSQ2NEhA55KWcnUq1JJa6BtbOm
         3/rmv5oQQ7hObKCzNeH3tricJqlsIbTn6jtYlzu6jnt48W4Nvgs+BGKqAHDi2FTyuIxn
         BwNQ==
X-Gm-Message-State: APjAAAWDNHjulBfhc8Ioh/rSjSLU8qymPOX9x0PB5pL28iYTUaBhHlCg
        8Cbv1RNZ+ubI3qsityTl+rZsKTzlRs/fiuKh1FLFFyRRs22G
X-Google-Smtp-Source: APXvYqzQuk+mVzhjXHf9pdN8U7BiJdE7QK4fif11iLX2O42GRxlbZEh98BVmU0BsiMl/sKmzWp5A7VXyglZcmjJIJYpDjq2d24HD
MIME-Version: 1.0
X-Received: by 2002:a02:e48:: with SMTP id 69mr36639829jae.17.1571033349017;
 Sun, 13 Oct 2019 23:09:09 -0700 (PDT)
Date:   Sun, 13 Oct 2019 23:09:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2de3a0594d8b4ca@google.com>
Subject: WARNING in drm_mode_createblob_ioctl
From:   syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ada228a Add linux-next specific files for 20191011
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1423a87f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cf4eed5fe42c31a
dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 30449 at include/linux/thread_info.h:150  
check_copy_size include/linux/thread_info.h:150 [inline]
WARNING: CPU: 1 PID: 30449 at include/linux/thread_info.h:150  
copy_from_user include/linux/uaccess.h:143 [inline]
WARNING: CPU: 1 PID: 30449 at include/linux/thread_info.h:150  
drm_mode_createblob_ioctl+0x398/0x490 drivers/gpu/drm/drm_property.c:800
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 30449 Comm: syz-executor.5 Not tainted 5.4.0-rc2-next-20191011  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
RIP: 0010:check_copy_size include/linux/thread_info.h:150 [inline]
RIP: 0010:copy_from_user include/linux/uaccess.h:143 [inline]
RIP: 0010:drm_mode_createblob_ioctl+0x398/0x490  
drivers/gpu/drm/drm_property.c:800
Code: c1 ea 03 80 3c 02 00 0f 85 ed 00 00 00 49 89 5d 00 e8 3c 28 cb fd 4c  
89 f7 e8 64 92 9e 03 31 c0 e9 75 fd ff ff e8 28 28 cb fd <0f> 0b e8 21 28  
cb fd 4d 85 e4 b8 f2 ff ff ff 0f 84 5b fd ff ff 89
RSP: 0018:ffff8880584efaa8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff8880a3a90000 RCX: ffffc900109da000
RDX: 0000000000040000 RSI: ffffffff83a7eaf8 RDI: 0000000000000007
RBP: ffff8880584efae8 R08: ffff888096c40080 R09: ffffed1014752110
R10: ffffed101475210f R11: ffff8880a3a9087f R12: ffffc90014907000
R13: ffff888028aa0000 R14: 000000009a6c7969 R15: ffffc90014907058


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
