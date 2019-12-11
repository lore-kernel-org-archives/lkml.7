Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031ABC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB507214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576106045;
	bh=PoS6kSqB/M2dApmIVOjOXlLV4xc1w1stRcIOqtuCDag=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=V0HQypvheGuGW9qMwjs9q2s/1X+Or0SA+MiH4n+sGu/K08U1KGw+QhF6Tk6AyHVVc
	 aR1U4qb102V/x4X5JF0NmvRf+uI4YUV1hj7sZRkaphJQ19Jlo60OJWK5bYsxtntNE0
	 VOLT96vLFTHpyxQa4rWnLSdcIE6W9CmLA1irFgM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfLKXOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:14:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfLKXOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:14:04 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A20B206A5;
        Wed, 11 Dec 2019 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576106043;
        bh=PoS6kSqB/M2dApmIVOjOXlLV4xc1w1stRcIOqtuCDag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xoi6KDPlPofaaBlpL+pAuzyzEB9rix/DIwywfDzrLeBAy26xQcUMAZ8vXpmTYxlT4
         a2CEX7INeR0iOU24F3S+VQsmUBrIQ1RUh4FMdxGvzT9f2WWlXmTbw/x/Rlr312a9PH
         41xjeFY2ZRFfKLzO0Ynh7k090b7AlOXcSaDw+E6M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3521535203C6; Wed, 11 Dec 2019 15:14:03 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:14:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 10/12] .mailmap: Add entries for old
 paulmck@kernel.org addresses
Message-ID: <20191211231403.GL2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191210040714.GA2715@paulmck-ThinkPad-P72>
 <20191210040741.2943-10-paulmck@kernel.org>
 <f2300140-e253-c646-8f7b-f90b59c8aeb7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2300140-e253-c646-8f7b-f90b59c8aeb7@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:03:44AM -0800, Florian Fainelli wrote:
> 
> 
> On 12/9/2019 8:07 PM, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  .mailmap | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/.mailmap b/.mailmap
> > index c24773d..5f330c5 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -207,6 +207,11 @@ Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >  Patrick Mochel <mochel@digitalimplant.org>
> >  Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
> >  Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
> > +Paul Burton <paul.burton@mips.com> <paul.burton@imgtec.com>
> 
> This duplicates an existing entry.

Good catch, thank you!  How about the following?

							Thanx, Paul

------------------------------------------------------------------------

commit 4b9423cbab36dda3d0e4501dc27d57dae35bda3d
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon Nov 25 15:35:26 2019 -0800

    .mailmap: Add entries for old paulmck@kernel.org addresses
    
    [ paulmck: Apply Florian Fainelli feedback. ]
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/.mailmap b/.mailmap
index c24773d..39efbe9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -207,6 +207,10 @@ Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
+Paul E. McKenney <paulmck@kernel.org> <paul.mckenney@linaro.org>
+Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter@oruba.de>
 Peter Oruba <peter.oruba@amd.com>
