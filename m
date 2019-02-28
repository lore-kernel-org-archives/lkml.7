Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE7FC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD822133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551379706;
	bh=LtUrXngQUYvD/5hhmNfQGS5wMFk3+eZdUG/gRmddzdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2AgdjOh4kqiaKVgPfvZKKuGkQvCgo3EGpa0XZhj0CGI491jioBtR6qz5uZetOljgg
	 TcoGzGT71aISAp2ViMRESnMQf1kY64P5x/ICxKHT6rPNCrD+DrekaUS756pxxcCecq
	 GBuJzyPU91Hp0hHqdkLvXikfN2il8QnfxUe0wjcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbfB1SsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:48:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34016 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfB1SsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:48:25 -0500
Received: by mail-oi1-f195.google.com with SMTP id g16so17381998oib.1;
        Thu, 28 Feb 2019 10:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=roqaL1uJJkGE/SVuMmyzeIg//rbsB7+jOOnA0IByL7I=;
        b=t7fQK2T/yBUym2fM2vLpOf4igz3oRTvmfG0cm2iI1BxpjZ4pDN0xWdeA5JJc4/fT6V
         rqrOXCRwSP9ymbM+SUTzvgxHwObbE02VcvIbyszI81G4BjkNZMbJDzswGOP4/ldEH4VV
         gt1Lv+IhfgX3K5lTGoCcSRnOBPzC37IkEh1Xi925dbQ+UKgr9ML5OJHDHVI6ts62hyTm
         qv3olEuryw9CTolgNIIhmLflRrgNUhys7BMeOH6SCvAxA4kdCJ77IRfPRYMhD5eda68u
         55cD363BkjyGblqjJOBpqRgn199CF4uiuSdxk6OtoiJrCV+K5WhsTbOA7diNFtVXi1Vv
         BVag==
X-Gm-Message-State: AHQUAubd2JxKjW53wNqBOudpSxt0xas0DQ0jIE5jH1kyLu0SfWwnit2p
        dE2ZT8seyHmsX22J/8CNGw==
X-Google-Smtp-Source: AHgI3IYq6yI7kg8jKcCd3Ucyo9MhXCG5WVvW0u09VPczg6502VXstUc9eNtthclC0JXhrzZJBUO4cw==
X-Received: by 2002:aca:ac45:: with SMTP id v66mr737665oie.134.1551379704135;
        Thu, 28 Feb 2019 10:48:24 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id v62sm8308367oie.21.2019.02.28.10.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:48:23 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:48:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/7] dt-bindings: power: supply: Add docs for Ingenic
 JZ47xx SoCs battery.
Message-ID: <20190228184822.GA17624@bogus>
References: <20190217142914.17433-1-contact@artur-rojek.eu>
 <20190217142914.17433-4-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217142914.17433-4-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 03:29:13PM +0100, Artur Rojek wrote:
> Add documentation for the ingenic-battery driver, used on JZ47xx SoCs.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  .../bindings/power/supply/ingenic,battery.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> new file mode 100644
> index 000000000000..66430bf73815
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.txt
> @@ -0,0 +1,31 @@
> +* Ingenic JZ47xx battery bindings
> +
> +Required properties:
> +
> +- compatible: Must be "ingenic,jz4740-battery".
> +- io-channels: phandle and IIO specifier pair to the IIO device.
> +  Format described in iio-bindings.txt.
> +- monitored-battery: phandle to a "simple-battery" compatible node.
> +
> +The "monitored-battery" property must be a phandle to a node using the format
> +described in battery.txt, with the following properties being required:
> +
> +- voltage-min-design-microvolt: Drained battery voltage.
> +- voltage-max-design-microvolt: Fully charged battery voltage.
> +
> +Example:
> +
> +#include <dt-bindings/iio/adc/ingenic,adc.h>
> +
> +simple_battery: battery {
> +	compatible = "simple-battery";
> +	voltage-min-design-microvolt = <3600000>;
> +	voltage-max-design-microvolt = <4200000>;
> +};
> +
> +ingenic_battery {
> +	compatible = "ingenic,jz4740-battery";
> +	io-channels = <&adc INGENIC_ADC_BATTERY>;
> +	io-channel-names = "battery";
> +	monitored-battery = <&simple_battery>;

Isn't this just an ADC monitored battery? What's specific to JZ4740?

Maybe a generic binding is appropriate here?

Rob

