Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5788C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEF4218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0ajyNV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfDXG1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:27:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8LGS84/xpFnq+gtNsYbwzSZmg6zQw9+84JugkmFuBB8=; b=Q0ajyNV3Fizs2oX9zMVvlpmX2
        x1sWhCIp5WOzB+YdzpG2UjkqVyEWfZO/ni6YG85vDnWi/mcxkX3fSkd0SHRD3IwzS/p6VmRUQoWnb
        CKe83lnekyAgJPG5kpujGja3G8Lm8oz15ggGAbe3/0Tcq0o94HZWtN21tdSPrHS71j0NKDVQ5Ie7m
        Q//8MJWjpW4eLTlI6reUvBe1ouE2YZajY26VJIvfEpEgIjeaOcM8fZ7/ai8qWuMoVKHnB/kGNE+HA
        To2IbQ+bhn1Difxu5CNV82TIZb+/MnMXaEV6Wfuckm8oKCMvLPnm+TOyzarzVKrsG4t4w380bNLXH
        2lAlB73dg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBNY-0004OP-AI; Wed, 24 Apr 2019 06:27:36 +0000
Date:   Tue, 23 Apr 2019 23:27:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v3 1/3] RISC-V: Use tabs to align macro values in
 asm/csr.h
Message-ID: <20190424062736.GA10400@infradead.org>
References: <20190415093648.7525-1-anup.patel@wdc.com>
 <20190415093648.7525-2-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415093648.7525-2-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 09:37:17AM +0000, Anup Patel wrote:
> The spacing between macro name and value is not consistent in
> asm/csr.h. This patch beautifies asm/csr.h by using tabs to align
> macro values instead of spaces.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
