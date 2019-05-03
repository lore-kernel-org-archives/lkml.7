Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BB8206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfECQTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:19:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58686 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726633AbfECQTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:19:22 -0400
Received: (qmail 5873 invoked by uid 2102); 3 May 2019 12:19:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2019 12:19:21 -0400
Date:   Fri, 3 May 2019 12:19:21 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>
Subject: Re: f68f031d ("Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()")
In-Reply-To: <20190503151915.GD2606@hirez.programming.kicks-ass.net>
Message-ID: <Pine.LNX.4.44L0.1905031216310.1437-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2019, Peter Zijlstra wrote:

> On Fri, May 03, 2019 at 07:53:26AM -0700, Paul E. McKenney wrote:
> > Hello, Alan,
> > 
> > Just following up on the -rcu commit below.  I believe that it needs
> > some adjustment given Peter Zijlstra's addition of "memory" to the x86
> > non-value-returning atomics, but thought I should double-check.
> 
> Right; I should get back to that thread...

The real question, still outstanding, is whether smp_mb__before_atomic 
orders anything following the RMW instruction (and similarly, whether 
smp_mb__after_atomic orders anything preceding the RMW instruction).

The other changes in that patch (i.e., the second and third hunks) are 
okay in any case, because they just flesh out an explanation that is 
already present in the text.

Alan

