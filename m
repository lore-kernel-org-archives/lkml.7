Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEEDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F73821741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733278AbfK0VSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:18:40 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38816 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1733151AbfK0VLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:11:19 -0500
Received: (qmail 4118 invoked by uid 2102); 27 Nov 2019 16:11:18 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Nov 2019 16:11:18 -0500
Date:   Wed, 27 Nov 2019 16:11:18 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <hverkuil@xs4all.nl>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <mchehab@kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in si470x_int_in_callback (2)
In-Reply-To: <000000000000cf39d205985a35b0@google.com>
Message-ID: <Pine.LNX.4.44L0.1911271610270.1319-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver:

Make of this what you will...

Alan Stern

On Wed, 27 Nov 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger  
> crash:
> 
> Reported-and-tested-by:  
> syzbot+9ca7a12fd736d93e0232@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
> dashboard link: https://syzkaller.appspot.com/bug?extid=9ca7a12fd736d93e0232
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d13f6ae00000
> 
> Note: testing is done by a robot and is best-effort only.

