Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9468BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B0B20874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T2woLxIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDOGbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:31:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfDOGbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vnx/FDuyfGzMLVKxKI7cCwcEPLdbD7UnzGISx2MXjRo=; b=T2woLxINdDPMGVm6g5xO298us
        N/78FYtB7ExqP6ovwznjwj+S1NyADW0QOuLCg38CE62Jy06Rqy0MliwcinJOKGD0hfej37r7WH4P7
        oGm6nabX41XlPUuGs/8auqdw5VfcrGy6iTHXbg/juq7L4tB77sxeCokMSKR5UMGBA+pt2KYUQBOzC
        UOz4pvEY8LemZS2i1eFEHpTC755HIwnFJWSiHfsFXN53z2RINi49eDdhwj1YSJzpp4jXmw9vpk9jg
        yv+xzLTSRudN/FVGLEM7ucSalk0sck+8PjHRpbTKrybAUwUi/URsImgHymNaFh9rsmvfqK6ZqJL+z
        Gy2ulR78A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFv9S-0002HX-W3; Mon, 15 Apr 2019 06:31:34 +0000
Date:   Sun, 14 Apr 2019 23:31:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, Heiko Stuebner <heiko@sntech.de>,
        Will Deacon <will.deacon@arm.com>,
        David Brown <david.brown@linaro.org>,
        linux-samsung-soc@vger.kernel.org, dima@arista.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        murphyt7@tcd.ie, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/9] iommu/dma-iommu: Add iommu_dma_copy_reserved_iova,
 iommu_dma_apply_resv_region to the dma-iommu api
Message-ID: <20190415063134.GB1377@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-4-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-4-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 07:47:32PM +0100, Tom Murphy via iommu wrote:
> +
> +	WARN_ON_ONCE(iommu_dma_reserve_iova(domain, region->start, end) == NULL);

Overly long line..
