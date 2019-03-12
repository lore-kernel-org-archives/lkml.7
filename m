Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071C2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0580206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfCLMw7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:52:59 -0400
Received: from gloria.sntech.de ([185.11.138.130]:59816 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLMw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:52:56 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3gtc-0001hS-VG; Tue, 12 Mar 2019 13:52:40 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawn.lin@rock-chips.com,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Brian Norris <briannorris@chromium.org>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Lin Huang <hl@rock-chips.com>, Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: phy: Add a new property drive-impedance-ohm for RK's emmc PHY
Date:   Tue, 12 Mar 2019 13:52:39 +0100
Message-ID: <1924357.CMCVK5N5Qd@phil>
In-Reply-To: <20190307084159.25236-2-christoph.muellner@theobroma-systems.com>
References: <20190307084159.25236-1-christoph.muellner@theobroma-systems.com> <20190307084159.25236-2-christoph.muellner@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Am Donnerstag, 7. März 2019, 09:41:54 CET schrieb Christoph Muellner:
> This patch documents the new proprty drive-impedance-ohm for
> Rockchip's eMMC PHY node.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> index e3ea55763b0a..5f5d999dacc3 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> @@ -13,6 +13,9 @@ specified by name:

you might want to adapt the section headline as well, as right now it
talks about "Optional clocks", but should likely become the generic
"Optional properties" as in other bindings (including moving the clock-
binding.txt reference down into the clock elements)


Heiko

>  		(because most boards can get basic functionality without having
>  		access to it), it is strongly suggested.
>   - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
> + - drive-impedance-ohm: Specifies the drive impedance in Ohm.
> +                        Possible values are 33, 40, 50, 66 and 100.
> +                        If not set, the default value of 50 will be applied.
>  
>  Example:
>  
> 




