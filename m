Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BE720828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 15:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390500AbfIEPi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 11:38:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43304 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfIEPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 11:38:59 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i5tq7-0003cq-81; Thu, 05 Sep 2019 17:38:27 +0200
Date:   Thu, 5 Sep 2019 17:38:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
In-Reply-To: <20190905143118.GP2349@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de> <20190904123531.GA2369@hirez.programming.kicks-ass.net> <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz> <20190905143118.GP2349@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, Peter Zijlstra wrote:
> On Thu, Sep 05, 2019 at 03:05:13PM +0200, Petr Mladek wrote:
> > The alternative lockless approach is still more complicated than
> > the serialized one. But I think that it is manageable thanks to
> > the simplified state tracking. And I might safe use some pain
> > in the long term.
> 
> I've not looked at it yet, sorry. But per the above argument of needing
> the CPU serialization _anyway_, I don't see a compelling reason not to
> use it.
> 
> It is simple, it works. Let's use it.
> 
> If you really fancy a multi-writer buffer, you can always switch to one
> later, if you can convince someone it actually brings benefits and not
> just head-aches.

Can we please grab one of the TBD slots at kernel summit next week, sit
down in a room and hash that out?

Thanks,

	tglx
