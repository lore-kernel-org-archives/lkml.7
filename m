Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F17C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51782082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CP7IPjEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfEFKzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:55:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53988 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFKzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/mPbcWy2CM11dV7NLk7pBX3rnuKxcTmZslAvgmVIXIo=; b=CP7IPjEvn48eVHeRdrgXtMt89
        eyQryMmOQw3THWOikQy4ekOFBU+k+k4/73fC8XNfuV+MaCOLnQcWHk29y6azj6KRKG9k7Ao/6iT57
        42FSWpgPAwjJRKQ1YLsMwLw2jGMYOjYd4UlVGUehUR2k5j0BBKrGPfYreEatIP9CF43VpcfK/rtzZ
        U2lF9SfV4mtLRvXfCh0J2ZG6oLfmLwPrK4y5fViGpTwaRd/XUxJArOQSZBQzEwC2eDH5AZjpy1zp3
        wI5rRSD9coxCaOisrRluL4RRs+a6X7RtT2uMLAzODqh6orhLXFoEZOa+7ykazqVnXIdw1xK6D1yUH
        lzJfBf3Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNbGt-0005P5-Hn; Mon, 06 May 2019 10:55:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27D0929AA98B7; Mon,  6 May 2019 12:54:57 +0200 (CEST)
Date:   Mon, 6 May 2019 12:54:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove rq->load
Message-ID: <20190506105457.GM2606@hirez.programming.kicks-ass.net>
References: <20190424084556.604-1-dietmar.eggemann@arm.com>
 <c76a9ece-bfc9-c9dc-a0e0-a41698f56f78@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c76a9ece-bfc9-c9dc-a0e0-a41698f56f78@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 12:46:00PM +0200, Dietmar Eggemann wrote:
> Is there anything else I should do for this patch ?

Got it now. Thanks!
