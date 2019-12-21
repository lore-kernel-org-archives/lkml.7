Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCB3C2D0D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 12:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4021655
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 12:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLUMQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 07:16:15 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55040 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfLUMQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 07:16:15 -0500
Received: from [195.37.15.138] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iidfu-0004rE-Np; Sat, 21 Dec 2019 13:16:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v3 0/4] arm64: dts: rockchip: Add Rock Pi N10 support
Date:   Sat, 21 Dec 2019 13:15:59 +0100
Message-ID: <2568287.AjJObobGxI@phil>
In-Reply-To: <20191216174711.17856-1-jagan@amarulasolutions.com>
References: <20191216174711.17856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 16. Dezember 2019, 18:47:07 CET schrieb Jagan Teki:
> Unlike, other Rock PI boards from radxa, Rock Pi N10 SBC is based
> on SOM + Carrier board combination.
> 
> Rock Pi N10 is a Rockchip RK3399Pro based SBC, which has
> - VMARC RK3399Pro SOM (as per SMARC standard) from Vamrs.
> - Dalang carrier board from Radxa.
> 
> patch 0001: dt-bindings for Rock Pi N10
> 
> patch 0002: VMARC RK3399Pro SOM dtsi support
> 
> patch 0003: Radxa Dalang carrier board dtsi support
> 
> patch 0004: Rock Pi N10 dts support
> 
> Tested basic peripherals and will all more in future patches.

applied all 4 for 5.6

And looking for to seeing the rk3288-variant as well :-D .

Thanks
Heiko


