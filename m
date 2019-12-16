Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D68C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EF3206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HzpZ6ffL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfLPN3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:29:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLPN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pSo8gKUDJ8EQ66IthhO8o3XQi8B6OckyUZa6/WGFxNY=; b=HzpZ6ffLkOXislxsKAW5vGZlM
        e5m6oe3AD+4bpDb2pdrNPNSHV27izGX+fwQFErS8VHBKNhOoB2HMEolW7CHTjHbuZ2T0t8l61A6Dj
        A56hGT60eg6mCq2nKADufCAdyxvn1pPyIKwYDJkSqhpczjez1y0u2WkgW/wOZvKn2qFqT5NxQjaiQ
        8ufJOMS6TX2eBpYeW1NM20BTKckqqBZfZ+4bxMd35bUV7hXvb29UVGq75LoSsMhytyqWZ4t+5vPOf
        X5thoxYLw/QDpIoB7dHx62mI1MrmHkEKNZjzs+mGvYs0H9kGFpbjUZOEiwpqQlFuhaiPVLT7//f4V
        enYaIAJag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igqQr-0001ew-IC; Mon, 16 Dec 2019 13:29:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B968B301747;
        Mon, 16 Dec 2019 14:27:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA1272B2A00EC; Mon, 16 Dec 2019 14:29:03 +0100 (CET)
Date:   Mon, 16 Dec 2019 14:29:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     tglx@linutronix.de, heiko.carstens@de.ibm.com, bhelgaas@google.com,
        schwidefsky@de.ibm.com, mark.rutland@arm.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop_machine: remove try_stop_cpus helper
Message-ID: <20191216132903.GP2844@hirez.programming.kicks-ass.net>
References: <20191214195107.26480-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214195107.26480-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 07:51:07PM +0000, Yangtao Li wrote:
> try_stop_cpus is not used after this:
> 
> commit c190c3b16c0f ("rcu: Switch synchronize_sched_expedited() to
> stop_one_cpu()")
> 
> So remove it.

Thanks!
