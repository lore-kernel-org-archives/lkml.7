Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA604CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6D22086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfJaMIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:08:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36192 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaMIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:08:53 -0400
Received: from dhcp-159-84-61-180.univ-lyon2.fr ([159.84.61.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQ9Fx-00050d-VD; Thu, 31 Oct 2019 13:08:50 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH] phy: phy-rockchip-inno-usb2: add phy description for px30
Date:   Thu, 31 Oct 2019 13:08:48 +0100
Message-ID: <1974613.gpRaQal8Ma@phil>
In-Reply-To: <20190917082532.25479-1-heiko@sntech.de>
References: <20190917082532.25479-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

Am Dienstag, 17. September 2019, 10:25:32 CET schrieb Heiko Stuebner:
> The px30 soc from Rockchip shares the same register description as
> the rk3328, so can re-use its definitions.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

could you pick this up as well please?

Thanks
Heiko

> ---
>  Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt | 1 +
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c                    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index 00639baae74a..541f5298827c 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -2,6 +2,7 @@ ROCKCHIP USB2.0 PHY WITH INNO IP BLOCK
>  
>  Required properties (phy (parent) node):
>   - compatible : should be one of the listed compatibles:
> +	* "rockchip,px30-usb2phy"
>  	* "rockchip,rk3228-usb2phy"
>  	* "rockchip,rk3328-usb2phy"
>  	* "rockchip,rk3366-usb2phy"
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index eae865ff312c..680cc0c8825c 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1423,6 +1423,7 @@ static const struct rockchip_usb2phy_cfg rv1108_phy_cfgs[] = {
>  };
>  
>  static const struct of_device_id rockchip_usb2phy_dt_match[] = {
> +	{ .compatible = "rockchip,px30-usb2phy", .data = &rk3328_phy_cfgs },
>  	{ .compatible = "rockchip,rk3228-usb2phy", .data = &rk3228_phy_cfgs },
>  	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
>  	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
> 




