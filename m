Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50526C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4520882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J6iyJ5oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCOqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:46:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfDCOqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GYAGuk0O3D2BLdcy+4PiyrPExV3e9t7xumPWKaDT0ko=; b=J6iyJ5oQR/ztl7SwiyktghPL9
        cSy9wHJPlKCidbWYW6VxktWTK10RXKcPi9w/objorltCTeHZ9K1kyNQGxh+ST8I1Y8Dhlui8xyKGA
        maezubdQbP7FAfLOuzewgjMFaMthn42UnFJDnhqDRXhTQzvjs23lsUNhB8RNWJC+1XUrcDAH8L/uR
        s1cbkcLi6UGZ2qpiYOEGb3eWHtgvkLB3VLPFOfLEbG0ruITHcv+QCNKX+YiMPmtD5Wz+ZhMADkAE8
        Cdy/9Hzk8eH55U76vc5jX9DWM4rUX1wKwYtFPcpIiPQGf24K1n0bMDhnmApnK9gmqT9jPrDxP8ss1
        F0eGOjHzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBh9P-0003c2-6w; Wed, 03 Apr 2019 14:46:03 +0000
Date:   Wed, 3 Apr 2019 07:46:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: Fix Maximum Physical Memory 2GiB option for
 64bit systems
Message-ID: <20190403144603.GB8397@infradead.org>
References: <20190402091741.11298-1-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402091741.11298-1-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +			if ((reg->base + mem_size) < end)

No need for the braces.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
