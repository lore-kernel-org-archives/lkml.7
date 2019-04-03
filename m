Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547972147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wQLcJqJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDCM7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:59:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCM7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CXUpjnOsQhAvFkO864rCMFr0EwzYU1642X0OrSPs3BY=; b=wQLcJqJ9LMdZ3ynov7x89CqB2
        EY/q4aTDPsY+PxA0SJDLFaeiNzgxipjsezgU3IEiQsEahz03RSnihJkuiinv+M1FztQkwhL7pIvNx
        w1KiB0Jl8JOLI+soXn4JFtj7yl53HyUNVi2ZbTurxCrhgq9ayjYUdVob9abgZxL5hzQDc/bSKzFSa
        zdVB6VhPJng1FPGFPT6Awe04Qono1hBPuzIFmR5lQpaQDHqVEcVseio6fWpiMFJHRLBJBCZxbjNPa
        cVRbxbEQnx3KXHYBczP0SbToVoAap+RNzfaXJMjMQiAo2+vbpJScrmUp8C9I3nbDT69guNAK1QtOt
        S8oCsxYEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBfUG-0002Qp-I5; Wed, 03 Apr 2019 12:59:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F8CC2038C248; Wed,  3 Apr 2019 14:59:27 +0200 (CEST)
Date:   Wed, 3 Apr 2019 14:59:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 00/12] locking/rwsem: Rwsem rearchitecture part 2
Message-ID: <20190403125927.GG4038@hirez.programming.kicks-ass.net>
References: <20190328181106.22887-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328181106.22887-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 02:10:54PM -0400, Waiman Long wrote:
> This is part 2 of a 3-part (0/1/2) series to rearchitect the internal
> operation of rwsem.
> 
> part 0: https://lkml.org/lkml/2019/3/22/1662
> part 1: https://lkml.org/lkml/2019/2/28/1124

Please, don't ever use lkml.org links, they're friggin useless.

The canonical link form is: https://lkml.kernel.org/r/$msgid

The thing is, I have part 0, but I cannot find part 1, and the above
link doesn't include a message id so I can't find it in my inbox either.

If I reverse search in my inbox from this message, I end up on part 0.
Did you send the parts out of order?
