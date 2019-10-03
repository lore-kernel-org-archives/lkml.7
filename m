Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4F5C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9946215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfJCVZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:25:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56394 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbfJCVZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:25:54 -0400
Received: from p57b7758c.dip0.t-ipconnect.de ([87.183.117.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iG8bg-0000an-7d; Thu, 03 Oct 2019 23:25:52 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 01/13] arm64: dts: rockchip: fix iface clock-name on px30 iommus
Date:   Thu, 03 Oct 2019 23:25:51 +0200
Message-ID: <2015322.eFjuJPvpNX@phil>
In-Reply-To: <20190917082659.25549-1-heiko@sntech.de>
References: <20190917082659.25549-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 17. September 2019, 10:26:47 CEST schrieb Heiko Stuebner:
> The iommu clock names are aclk+iface not aclk+hclk as in the vendor kernel,
> so fix that in the px30.dtsi
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied patches 1-11 for 5.5

Patches 12+13 need the corresponding phy change to land first


