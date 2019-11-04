Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D75BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C4420578
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nc4PXKrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfKDKOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:14:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKDKOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oYDYFt7WU+WK8oxsBt4wPV4jCr5cxKZTv5wdz8JtgMM=; b=nc4PXKrPSA2reqtql+wiXJ78d
        I7Z6Wsj9KbmAuulTDcz3vODeFabELnEz6NKrTvVbbYRst08M1PKwAUYBYZq09E7yezza94uxxdiWV
        uSeG/rslo6ikLKpZOuh2rOgjWnPgSw3W3/Y9RXYFeMXrl9gxRkSzs6L43HplMFEaXeX1Q5hkBhbxc
        4YUX9VwvCtRNmG1p+x/jKC7nMsU89AOQPJGEozUsW6uYHGnGCEOYCiSGUdCRuQhvQoKSbodPO2PIx
        Vuc0HK3LESnPFv+a5EiV6FHOB6NRGMnp82jRwbf2LAJOvbjDCeQLm7HlbbYZYNk0AShNrZdGYJTkd
        lP7cQ1gtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRZNV-0005Di-Bx; Mon, 04 Nov 2019 10:14:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CCBD30458E;
        Mon,  4 Nov 2019 11:13:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 898AD20098ABE; Mon,  4 Nov 2019 11:14:26 +0100 (CET)
Date:   Mon, 4 Nov 2019 11:14:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: update the comment for __lock_release()
Message-ID: <20191104101426.GD4131@hirez.programming.kicks-ass.net>
References: <20191104091252.GA31509@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104091252.GA31509@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 12:12:52PM +0300, Dan Carpenter wrote:
> This changes "to the list" to "from the list" and also deletes the
> obsolete comment about the "@nested" argument.  The "nested" argument
> was removed in commit 5facae4f3549 ("locking/lockdep: Remove unused
> @nested argument from lock_release()").
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan!
