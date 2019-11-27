Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10778C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B769A206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrHgGXXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfK0RN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:13:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38828 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfK0RN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pEDHHVwu6bn2JJ/YM1Ka+McvYISRwpXtn4e69OMZoRY=; b=FrHgGXXUzlnTbKjWArLd6PYTb
        ptGd/xSCW7mCL42n2ht9QnfSu5p+yMMhQbgamAE+g1fmA/BoB1cD9lWaBQkgtH0Bqtf6GRjG6Gl39
        UiuiXwouB1kkvbpo/tLm8ckMVYF2LkPIREf8Qu2ztxwlQiaGPF29U4Ed7+z/vn7ELN4Pgeh9j6Roh
        Uy3kJNDkasfGlq8LeWEYwZyanCh7RLCk/96vXOjaq4SqbEqJrPIndLN/f9lUZxtioe2OAv7dt8AWk
        25Az9q76OwMcN53IYSJEPANTwqzKuwqjDvRjJ7zlviJAH3BjqFvE2CG+iNKLdH3iGEoNOKTZFfxlr
        yopbuTodg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ia0sU-0005M9-Ce; Wed, 27 Nov 2019 17:13:22 +0000
Date:   Wed, 27 Nov 2019 09:13:22 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: move dma_addressing_limited out of line
Message-ID: <20191127171322.GE20752@bombadil.infradead.org>
References: <20191127144006.25998-1-hch@lst.de>
 <20191127144006.25998-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127144006.25998-2-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 03:40:05PM +0100, Christoph Hellwig wrote:
> +/**
> + * dma_addressing_limited - return if the device is addressing limited
> + * @dev:	device to check
> + *
> + * Return %true if the devices DMA mask is too small to address all memory in

Could I trouble you to use a : after Return?  That turns it into its
own section rather than making it part of the generic description.

