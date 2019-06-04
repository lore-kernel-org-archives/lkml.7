Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726B8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD224A00
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfFDNhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:37:20 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47530 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfFDNhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:37:18 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hY9cn-0001OW-8E; Tue, 04 Jun 2019 15:37:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-rockchip@lists.infradead.org, kernel@collabora.com,
        ezequiel@collabora.com, laurent.pinchart@ideasonboard.com,
        manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Vicente Bergas <vicencb@gmail.com>, devicetree@vger.kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Xie <tony.xie@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: fix isp iommu clocks and power domain
Date:   Tue, 04 Jun 2019 15:37:12 +0200
Message-ID: <5083973.35ftUdt9Su@phil>
In-Reply-To: <20190603142214.24686-1-helen.koike@collabora.com>
References: <20190603142214.24686-1-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 3. Juni 2019, 16:22:15 CEST schrieb Helen Koike:
> isp iommu requires wrapper variants of the clocks.
> noc variants are always on and using the wrapper variants will activate
> {A,H}CLK_ISP{0,1} due to the hierarchy.
> 
> Also add the respective power domain.
> 
> Refer:
>  RK3399 TRM v1.4 Fig. 2-4 RK3399 Clock Architecture Diagram
>  RK3399 TRM v1.4 Fig. 8-1 RK3399 Power Domain Partition
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>

applied for 5.3 with the received Tested-tag and I also moved
parts of the comment into the commit message making it:

"isp iommu requires wrapper variants of the clocks.
noc variants are always on and using the wrapper variants will activate
{A,H}CLK_ISP{0,1} due to the hierarchy.

Tested using the pending isp patch set (which is not upstream
yet). Without this patch, streaming from the isp stalls.
    
Also add the respective power domain and remove the "disabled" status.
    
Refer:
 RK3399 TRM v1.4 Fig. 2-4 RK3399 Clock Architecture Diagram
 RK3399 TRM v1.4 Fig. 8-1 RK3399 Power Domain Partition"

Thanks
Heiko


