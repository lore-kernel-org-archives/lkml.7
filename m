Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D42CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 05:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21CF21655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 05:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJZFa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 01:30:29 -0400
Received: from verein.lst.de ([213.95.11.211]:54239 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfJZFa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 01:30:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CC4B68B05; Sat, 26 Oct 2019 07:30:26 +0200 (CEST)
Date:   Sat, 26 Oct 2019 07:30:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, will@kernel.org, pratikp@codeaurora.org,
        lmark@codeaurora.org
Subject: Re: [PATCH] iommu/dma: Add support for DMA_ATTR_SYS_CACHE
Message-ID: <20191026053026.GA14545@lst.de>
References: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572050616-6143-1-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition makes very little sense.  Any without a user in the
same series it is a complete no-go anyway.
