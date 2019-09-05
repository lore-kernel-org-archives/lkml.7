Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF1BC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A912082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfIEQLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfIEQLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:11:10 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE2820693;
        Thu,  5 Sep 2019 16:11:07 +0000 (UTC)
Date:   Thu, 5 Sep 2019 12:11:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "contact@linuxplumbersconf.org" <contact@linuxplumbersconf.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH v4 0/9] printk: new ringbuffer implementation
Message-ID: <20190905121101.60c78422@oasis.local.home>
In-Reply-To: <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
        <20190904123531.GA2369@hirez.programming.kicks-ass.net>
        <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
        <20190905143118.GP2349@hirez.programming.kicks-ass.net>
        <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Added Ted and Linux Plumbers ]

On Thu, 5 Sep 2019 17:38:21 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 5 Sep 2019, Peter Zijlstra wrote:
> > On Thu, Sep 05, 2019 at 03:05:13PM +0200, Petr Mladek wrote:  
> > > The alternative lockless approach is still more complicated than
> > > the serialized one. But I think that it is manageable thanks to
> > > the simplified state tracking. And I might safe use some pain
> > > in the long term.  
> > 
> > I've not looked at it yet, sorry. But per the above argument of needing
> > the CPU serialization _anyway_, I don't see a compelling reason not to
> > use it.
> > 
> > It is simple, it works. Let's use it.
> > 
> > If you really fancy a multi-writer buffer, you can always switch to one
> > later, if you can convince someone it actually brings benefits and not
> > just head-aches.  
> 
> Can we please grab one of the TBD slots at kernel summit next week, sit
> down in a room and hash that out?
>

We should definitely be able to find a room that will be available next
week.

-- Steve
