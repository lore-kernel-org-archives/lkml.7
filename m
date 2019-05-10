Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76887C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50859217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfEJVdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:33:23 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41685 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfEJVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:33:23 -0400
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C24CD200003;
        Fri, 10 May 2019 21:33:19 +0000 (UTC)
Date:   Fri, 10 May 2019 23:33:19 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Nicolas.Ferre@microchip.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: clk: at91: add bindings for
 SAM9X60's slow clock controller
Message-ID: <20190510213319.GF7622@piout.net>
References: <1557487388-32098-1-git-send-email-claudiu.beznea@microchip.com>
 <1557487388-32098-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557487388-32098-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2019 11:23:35+0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add bindings for SAM9X60's slow clock controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> 
> Hi Rob,
> 
> I didn't added your Reviewed-by tag to this version since I changed
> the driver with regards to clock-cells DT binding (and I though you
> may want to comment on this).
> 
> Thank you,
> Claudiu Beznea
> 
>  Documentation/devicetree/bindings/clock/at91-clock.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
> index b520280e33ff..13f45db3b66d 100644
> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
> @@ -9,10 +9,11 @@ Slow Clock controller:
>  Required properties:
>  - compatible : shall be one of the following:
>  	"atmel,at91sam9x5-sckc",
> -	"atmel,sama5d3-sckc" or
> -	"atmel,sama5d4-sckc":
> +	"atmel,sama5d3-sckc",
> +	"atmel,sama5d4-sckc" or
> +	"microchip,sam9x60-sckc":
>  		at91 SCKC (Slow Clock Controller)
> -- #clock-cells : shall be 0.
> +- #clock-cells : shall be 1 for "microchip,sam9x60-sckc" otherwise shall be 0.
>  - clocks : shall be the input parent clock phandle for the clock.
>  
>  Optional properties:
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
