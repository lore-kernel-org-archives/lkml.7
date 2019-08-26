Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51708C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204BA217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cC/zQtbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfHZHDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:03:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfHZHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vQdGwgOl/ZuixO8xiaxR0SLvVclg7jbER1lHT9uHlSw=; b=cC/zQtbnFSNOJ4AGthbXchZG8
        lbmTP1GvBSs4HWWYLJ0ra2aQ+XGlYoBWdyrn4xGHX+hgyI7yDmqRQLJoqjRmzf9dVF7jNwo6X4G0A
        nrm1tae/bxqa7aVzxlp1OD9zDVJUByem8LRzPXuI+bQHnT7shwEn7xRcvVLsEwYJDJz6/tJZrjwTl
        zrc8B5YKOEbDCb7pPTI24ab+G7tN/RDrTjqIcHr/y7kX6ugih0JMoQMgOFwW27hGTnK7ZCcAM5KU5
        0XkVKrAzwBvqMOUCwNwwBXGmD8E6w+5PE6yPP61/lfJ4/QqWnBflyAVdRIs5SMwobsQMpBdy60kuW
        J4wUJKiXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i291n-0008R1-2i; Mon, 26 Aug 2019 07:02:59 +0000
Date:   Mon, 26 Aug 2019 00:02:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Simek <monstr@monstr.eu>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: convert microblaze to the generic dma remap allocator
Message-ID: <20190826070258.GA31420@infradead.org>
References: <20190814140348.3339-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814140348.3339-1-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 04:03:46PM +0200, Christoph Hellwig wrote:
> Hi Michal,
> 
> can you take a look at this patch that moves microblaze over to the
> generic DMA remap allocator?  I've been trying to slowly get all
> architectures over to the generic code, and microblaze is one that
> seems very straightfoward to convert.

Michal, any chance you could look over this series?
