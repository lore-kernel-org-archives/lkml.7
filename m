Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C8C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678DE21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfD3M6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:58:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbfD3M6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:58:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8045ACC5;
        Tue, 30 Apr 2019 12:58:49 +0000 (UTC)
Message-ID: <1556629116.20085.32.camel@suse.com>
Subject: Re: KASAN: invalid-free in disconnect_rio
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+35f04d136fc975a70da4@syzkaller.appspotmail.com>,
        miquel@df.uba.ar, andreyknvl@google.com,
        syzkaller-bugs@googlegroups.com, gregkh@linuxfoundation.org,
        rio500-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 30 Apr 2019 14:58:36 +0200
In-Reply-To: <0000000000008d15ee058653b53e@google.com>
References: <0000000000008d15ee058653b53e@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2019-04-12 at 04:36 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=174ce2e3200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> dashboard link: https://syzkaller.appspot.com/bug?extid=35f04d136fc975a70da4
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138150f3200000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1290c22d200000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+35f04d136fc975a70da4@syzkaller.appspotmail.com
> 
> usb 6-1: USB disconnect, device number 2
> rio500 3-1:0.110: USB Rio disconnected.
> usb 4-1: USB disconnect, device number 2
> ==================================================================
> usb 1-1: USB disconnect, device number 2
> BUG: KASAN: double-free or invalid-free in slab_free mm/slub.c:3003 [inline]
> BUG: KASAN: double-free or invalid-free in kfree+0xce/0x290 mm/slub.c:3958
> usb 2-1: USB disconnect, device number 2
> 

Try as I might, I don't understand this. I can see a memory leak,
but not a double free.

	Regards
		Oliver

