Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB9CC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2A621924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569969037;
	bh=zKHlDq5fFE0oEVVLpY4IIS1fLRtoxjKpDhQkEnj1gaI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=cMxuJnZ9s+O6yD86sPF/dinz4cvT6FI2gKdgOhHAvApaqszuCjAdiJ8s82PO6c7tJ
	 O7NE7Mhklj+Mm1c2CIX9hqfHkZkRURCT0DnQ53y4oHU3hRnZjbK0ya0wV1u93w/6gg
	 6UnY0O5mG2qTnHt9GWhIF16pr0rBa3Js14JKU7o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfJAWag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfJAWag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:30:36 -0400
Received: from paulmck-ThinkPad-P72 (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547D72086A;
        Tue,  1 Oct 2019 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569969035;
        bh=zKHlDq5fFE0oEVVLpY4IIS1fLRtoxjKpDhQkEnj1gaI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lCQ6ZIxn7rK7H0LiVll8pj7KcGXhZc3xZDdsr4my771zOUZEPiypZ5FzcDLw66BLz
         nFE8VcTSC9GyosdXC4CwVu76FH4QLzHgIdqQL9qTPn3+w/qIakDSZEIVXWnZOW6mMZ
         xA7o9YKistHnVlps5XaKHk7uSzJ8rVs8A4t66ysk=
Date:   Tue, 1 Oct 2019 15:30:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tools/memory-model/Documentation: Fix typos in
 explanation.txt
Message-ID: <20191001223034.GY2689@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <Pine.LNX.4.44L0.1910011331320.1991-100000@iolanthe.rowland.org>
 <20191001210123.GA41667@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001210123.GA41667@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:01:23PM -0400, Joel Fernandes wrote:
> On Tue, Oct 01, 2019 at 01:39:47PM -0400, Alan Stern wrote:
> > This patch fixes a few minor typos and improves word usage in a few
> > places in the Linux Kernel Memory Model's explanation.txt file.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

I queued all three for further review, and added Joel's Reviewed-by
to the first one.  Thank you both!

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> > ---
> > 
> >  tools/memory-model/Documentation/explanation.txt |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > Index: usb-devel/tools/memory-model/Documentation/explanation.txt
> > ===================================================================
> > --- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
> > +++ usb-devel/tools/memory-model/Documentation/explanation.txt
> > @@ -206,7 +206,7 @@ goes like this:
> >  	P0 stores 1 to buf before storing 1 to flag, since it executes
> >  	its instructions in order.
> >  
> > -	Since an instruction (in this case, P1's store to flag) cannot
> > +	Since an instruction (in this case, P0's store to flag) cannot
> >  	execute before itself, the specified outcome is impossible.
> >  
> >  However, real computer hardware almost never follows the Sequential
> > @@ -419,7 +419,7 @@ example:
> >  
> >  The object code might call f(5) either before or after g(6); the
> >  memory model cannot assume there is a fixed program order relation
> > -between them.  (In fact, if the functions are inlined then the
> > +between them.  (In fact, if the function calls are inlined then the
> >  compiler might even interleave their object code.)
> >  
> >  
> > @@ -499,7 +499,7 @@ different CPUs (external reads-from, or
> >  
> >  For our purposes, a memory location's initial value is treated as
> >  though it had been written there by an imaginary initial store that
> > -executes on a separate CPU before the program runs.
> > +executes on a separate CPU before the main program runs.
> >  
> >  Usage of the rf relation implicitly assumes that loads will always
> >  read from a single store.  It doesn't apply properly in the presence
> > @@ -955,7 +955,7 @@ atomic update.  This is what the LKMM's
> >  THE PRESERVED PROGRAM ORDER RELATION: ppo
> >  -----------------------------------------
> >  
> > -There are many situations where a CPU is obligated to execute two
> > +There are many situations where a CPU is obliged to execute two
> >  instructions in program order.  We amalgamate them into the ppo (for
> >  "preserved program order") relation, which links the po-earlier
> >  instruction to the po-later instruction and is thus a sub-relation of
> > @@ -1572,7 +1572,7 @@ and there are events X, Y and a read-sid
> >  
> >  	2. X comes "before" Y in some sense (including rfe, co and fr);
> >  
> > -	2. Y is po-before Z;
> > +	3. Y is po-before Z;
> >  
> >  	4. Z is the rcu_read_unlock() event marking the end of C;
> >  
> > 
> > 
