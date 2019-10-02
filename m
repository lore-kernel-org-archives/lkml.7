Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E15C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00D021920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570025964;
	bh=5HXOhtVDyZKs4AjG/w53JvUHq6ITwThsrvK7hd6/ih4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=byR2NIMtDhx0UVYWp8HgRy6r/4/XTQNQMOH0LMYc4ERZ/YgXWVhViaC20Tkq2vzan
	 fUQNyBV34WBLE+H9Nn/aGp9ma14YMWHG+vPcmQWUlqHfqCWRlY9YbQ2Wi7cYlZ6soy
	 z/UVrCLPHIOaVfGewy89jQdDBjiXPKQT+gvp9F6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfJBOTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:19:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41159 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfJBOTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:19:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so5942503qtq.8;
        Wed, 02 Oct 2019 07:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdHVcKy1GZjDuNv8mm9CbMrs4v740j7IGcsM8HIISNE=;
        b=MezZWIIPVTrNnpTxWXZuyn7kHgkASFzN254Wrz4xIW8c595/5oezAFgxlhHtXjZPB3
         jyDX9gQ9mAhdRsVI+Pc2yU63eRsILs6e/k3dRgKNFPCqb/lnrVehK0Lapgt5AOho5fJt
         t0SOu4Cqlmb+5OKLVZZDzSHSOub1DnlOnLBARxS69gfmCl4gfosLXfuU0l2C0uEG3bYT
         qPaLgQFZCUdi+e0+/+vthou69c0G0sUYYXJXqRQWsJUT3rhfQYH6tkK2CbLrFUDfwI/4
         YeKovZM73fQN3Sffg0HqwxyoFn6Pei2ptKRaSTnch3K+80zo8TPkbVyD3g/ZLtOmkpr0
         oiYA==
X-Gm-Message-State: APjAAAUur+Cv/5xKiuvki33fmz8SoGIaHO9zy/JH4VjtEnnmdkbtOmO/
        Ljfm+GEfWcsyeMqioK++wA==
X-Google-Smtp-Source: APXvYqxLo7HVIvhIgLQdK4wtlGRPcW55wJ7e24/iQcl8VNS8WTCBa6nei+T6U8I6wqtQbPAQsuiajw==
X-Received: by 2002:aed:27c1:: with SMTP id m1mr4213362qtg.197.1570025955786;
        Wed, 02 Oct 2019 07:19:15 -0700 (PDT)
Received: from localhost ([132.205.230.8])
        by smtp.gmail.com with ESMTPSA id 131sm9546617qkg.1.2019.10.02.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 07:19:15 -0700 (PDT)
Message-ID: <5d94b1e3.1c69fb81.9d89.1cce@mx.google.com>
Date:   Wed, 02 Oct 2019 09:19:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heiko Schocher <hs@denx.de>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: add cc1101 devicetree binding
References: <20190922060356.58763-1-hs@denx.de>
 <20190922060356.58763-2-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190922060356.58763-2-hs@denx.de>
X-Mutt-References: <20190922060356.58763-2-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 08:03:55AM +0200, Heiko Schocher wrote:
> add devicetree binding for cc1101 misc driver.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> 
>  .../devicetree/bindings/misc/cc1101.txt       | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/cc1101.txt

Can you please convert this to DT schema.

> 
> diff --git a/Documentation/devicetree/bindings/misc/cc1101.txt b/Documentation/devicetree/bindings/misc/cc1101.txt
> new file mode 100644
> index 0000000000000..afea6acf4a9c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/cc1101.txt

Normal naming is to use compatible string. So ti,cc1101.yaml for schema.

> @@ -0,0 +1,27 @@
> +driver cc1101 Low-Power Sub-1 GHz RF Transceiver chip from Texas
> +Instruments.
> +
> +Requires node properties:
> +- compatible : should be "ti,cc1101";
> +- reg        : Chip select address of device, see:
> +               Documentation/devicetree/bindings/spi/spi-bus.txt
> +- gpios      : list of 2 gpios, first gpio is for GDO0 pin
> +               second for GDO2 pin, see more:

Is there a GDO1? Would be hard to add later because you can't change the 
indices once defined.

> +               Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Recommended properties:
> + - spi-max-frequency: Definition as per
> +                Documentation/devicetree/bindings/spi/spi-bus.txt

Notice that this file is now just in redirection...

> + - freq       : used spi frequency for communication with cc1101 chip

What's this? Doesn't spi-max-frequency cover it?

> +
> +example:
> +
> +&ecspi4 {
> +        cc1101@0 {
> +                compatible = "ti,cc1101";
> +                spi-max-frequency = <10000000>;
> +                reg = <0>;
> +                freq = <5000000>;
> +                gpios = <&gpio2 11 GPIO_ACTIVE_HIGH &gpio5 8 GPIO_ACTIVE_HIGH>;
> +        };
> +};
> -- 
> 2.21.0
> 

