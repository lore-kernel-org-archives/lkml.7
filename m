Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F46C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150612073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dT6kxVSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfLKPn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:43:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388750AbfLKPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fbVP3GO5TFya8NWOJb7Dgy0hxavImfzE2eK5UngY8Ac=; b=dT6kxVSFdCksVqKKxmEQrpRgx
        8j7nQlD3Y53CAmIuUQNzRGcF0+mBrf2PB8fh35nl9jDugd4IbKpijkwhp/K6MkSE37DCaYdKC/fkm
        MUosO3b0ux0UJeLtLbtS360YNNEZ9rkAAL3UoAfWtlb9HTj/ytw0ekCeUsuRBQjMX+M93d8Brpuru
        fIgPCAKqK3VlbMWJJcSRxnc2vXrYjqmnLxGDyk/fkk0IBiU09ydf4vGUiGQSP8I8OY9MxhZG07Hye
        m6YUo9o0P5T08fCo0oKOvf30C7DURyP+kxN6eXFY/t/CB+8MQr7ZSErgHkPCxn/DmEsqPS7YwFeBv
        Yb3uXrcAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if49T-0006lP-C2; Wed, 11 Dec 2019 15:43:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82E5F3077F4;
        Wed, 11 Dec 2019 16:42:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E36CA20137C8F; Wed, 11 Dec 2019 16:43:44 +0100 (CET)
Date:   Wed, 11 Dec 2019 16:43:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jingfeng Xie <xiejingfeng@linux.alibaba.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] psi: two division fixes
Message-ID: <20191211154344.GP2827@hirez.programming.kicks-ass.net>
References: <20191203183524.41378-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203183524.41378-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 01:35:22PM -0500, Johannes Weiner wrote:
> Hi Peter,
> 
> here is a patch that should fix the rare div0 crashes reported by
> Jingfeng, and a second patch for a div32-with-64-bit-divisor issue
> spotted during code review.
> 
> Can you please take a look and route them through the scheduler tree?

Will do, Thanks!
