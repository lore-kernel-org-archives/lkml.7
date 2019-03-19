Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD0FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AD6206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ccSrLIR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCSQoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:44:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCSQoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/J0SRFJBzWr0hVCJzs5Pmy9FvrANS6VVjNxwsuuhYFA=; b=ccSrLIR0GhKXZHP2sO7+wRYV3
        y5aF/Fv0PnvEw6wi9n71zY1V8H9xvvsj+ZMkKcsy7TUKMGHbSRPqOPRMKqriKXdryXdjXYQ95JIi6
        5UZkL5xUh/47MEVz4QUHZ/nI3cqlaRY3uv77dok3zGKGM6ENU2aFEiIG6jizxmNLJypkodPs28AY4
        VaPpEDvu3vRex91Au/CuOxCvL6xgxkPc56acR2o8URzkPy3fYOVjsqKQRixqH5XwH9vF4NMHq/KNB
        lKKAp0ykm+nb97I7qj9/0lp+CMNfTYqR4A0Ib0oeRUrukNGuQYQPFOi2u8m6Vf3OO0MTXS3fRWiBB
        szvQ6lHVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6Hqs-0005eT-No; Tue, 19 Mar 2019 16:44:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3C22203C06F3; Tue, 19 Mar 2019 17:44:32 +0100 (CET)
Date:   Tue, 19 Mar 2019 17:44:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Yuyang Du <duyuyang@gmail.com>, will.deacon@arm.com,
        mingo@kernel.org, ming.lei@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/19] locking/lockdep: Update obsolete struct field
 description
Message-ID: <20190319164432.GD6058@hirez.programming.kicks-ass.net>
References: <20190318085733.3143-1-duyuyang@gmail.com>
 <20190318085733.3143-8-duyuyang@gmail.com>
 <1553013349.65329.0.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553013349.65329.0.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:35:49AM -0700, Bart Van Assche wrote:
> On Mon, 2019-03-18 at 16:57 +0800, Yuyang Du wrote:
> >  struct lock_chain {
> > -       /* see BUILD_BUG_ON()s in lookup_chain_cache() */

That's add_chain_cache() now, please do keep the reference.

> > +       /*
> > +        * irq_context: the same as irq_context in held_lock below
> > +        * depth:       the number of held locks in this chain
> > +        * base:        the index in chain_hlocks for this chain
> > +        */
> >         unsigned int                    irq_context :  2,
> >                                         depth       :  6,
> >                                         base        : 24;
> 
> Have you considered to use the kernel-doc style for documenting these
> structure members?
> 
> Thanks,
> 
> Bart.
