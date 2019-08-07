Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9A7C31E40
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98DD2173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfHGBYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfHGBYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:24:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339C921738;
        Wed,  7 Aug 2019 01:24:17 +0000 (UTC)
Date:   Tue, 6 Aug 2019 21:24:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 02/14] rcu/nocb: Add bypass callback
 queueing
Message-ID: <20190806212415.012a105d@oasis.local.home>
In-Reply-To: <20190807011707.GZ28441@linux.ibm.com>
References: <20190802151435.GA1081@linux.ibm.com>
        <20190802151501.13069-2-paulmck@linux.ibm.com>
        <20190807000313.GA161170@google.com>
        <20190807003501.GX28441@linux.ibm.com>
        <20190806204055.088ba246@gandalf.local.home>
        <20190807011707.GZ28441@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 18:17:07 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> On Tue, Aug 06, 2019 at 08:40:55PM -0400, Steven Rostedt wrote:
> > On Tue, 6 Aug 2019 17:35:01 -0700
> > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> >   
> > > > > +	// Don't use ->nocb_bypass during early boot.    
> > > > 
> > > > Very minor nit: comment style should be /* */    
> > > 
> > > I thought that Linus said that "//" was now OK.  Am I confused?  
> > 
> > Have a link?  
> 
> https://lkml.org/lkml/2016/7/8/625
> 


  The (c) form is particularly good for things like enum or structure
  member comments at the end of code, where you might want to align
  things up, but the ending comment marker ends up being visually pretty
  distracting (and lining _that_ up is too much make-believe work).


I think it's still for special occasions, and the above example doesn't
look like one of them ;-)

I basically avoid the '//' comment, as it just adds inconstancy.

-- Steve
