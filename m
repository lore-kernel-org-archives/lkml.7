Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC66C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166CE206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 10:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfHMKRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 06:17:23 -0400
Received: from muru.com ([72.249.23.125]:57048 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfHMKRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:17:23 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0CD3B805C;
        Tue, 13 Aug 2019 10:17:49 +0000 (UTC)
Date:   Tue, 13 Aug 2019 03:17:19 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-omap@vger.kernel.org, bcousson@baylibre.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am335x-wega.dtsi: fix wrong card detect pin
 level
Message-ID: <20190813101719.GG52127@atomide.com>
References: <20190709183209.y64keopah5rkismc@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709183209.y64keopah5rkismc@arbad>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Klinger <ak@it-klinger.de> [190709 11:32]:
> mmc cards on mmc1 are not detected because of wrong card detect (cd) level.
> 
> Change cd from GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW.
> 
> This is necessary because of commit e63201f19438 ("mmc: omap_hsmmc:
> Delete platform data GPIO CD and WP")
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  arch/arm/boot/dts/am335x-wega.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
> index b7d28a20341f..84581fed3d06 100644
> --- a/arch/arm/boot/dts/am335x-wega.dtsi
> +++ b/arch/arm/boot/dts/am335x-wega.dtsi
> @@ -157,7 +157,7 @@
>  	bus-width = <4>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
> -	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
>  

Looks like this already got fixed with an earlier commit 8a0098c05a27
("ARM: dts: am335x phytec boards: Fix cd-gpios active level").

Regards,

Tony
