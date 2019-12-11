Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91774C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645712073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfLKPPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:15:43 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55100 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731693AbfLKPO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:58 -0500
Received: (qmail 1776 invoked by uid 2102); 11 Dec 2019 10:14:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Dec 2019 10:14:57 -0500
Date:   Wed, 11 Dec 2019 10:14:57 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Re: KASAN: use-after-free Read in usbvision_v4l2_open
In-Reply-To: <CAAeHK+wFBYX8-L-D8w_nep3W=QjYoLAZbc=-0eoWK684wnuayA@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1912111010490.1549-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2019, Andrey Konovalov wrote:

> On Tue, Dec 10, 2019 at 9:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Tue, 10 Dec 2019, syzbot wrote:
> >
> > > > On Mon, 9 Dec 2019, syzbot wrote:
> > >
> > > >> Hello,
> > >
> > > >> syzbot found the following crash on:
> > >
> > > >> HEAD commit:    1f22d15c usb: gadget: add raw-gadget interface
> > > >> git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > >> console output: https://syzkaller.appspot.com/x/log.txt?x=1296f42ae00000
> > > >> kernel config:
> > > >> https://syzkaller.appspot.com/x/.config?x=8ccee2968018adcb
> > > >> dashboard link:
> > > >> https://syzkaller.appspot.com/bug?extid=c7b0ec009a216143df30
> > > >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > >> Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > >> IMPORTANT: if you fix the bug, please add the following tag to the
> > > >> commit:
> > > >> Reported-by: syzbot+c7b0ec009a216143df30@syzkaller.appspotmail.com

> > > This crash does not have a reproducer. I cannot test it.
> >
> > Let's try the same patch with a different bug report -- one that has a
> > reproducer.  I assume that syzbot gets the bug identity from the
> > email's From: line (which has been updated acoordingly) rather than the
> > Subject: line.
> 
> Did you get a response for this test? I see the test attempt on the
> dashboard (the patch failed to build), but I didn't get an email with
> the result.

No response so far.  On the other hand, syzbot has been a bit slow to 
respond to my tests recently (typical turnaround time is several 
hours).  I don't know what's going on.

Alan Stern

