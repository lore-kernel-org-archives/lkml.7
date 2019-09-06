Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25F7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81FB2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404635AbfIFJkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:40:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:40994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIFJkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:40:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 318F7AFC4;
        Fri,  6 Sep 2019 09:39:57 +0000 (UTC)
Date:   Fri, 6 Sep 2019 11:39:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "contact@linuxplumbersconf.org" <contact@linuxplumbersconf.org>,
        TheodoreTs'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190906093954.lgkxk23osd6blgmm@pathway.suse.cz>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905121101.60c78422@oasis.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-09-05 12:11:01, Steven Rostedt wrote:
> 
> [ Added Ted and Linux Plumbers ]
> 
> On Thu, 5 Sep 2019 17:38:21 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Thu, 5 Sep 2019, Peter Zijlstra wrote:
> > > On Thu, Sep 05, 2019 at 03:05:13PM +0200, Petr Mladek wrote:  
> > > > The alternative lockless approach is still more complicated than
> > > > the serialized one. But I think that it is manageable thanks to
> > > > the simplified state tracking. And I might safe use some pain
> > > > in the long term.  
> > > 
> > > I've not looked at it yet, sorry. But per the above argument of needing
> > > the CPU serialization _anyway_, I don't see a compelling reason not to
> > > use it.
> > > 
> > > It is simple, it works. Let's use it.
> > > 
> > > If you really fancy a multi-writer buffer, you can always switch to one
> > > later, if you can convince someone it actually brings benefits and not
> > > just head-aches.  
> > 
> > Can we please grab one of the TBD slots at kernel summit next week, sit
> > down in a room and hash that out?
> >
> 
> We should definitely be able to find a room that will be available next
> week.

Sounds great. I am blocked only during Livepatching miniconference
that is scheduled on Wednesday, Sep 11 at 15:00
(basically the very last slot).

Best Regards,
Petr
