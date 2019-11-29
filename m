Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF06AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43852084D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK2L1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:27:41 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44447 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2L1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:27:41 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 22e94758b4d00fa0; Fri, 29 Nov 2019 12:27:39 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] power: avs: Fix Kconfig indentation
Date:   Fri, 29 Nov 2019 12:27:39 +0100
Message-ID: <3653693.6e8bOcHH1D@kreacher>
In-Reply-To: <20191120134004.14167-1-krzk@kernel.org>
References: <20191120134004.14167-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 20, 2019 2:40:04 PM CET Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/power/avs/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
> index b5a217b828dc..089b6244b716 100644
> --- a/drivers/power/avs/Kconfig
> +++ b/drivers/power/avs/Kconfig
> @@ -13,9 +13,9 @@ menuconfig POWER_AVS
>  	  Say Y here to enable Adaptive Voltage Scaling class support.
>  
>  config ROCKCHIP_IODOMAIN
> -        tristate "Rockchip IO domain support"
> -        depends on POWER_AVS && ARCH_ROCKCHIP && OF
> -        help
> -          Say y here to enable support io domains on Rockchip SoCs. It is
> -          necessary for the io domain setting of the SoC to match the
> -          voltage supplied by the regulators.
> +	tristate "Rockchip IO domain support"
> +	depends on POWER_AVS && ARCH_ROCKCHIP && OF
> +	help
> +	  Say y here to enable support io domains on Rockchip SoCs. It is
> +	  necessary for the io domain setting of the SoC to match the
> +	  voltage supplied by the regulators.
> 

Applying as 5.5 material, thanks!



