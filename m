Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47ADC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FC2215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556578731;
	bh=qIldjRfe9+zWV+TLE5YzDQRQiJMq6ClRLjxNI8HxS0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=go8xWzEqnlbDyZQx5tJzH7z446/3eId6saR2etLqwtbWICnwiHgncMIYy/h6ClJ0j
	 ViFQ5X9HCZBtJguXm1aTVj4YBYgYR32/Vtw/ZgKSw9PZCvj4CvkRKr1Sg9XRrnffjC
	 LnALYmiYf4gPllzsTFewI+HD0+xAAPsOqOD+3Bl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfD2W6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:58:50 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36779 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbfD2W6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:58:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so9766219oia.3;
        Mon, 29 Apr 2019 15:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ny4oOCNu4qgktzg8dYrHtC/j54FWv++KQps7rlvKcPg=;
        b=XhEiVXbmmd7GKG0CJbKNvB8m8+WuXijJ047QJF0aAYeUljz0V2ErJeKXZkkNmisgsI
         TDLa+V89EKF/OVe3MMPmMHzY8ti2MqJhc5jRidwMMovTYDaKfKr1pwJIiLbeBorMs7XS
         g/UVdFDnKYZvssYmDn2i0RyxEKDbMGNNW72mryvdX8/TFW8RyRUvHzHGCUQN9IUbMx5w
         1lhOqspsbjX2nR6su5n1kEUiSqevYXENvTXX7WFCSt9YXYwIjHwP4JNroojEmGoiqGHC
         kqkBdUkchgi3iR9xhEC8FRJhQ5O333//2V79tbIGhT/6CDg0+2vGEjbqDLxy2qelqVXT
         WNiw==
X-Gm-Message-State: APjAAAXJHvfrRRdZkDdS8vnDiOzhEM432Kzz77dRt3suREHCxRtIuFVi
        PpOE1R9q/86iR+Kx1tZ2Wg==
X-Google-Smtp-Source: APXvYqwNnA5K9okx087TgpZXy5ng5WNqVJDOpJxMQgUk8bok5PwAPI0KZLXBkHxz/j6QV5CW/AgTEA==
X-Received: by 2002:aca:d90a:: with SMTP id q10mr1108213oig.65.1556578728752;
        Mon, 29 Apr 2019 15:58:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e133sm15117456oif.44.2019.04.29.15.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 15:58:47 -0700 (PDT)
Date:   Mon, 29 Apr 2019 17:58:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arnd.de, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-binding: misc: Add common LPC snoop
 documentation
Message-ID: <20190429225847.GA8905@bogus>
References: <20190416111631.356803-1-tmaimon77@gmail.com>
 <20190416111631.356803-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416111631.356803-2-tmaimon77@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:16:30PM +0300, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM BIOS Post Code (BPC) and Apeed AST2500 LPC snoop.

s/Apeed/Aspeed/

> The LPC snoop monitoring two configurable I/O addresses
> written by the host on Low Pin Count (LPC) bus.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../devicetree/bindings/misc/lpc-snoop.txt         | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/lpc-snoop.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/lpc-snoop.txt b/Documentation/devicetree/bindings/misc/lpc-snoop.txt
> new file mode 100644
> index 000000000000..c21cb8df4ffb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/lpc-snoop.txt
> @@ -0,0 +1,27 @@
> +LPC snoop interface
> +
> +The LPC snoop (BIOS Post Code) interface can monitor
> +two configurable I/O addresses written by the host on
> +the Low Pin Count (LPC) bus.
> +
> +Nuvoton NPCM7xx LPC snoop supports capture double words,
> +when using capture double word only I/O address 1 is monitored.
> +
> +Required properties for lpc-snoop node
> +- compatible   : "nuvoton,npcm750-lpc-bpc-snoop" for Poleg NPCM7XX
> +                 "aspeed,ast2500-lpc-snoop" for Aspeed AST2500.
> +- reg          : specifies physical base address and size of the registers.
> +- interrupts   : contain the LPC snoop interrupt with flags for falling edge.
> +- snoop-ports  : contain monitor I/O addresses, at least one monitor I/O
> +                 address required
> +
> +Optional property for NPCM7xx lpc-snoop node
> +- nuvoton,lpc-en-dwcapture : enable capture double words support.
> +
> +Example:
> +	lpc-snoop: lpc_snoop@f0007040 {

lpc-snoop@...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +		compatible = "nuvoton,npcm750-lpc-bpc-snoop";
> +		reg = <0xf0007040 0x14>;
> +		snoop-ports = <0x80>;
> +		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> -- 
> 2.14.1
> 
