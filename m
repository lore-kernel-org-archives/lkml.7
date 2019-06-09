Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8391C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DE4208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIYvSatr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfFIHzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 03:55:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfFIHzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 03:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NId33FVrnX6RKCmv9wXhMZxhV5RvbqvL9ybuo1GNDqA=; b=UIYvSatrLxTeJ1V2KMwKFXvvH
        C2y6CtDdT7KQ7qeI/fGT8EH0QBuoEOVr/Vd5UhBUveptZB+sPn0ZUV7VNM95DwZM6tpnn52+xp86E
        To/r3jcvd13NBUMsrRi37OFS1TVLiOCI+4VbdFwCH2THbR4lM/K+f9pLYgw44qwfcxaEn6JIix4uk
        9qvRoptOZeUBi5OPRfs8Eko/VkvTwP50NQfSTuTi1gJQV2Ea/MD87EqSnyK/OBvas7xRwI5IbBoAq
        y6YoEjsSWtnhDD5B/V0+uXi80Fg0OmFUOyNENC4so2q2fxgjsXbupKdrWCAeZ38UAMc/I1g+y+BEp
        KVhqMWOBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hZsg4-0001S9-Ta; Sun, 09 Jun 2019 07:55:44 +0000
Date:   Sun, 9 Jun 2019 00:55:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Loys Ollivier <lollivier@baylibre.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: defconfig: enable clocks, serial console
Message-ID: <20190609075544.GA32207@infradead.org>
References: <20190605175042.13719-1-khilman@baylibre.com>
 <alpine.DEB.2.21.9999.1906081848410.720@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1906081848410.720@viisi.sifive.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 06:49:09PM -0700, Paul Walmsley wrote:
> On Wed, 5 Jun 2019, Kevin Hilman wrote:
> 
> > Enable PRCI clock driver and serial console by default, so the default
> > upstream defconfig is bootable to a serial console.
> > 
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> 
> Thanks, queued for v5.2-rc with Christoph's Reviewed-by:.

To repeat myself:  where do you apply it to?  And could we please just
have a shared maintainer tree on infradead.org or kernel.org so that
people don't have to chase multiple trees to base their patches on?
