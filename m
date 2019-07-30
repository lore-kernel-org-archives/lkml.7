Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F80C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742D620659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbfG3ORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:17:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38014 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730672AbfG3ORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:17:20 -0400
Received: (qmail 2924 invoked by uid 2102); 30 Jul 2019 10:17:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Jul 2019 10:17:19 -0400
Date:   Tue, 30 Jul 2019 10:17:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     andreyknvl@google.com,
        syzbot <syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com>
cc:     glider@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KMSAN: kernel-usb-infoleak in pcan_usb_pro_send_req
In-Reply-To: <00000000000014c877058ee2c4a6@google.com>
Message-ID: <Pine.LNX.4.44L0.1907301011100.1507-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2019, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    41550654 [UPSTREAM] KVM: x86: degrade WARN to pr_warn_rate..
> git tree:       kmsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e95183a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=40511ad0c5945201
> dashboard link: https://syzkaller.appspot.com/bug?extid=513e4d0985298538bf9b
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eafa1ba00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b87983a00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+513e4d0985298538bf9b@syzkaller.appspotmail.com
> 
> usb 1-1: config 0 has no interface number 0
> usb 1-1: New USB device found, idVendor=0c72, idProduct=0014,  
> bcdDevice=8b.53
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> peak_usb 1-1:0.146: PEAK-System PCAN-USB X6 v0 fw v0.0.0 (2 channels)
> ==================================================================
> BUG: KMSAN: kernel-usb-infoleak in usb_submit_urb+0x7ef/0x1f50  
> drivers/usb/core/urb.c:405

What does "kernel-usb-infoleak" mean?

Alan Stern

