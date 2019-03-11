Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988112087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552345149;
	bh=bnY5ANxNVM456xNfjLlmNeeXXFGHmkDjRLRwTYL71aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ScIcPoSWrfd72h4kgL1rsuJj/kVxZMDlkoSCu0HU8FaQCbZWu6OTl6TqISzOJmWYq
	 u8RKPoiFbUXKxJqg9ktMCg6y0B/96hx4U3heG5f0/aUoaWEySNJi3FoOdqd+dQTb1h
	 aO+1hzdT4EEc+OA7/5WoTzYGs9PS9czT8NWvMd2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfCKW7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:59:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34474 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfCKW7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:59:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id g16so540170oib.1;
        Mon, 11 Mar 2019 15:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c8UCbwfRUGWEdOWW1k6Y6c1BXaolySAOS2vbKR36CCY=;
        b=iK7CU/2XEVRXd3smVkZhkuU9oJ8jUMCnLeqT7f2uIiWEY9x8jcHM+K/Js4HvDX8uQm
         UkzfB5NT5ai6GwAhI53uzS/9rN8N3MYKKL/zIEoPozLppMUklXQPfHEoPb828avtcox0
         qmwmnCWYZSusNWDwDv84bT6VhwFci5N5lY7tp63n8NxXbGFRnJtmcF6TzQDHRZCeoeW4
         NSvB7jc1nrKn9lkdBmepiArQu1WePIFGMc3QzswUkI7MJO5/55D++LWQPQME93p3mqB8
         PYUtoJlNnKk+oxD/MAMy+Rozv+RxqrzRTiKr2iiij0HUzxsv1WY1UC4iPc/2S0tnpK5N
         Phfw==
X-Gm-Message-State: APjAAAUu2hONHpT563SbLiAPglR1ZfbbLvZmpQYeaqDMFw+b1uz5Nxmd
        ylgZF2RxtQDQN5iGDtVqpA==
X-Google-Smtp-Source: APXvYqzOk+1ocGYoPTyWwfZ8LG/8AWhsX8YKsFfGDdNq9jMakYyAtCq98C3TZmYvDc2ZO+1kKSBbbw==
X-Received: by 2002:aca:f4d5:: with SMTP id s204mr7599oih.63.1552345147051;
        Mon, 11 Mar 2019 15:59:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j18sm2796653otl.40.2019.03.11.15.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:59:06 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:59:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 armsoc/drivers/bus+gpio 2/5] dt-bindings: bus:
 Document moxtet bus binding
Message-ID: <20190311225906.GA9056@bogus>
References: <20190307125251.724-1-marek.behun@nic.cz>
 <20190307125251.724-3-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190307125251.724-3-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 01:52:48PM +0100, Marek Behún wrote:
> This adds device tree binding documentation for the Moxtet bus, a bus
> via which the different modules connected to the Turris Mox router can
> be configured.
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/bus/moxtet.txt        | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documentation/devicetree/bindings/bus/moxtet.txt
> new file mode 100644
> index 000000000000..7be9d00c1767
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/moxtet.txt
> @@ -0,0 +1,44 @@
> +Turris Mox module status and configuration bus (over SPI)
> +
> +Required properties:
> + - compatible		: Should be "cznic,moxtet"
> + - #address-cells	: Has to be 1
> + - #size-cells		: Has to be 0
> + - spi-cpol		: Required inverted clock polarity
> + - spi-cpha		: Required shifted clock phase
> + - interrupts		: Must contain reference to the shared interrupt line
> + - interrupt-controller	: Required
> + - #interrupt-cells	: Has to be 1
> +
> +For other required and optional properties of SPI slave nodes please refer to
> +../spi/spi-bus.txt.
> +
> +Required properties of subnodes:
> + - reg			: Should be position on the Moxtet bus

'position' is a little vague.

> +
> +The driver finds the devices connected to the bus by itself, but it may be
> +needed to reference some of them from other parts of the device tree. In that
> +case the devices can be defined as subnodes of the moxtet node.
> +
> +Example:
> +
> +	moxtet@1 {
> +		compatible = "cznic,moxtet";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <1>;
> +		spi-max-frequency = <10000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupt-parent = <&gpiosb>;
> +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> +
> +		moxtet_sfp: gpio@0 {
> +			compatible = "cznic,moxtet-sfp";

cznic,moxtet-gpio according to the next patch.

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			reg = <0>;
> +		}
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d96d36c83bc3..3f461a2d776a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1502,6 +1502,7 @@ ARM/CZ.NIC TURRIS MOX SUPPORT
>  M:	Marek Behun <marek.behun@nic.cz>
>  W:	http://mox.turris.cz
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/bus/moxtet.txt
>  F:	include/linux/moxtet.h
>  F:	drivers/bus/moxtet.c
>  
> -- 
> 2.19.2
> 
