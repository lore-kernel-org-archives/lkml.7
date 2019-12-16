Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39C0C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4329206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 15:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfLPPFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:05:14 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:42886 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728158AbfLPPFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:05:13 -0500
Received: (qmail 2142 invoked by uid 2102); 16 Dec 2019 10:05:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Dec 2019 10:05:11 -0500
Date:   Mon, 16 Dec 2019 10:05:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <mans@mansr.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: Re: general protection fault in usb_set_interface
In-Reply-To: <CAAeHK+yz3dtfx0Jfd4sbOcN8tSxp8+qAvW609sP_yJC5q6vq8A@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1912161002080.1406-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Andrey Konovalov wrote:

> On Fri, Dec 13, 2019 at 8:51 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 13 Dec 2019, Andrey Konovalov wrote:
> >
> > > > > Let's retry here:
> > > >
> > > > > #syz test: https://github.com/google/kasan.git f0df5c1b
> > > >
> > > > This bug is already marked as fixed. No point in testing.
> > > >
> > >
> > > Hm, that explains some of the weirdness. It doesn't explain though
> > > neither why the patch was actually tested when Alan requested it nor
> > > why syzbot sent no reply.
> >
> > In the meantime, is there any way to get syzbot to test the new patch
> > with the old reproducer?  Perhaps tell it to re-open this bug?
> 
> No, we can only test this manually now. I can run the reproducer for
> you. Should I revert the fix for this bug and then apply your patch?
> What's the expected result?

Please simply run the patch as it is, with no other changes.  The 
expected result is a use-after-free Read in usbvision_v4l2_open, just 
as with c7b0ec009a216143df30.

Alan Stern

