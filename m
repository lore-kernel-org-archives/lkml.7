Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAB1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3F7233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566401162;
	bh=NFr0/nY3IfPKUVlKWEhZAqr+dzWcs/Y2p7eY45qm4Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ho9l7GvW/o9GQQ074TJb2s3pe2Rwkrg7DHgUYZehLMYioOK4AbFyBYw7l+37XV3uI
	 VY3ycQWDFiHDFS/BJIgObHec0NKkg3emlfhDy/CbVRmYONOGb/44nWUkSnsjyZjA4Y
	 UGnzp2tcH16iGPdNF1My/zBkwalWc/zrlXDm6+jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbfHUP0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:26:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfHUP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:26:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED6D206BA;
        Wed, 21 Aug 2019 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566401160;
        bh=NFr0/nY3IfPKUVlKWEhZAqr+dzWcs/Y2p7eY45qm4Bs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vx3lNhdbRokT/r8unMb1miHNxu9JN9NYu+yPM5e+d2LRwW3AGqFtGETXG7VnK1Rno
         rwhPd99dPfgCZlkLeur4F2jSZAS09a9CQm0zjp5fGWWUdpUfDIblVXpp6dtG0i2LnH
         PFbPOvk9DZnA0p7rlzFDMc2c1v17Q08ToAhdHSEk=
Date:   Wed, 21 Aug 2019 16:25:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, cui.zhang@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com
Subject: Re: [PATCH v10 08/23] iommu/io-pgtable-arm-v7s: Rename the quirk
 from MTK_4GB to MTK_EXT
Message-ID: <20190821152553.r6mdhucvuovq4xdk@willie-the-truck>
References: <1566395606-7975-1-git-send-email-yong.wu@mediatek.com>
 <1566395606-7975-9-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566395606-7975-9-git-send-email-yong.wu@mediatek.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 09:53:11PM +0800, Yong Wu wrote:
> In previous mt2712/mt8173, MediaTek extend the v7s to support 4GB dram.
> But in the latest mt8183, We extend it to support the PA up to 34bit.
> Then the "MTK_4GB" name is not so fit, This patch only change the quirk
> name to "MTK_EXT".
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 6 +++---
>  drivers/iommu/mtk_iommu.c          | 2 +-
>  include/linux/io-pgtable.h         | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
