Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72892C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F4C21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aaTHQHO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfEHI4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:56:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46280 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfEHI4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1VG6yPLUVWiU1YTq32BJLlNoa5u1YV2OaDOfbYvCulU=; b=aaTHQHO/aopC6BJPg7oeqEd1P
        ItAMiSPDzwkIOa0YFFYS46Hvar5/oLgLjt23dfgTLHzVfemxt9zI4+0Oz4VfKBmJZsJa2WxFS/Mha
        0++qfU6AXV1BLQ1MMzqzRCZ8i5vGehvepDRmV54khSWy65tEBkfVnMaUwC0KeQSyDUkBn3hCwQzMF
        x/9adKq8cnGa/LHFaY8GE9tvK3vwKN1g9Ju64SSnWYr6eyQKLtHgY8mjytZjsGUVo9agv3XMe0QCU
        QnDzc8/GcOON7oabjV+zjjylivY+543l0DyyKEdLNhoF/TsM0rnM5Qez/sUHEkY5MfZvnYs17X79e
        Y05O58/OQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOIMg-0004au-RX; Wed, 08 May 2019 08:55:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EA062029F886; Wed,  8 May 2019 10:55:48 +0200 (CEST)
Date:   Wed, 8 May 2019 10:55:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, mingo@kernel.org, bvanassche@acm.org,
        ming.lei@redhat.com, frederic@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/23] locking/lockdep: Small improvements
Message-ID: <20190508085548.GA2606@hirez.programming.kicks-ass.net>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:19:16PM +0800, Yuyang Du wrote:
> Hi Peter,
> 
> Let me post these small bits first while waiting for Frederic's patches
> to be merged.
> 

They apply nicely and should show up in tip after the merge window
closes or thereabout.

Thanks!
