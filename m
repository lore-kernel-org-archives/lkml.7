Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E76BC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6964F20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 05:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfFYFzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 01:55:20 -0400
Received: from verein.lst.de ([213.95.11.211]:59642 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727648AbfFYFzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 01:55:19 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0241C68B02; Tue, 25 Jun 2019 07:54:48 +0200 (CEST)
Date:   Tue, 25 Jun 2019 07:54:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: truncate dma masks to what dma_addr_t
 can hold
Message-ID: <20190625055447.GC28854@lst.de>
References: <20190521124729.23559-1-hch@lst.de> <20190521124729.23559-2-hch@lst.de> <20190521130436.bgt53bf7nshz62ip@shell.armlinux.org.uk> <20190521131503.GA5258@lst.de> <20190529122219.GA9982@lst.de> <20190614074648.GA9282@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614074648.GA9282@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 09:46:48AM +0200, Christoph Hellwig wrote:
> If I don't hear anything back in the next days I will just merge
> these patches, please comment.

Applied to the dma-mapping for-next tree now.
