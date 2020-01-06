Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACE9C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29F42075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7os0eUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAFOzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:55:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42266 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iXR1XDagFQiXJLOu1UrAqsItxVsgUYXqdLy3emdrRp0=; b=l7os0eUSNfpN2D4/10G5T96Um
        FyiuKumTHNrq2d99++fDu3Y8IVI7F0Xr5Xwi1nABR7KZzGcwMVv3qfQ+9r+iU88n3SgXiGPg5G08w
        8h1pb2hdVlWSrjeqOM/RnXnUwLM16LNBabtAxRYYMaUnBvnXCf0WKIilul96asZ9ilmsgwSNWaTQw
        eBpAvM1yrSPT0V1bFZB2DCFAfFrfYZTYpVsyb64kVPGvADajpDtV90nxdyOzHnr3cFG/3oig+RhgN
        HqjD0eGGJF1q+i18iAcb13nNzy9kIFvaLLLMJSFQCB86XI5WQXIiiMdLZrqi250jv5euDs5VJfal8
        baspdGs8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioTmb-000302-5T; Mon, 06 Jan 2020 14:55:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 819143012DC;
        Mon,  6 Jan 2020 15:53:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BD9D2B27B123; Mon,  6 Jan 2020 15:55:03 +0100 (CET)
Date:   Mon, 6 Jan 2020 15:55:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/cputime: move rq parameter in
 irqtime_account_process_tick
Message-ID: <20200106145503.GQ2810@hirez.programming.kicks-ass.net>
References: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577959674-255537-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, I think this looks like.

Frederic, if you have time, a second set of eyes would be appreciated.
