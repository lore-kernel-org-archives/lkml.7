Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8098C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B38D121537
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557780979;
	bh=KiYse69UY3pLqx3u2f/ZadRbhZewiiANWvFYgbxBBfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=efcCNKyapL3i1AfNLLCF5u8sQ0Vx2Z9DI3UpoZxZNngLL4ctzP3xP6o8wXbOYVlH3
	 5hopifxiZSHa1FXvmJVjjVej6+aUKW1DPhOYfObYBapBzMr+a+ziby4kklruxelww+
	 dhA6O8QdCocPqaCxTHWfLOtQFJwJE0MQNGRobsOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfEMU4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:56:18 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43513 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMU4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:56:18 -0400
Received: by mail-oi1-f195.google.com with SMTP id t187so7142904oie.10;
        Mon, 13 May 2019 13:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mcXl3kCKb5KgymSfUTp36sQGmUpApKFd35PSjLLza2s=;
        b=ZRy9KrMMUi03FUGU+K65kfdDhPQ71eZFL+HnqvRFx+LkZ7wtfzFOwKsT9DK0+hNP5C
         FrhylP1HHCIj40hpvXzi/ReBAJAsX58NZQHPEceo09z5oU7Z3mq/2se2LlzFoTL43PZy
         gD1nwxLdZLquGG+sIR9Pl9Ye26nyXgUt6HKcUdF0j9aE4bjwDs3qkLJ83DpCE9PXMJ87
         gAuas9MS99KFFs50fnsdix8lHx84q4eNGmn2zEGDMtzaC4N7V8Vh2Mj8lX8rXCzpOt2f
         JZkAm/oBVCDQAGPPQgnkuPS/c7tNu7UEvxgmK9b6+z6T/VW/HMPk/GnD1GPQb+5CaZ2M
         8k0w==
X-Gm-Message-State: APjAAAXmyqT2Rat1Mwgnc4ENct2kqeOcDoq0JVaXDxoW+d0uvWfCE4gh
        DZjDbZZnsDr/us6dhlJ1Cg==
X-Google-Smtp-Source: APXvYqzIsXcXQJgcJ9Z3I5TOGeERLXFISQjzhCutcR9o7qybv7IPuw5Qz8r2lvriy6XfNBbt3ZoU0Q==
X-Received: by 2002:aca:c202:: with SMTP id s2mr742556oif.91.1557780977251;
        Mon, 13 May 2019 13:56:17 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m203sm5706301oib.45.2019.05.13.13.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 13:56:16 -0700 (PDT)
Date:   Mon, 13 May 2019 15:56:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc:     mark.rutland@arm.com, peter@korsgaard.com, andrew@lunn.ch,
        palmer@sifive.com, paul.walmsley@sifive.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 v2 1/3] dt-bindings: i2c: extend existing opencore
 bindings.
Message-ID: <20190513205615.GA5844@bogus>
References: <1557242108-13580-1-git-send-email-sagar.kadam@sifive.com>
 <1557242108-13580-2-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557242108-13580-2-git-send-email-sagar.kadam@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 08:45:06PM +0530, Sagar Shrikant Kadam wrote:
> Add FU540-C000 specific device tree bindings to already
> available i2-ocores file. This device is available on
> HiFive Unleashed Rev A00 board.
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> index 17bef9a..f6bcf90 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
> @@ -2,6 +2,7 @@ Device tree configuration for i2c-ocores
>  
>  Required properties:
>  - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
> +                    "sifive,fu540-c000-i2c" or "sifive,i2c0"

If this is Opencores IP, does it really follow the Sifive versioning 
convention? If so, please reference sifive-blocks-ip-versioning.txt 
(which appears to have missed going upstream). Also, referencing the IP 
repository would be good too. If this IP block doesn't follow the same 
convention, then don't try using it for this binding.

>  - reg             : bus address start and address range size of device
>  - interrupts      : interrupt number
>  - clocks          : handle to the controller clock; see the note below.
> @@ -67,3 +68,22 @@ or
>  			reg = <0x60>;
>  		};
>  	};
> +or

Just a new compatible isn't really a reason to add an example.

> +	/*
> +	  An Opencore based I2C node in FU540-C000 chip from SiFive
> +	  This chip has a hardware erratum for broken IRQ
> +	  so it's recommended not to define interrupt in the device node

Then interrupts needs to be optional.

> +	*/
> +	i2c@10030000 {
> +			compatible = "sifive,i2c0","sifive,fu540-c000-i2c";
> +			reg = <0x0 0x10030000 0x0 0x1000>;
> +			reg-names = "i2c-control";

Not doucmented.

> +			clocks = <&tlclk>;
> +			clock-frequency = <100000>;
> +
> +			reg-shift = <2>;
> +			reg-io-width = <1>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +	};
> -- 
> 1.9.1
> 
> 
> -- 
> The information transmitted is intended only for the person or entity to 
> which it is addressed and may contain confidential and/or privileged 
> material. If you are not the intended recipient of this message please do 
> not read, copy, use or disclose this communication and notify the sender 
> immediately. It should be noted that any review, retransmission, 
> dissemination or other use of, or taking action or reliance upon, this 
> information by persons or entities other than the intended recipient is 
> prohibited.
