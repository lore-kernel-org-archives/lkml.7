Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5B92089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfDXOYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:24:44 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36858 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726272AbfDXOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:24:43 -0400
Received: (qmail 2391 invoked by uid 2102); 24 Apr 2019 10:24:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Apr 2019 10:24:42 -0400
Date:   Wed, 24 Apr 2019 10:24:42 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 1/3] tools: memory-model: Prepare for data-race detection
In-Reply-To: <20190424082231.GF3923@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1904241023380.1443-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Paul E. McKenney wrote:

> On Mon, Apr 22, 2019 at 12:17:45PM -0400, Alan Stern wrote:
> > This patch makes some slight alterations to linux-kernel.cat in
> > preparation for adding support for data-race detection to the
> > Linux-Kernel Memory Model.
> > 
> > 	The definitions of relations involved in Acquire, Release, and
> > 	unlock-lock ordering are moved up earlier in the source file.
> > 
> > 	The rmb relation is factored through the new R4rmb class: the
> > 	class of reads to which rmb will apply.
> > 
> > 	The definition of the fence relation is moved earlier, and it
> > 	is split up into read- and write-fences (rmb and wmb) and all
> > 	the others.
> > 
> > This should not make any functional changes.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Thank you, Alan, I have queued all three onto -rcu for review and testing.
> FYI, I rebased my smp_mb__{before,after}_atomic() patch on top of yours
> to avoid the conflict.
> 
> Which demonstrates non-commutativity of patches.  Your patches conflict
> with mine, but mine does not conflict with yours.  ;-)

:-)

Besides, who knows where we'll end up with the 
smp_mb__{before,after}_atomic stuff once Peter is done with it, anyway?

Alan

