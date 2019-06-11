Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A9C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71F62089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 06:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404218AbfFKG7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 02:59:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34685 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403874AbfFKG7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 02:59:52 -0400
Received: from localhost (unknown [37.205.120.66])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5B691240003;
        Tue, 11 Jun 2019 06:59:44 +0000 (UTC)
Date:   Tue, 11 Jun 2019 08:59:40 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Jiwei Sun <jiwei.sun@windriver.com>, linux-rtc@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+08116743f8ad6f9a6de7@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [rtc] Re: BUG: workqueue lockup (4)
Message-ID: <20190611065940.GI25472@piout.net>
References: <0000000000005764090577a27486@google.com>
 <CACT4Y+ZAoLro6LHhaA2EuWF1nAWAA=NAVtpMammhspL4V2aMgw@mail.gmail.com>
 <20181007193918.GC32272@piout.net>
 <20190610234959.GB220379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610234959.GB220379@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2019 16:49:59-0700, Eric Biggers wrote:
> On Sun, Oct 07, 2018 at 09:39:18PM +0200, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 07/10/2018 14:18:31+0200, Dmitry Vyukov wrote:
> > > On Sun, Oct 7, 2018 at 2:15 PM, syzbot
> > > <syzbot+08116743f8ad6f9a6de7@syzkaller.appspotmail.com> wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    c1d84a1b42ef Merge git://git.kernel.org/pub/scm/linux/kern..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=14c5f491400000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c0af03fe452b65fb
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=08116743f8ad6f9a6de7
> > > > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14514a6e400000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1025ebb9400000
> > > 
> > > The reproducer seems to be all about rtc. So +rtc maintainers.
> > > 
> > 
> > It seems to be that bug:
> > http://patchwork.ozlabs.org/patch/898552/
> > 
> > I'm pretty sure the fix is not correct though and didn't have the time
> > to work on a proper fix.
> > 
> 
> Is there any plan to actually fix this?  Because this bug is still open, syzbot
> isn't able to report "workqueue lockup" bugs elsewhere in the kernel.
> 

This is still on my radar.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
