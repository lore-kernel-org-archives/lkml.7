Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABCBC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8A121738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFZWXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:23:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56712 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfFZWXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:23:33 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hgGK4-0004R2-4U; Thu, 27 Jun 2019 00:23:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, zhangzj@rock-chips.com,
        manivannan.sadhasivam@linaro.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: dts: rockchip: add core dtsi file for RK3399Pro SoCs
Date:   Thu, 27 Jun 2019 00:23:23 +0200
Message-ID: <1733690.4bxWPRXO5t@phil>
In-Reply-To: <20190530000848.28106-1-jay.xu@rock-chips.com>
References: <20190529074752.19388-1-jay.xu@rock-chips.com> <20190530000848.28106-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 30. Mai 2019, 02:08:48 CEST schrieb Jianqun Xu:
> This patch adds core dtsi file for Rockchip RK3399Pro SoCs,
> include rk3399.dtsi. Also enable pciei0/pcie_phy for AP to
> talk to NPU part inside SoC.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

applied for 5.3

Thanks
Heiko


