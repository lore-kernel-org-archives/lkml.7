Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C82C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3208214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 06:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gMhCCGTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF1GLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 02:11:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF1GLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yZmT2yBFz9XaMtbDgptCtQnCRAeMpxb84f3k5jPuy1M=; b=gMhCCGTeDa/dPzOxRso3F8AIF
        3jbXPr7F+/3Mi602ih/8smhqwTBdQ5fjIhoNC5cIzEPtL59FDPlBn0ffypCHmXZcNOaL6cwQB1Yhw
        u5N5CnXV7K2qCPMoEDlCO2kl6131Roypvz9g+nHFvWtX+icLx2cuhj4hJp+BiHji1BoBMTtlxIrLA
        PDmzCrmh8YE1jRjTAoLQ6Jv/Ly6GyWsSgNEfialQ9QkeXIYEglIU09jNyGlHDd92tyai92PoyGH+m
        3fNgnnj1b6Wt2/GLuGiMJuen9s1xZOMn4hGP3x56Ei6hiPxdECldThAIJ9t/oCPFlNT/TojXtQJ/f
        fIg47TZzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgk6G-00043w-BW; Fri, 28 Jun 2019 06:11:08 +0000
Date:   Thu, 27 Jun 2019 23:11:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Paul as a RISC-V maintainer
Message-ID: <20190628061108.GA9834@infradead.org>
References: <20190628002753.5573-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628002753.5573-1-palmer@sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  RISC-V ARCHITECTURE
> +M:	Paul Walmsley <paul.walmsley@sifive.com>
>  M:	Palmer Dabbelt <palmer@sifive.com>
>  M:	Albert Ou <aou@eecs.berkeley.edu>

Is Albert going to come back to actively maintain anything?  I've
not actually seen him active ever since the port went mainline.
