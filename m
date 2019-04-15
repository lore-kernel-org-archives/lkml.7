Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FF7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D519620833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qt7GBO1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfDOGW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:22:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59908 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfDOGW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5mXYtPV9rkVyUnx+7uwSXff5EgnepnAvSePgRxpYrFI=; b=Qt7GBO1KTQPQLfq/x1srhCdSw
        mC1qHEmpPukjA3amd7lbWLRFdzTZ2yKnZIJaGQZbL2kz7VJwgSbazj/A/tXO7cyrG4M8ki5+XYr82
        QjDWlSMgVDe5Rc9sTVPTrVspDO5js0YreT607UAV+LaLSA/riMLIiPdMuhDH3UUYtkiw1FX/B1bUW
        8OMAIk585YmLYcMpPIrFmhLWAvHQcR2R6cQYD7pO8Rz3dVYP+R6FCmIzSlEtGTWuXGprwQIOwliiP
        O0VjNBDfNL8SPWER2AdBiseXP+GtVSISdbGw9G8DqnyzeWjOW5Td8pubQLnoexf7ItYr2AIhP6XcR
        xUf7egtQQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFv13-0006oW-KB; Mon, 15 Apr 2019 06:22:53 +0000
Date:   Sun, 14 Apr 2019 23:22:53 -0700
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
Subject: Re: [PATCH 8/9] iommu/amd: Clean up unused functions
Message-ID: <20190415062253.GB18154@infradead.org>
References: <20190411184741.27540-1-tmurphy@arista.com>
 <20190411184741.27540-9-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411184741.27540-9-tmurphy@arista.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 07:47:37PM +0100, Tom Murphy via iommu wrote:
> Now that we are using the dma-iommu api we have a lot of unused code.
> This patch removes all that unused code.

This should be merged into the previous patch.
