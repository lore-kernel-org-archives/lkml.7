Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0589EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78BE2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OblBddK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDCNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:39:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t/pBK4JunyOFxmjao3xECsULdiz6KQeTnx1hk0u/JcQ=; b=OblBddK90aytod9M4Ibr+UbZS
        rIGZ105LvjLV0lqKePkrKkGlwpp8r7PRQvUs6tJeQDocyLzDBjn9hSO3F95R1G8D1W604IApe8N/7
        dgufaKHRVVL3vvVZaF9fVUzWi/4WoPdeuASm5Tcq3NJJr3tfRppoSpNKjy1hfn/CjEDiRyN62m6HS
        klsMZt3jqrfDAq+xKM1A7zndpVqw93rKLgrmcB7j0RYv3kt8IyiApMpaRd2nGDUDa4UwwuJf0Ampp
        0Ll+GcV8a/Tz3dJpyrHO1zHowsR0/5ZJFQ7GNpaT9GjKgLCyqaz8Ct/dHg2BQY7jFggYQmaHAycCi
        nwKNcboBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBg7A-0001cQ-AE; Wed, 03 Apr 2019 13:39:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FD262038D45C; Wed,  3 Apr 2019 15:39:38 +0200 (CEST)
Date:   Wed, 3 Apr 2019 15:39:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fweisbec@gmail.com
Subject: Re: [PATCH 0/4] timers: Fix and improve tracing and documentation
Message-ID: <20190403133938.GJ4038@hirez.programming.kicks-ass.net>
References: <20190321120921.16463-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321120921.16463-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:09:17PM +0100, Anna-Maria Gleixner wrote:
> Hi,
> 
> the patch series was developed during investigating timer problems and
> timer improvements. It contains a struct documentation fix in tick-sched
> and a fixes as well as an improvement for timer tracing.
> 
> Thanks,
> 
>         Anna-Maria
> 
> 
> Anna-Maria Gleixner (4):
>   tick-sched: Update tick_sched struct documentation
>   timer: Move trace point to get proper index
>   timer: Replace deprecated vsprintf pointer extension %pf by %ps
>   trace/timer: Improve timer tracing
> 
>  include/trace/events/timer.h | 17 +++++++++++------
>  kernel/time/tick-sched.h     | 13 ++++++++++---
>  kernel/time/timer.c          | 30 +++++++++++++++++-------------
>  3 files changed, 38 insertions(+), 22 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
