Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9476AC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678192184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553798326;
	bh=eR32QZ2WtNp93/AOs/PXLYuM8TVJxmH6h+0GLECIZWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E43WL8YovcRtlvXGnGO6iLut9Pq3hvRmfzGmPhLV6VBc1nbqSlrBxNEuT/yB24LwJ
	 aiF8EfqRKnvqUK9L7KzuqVB1j2RTE/8RyCC5cl8yRwG9eghBaiuMNOapLUTSg68Z4U
	 PyOPjPgw7gA/vtEXqUmSlfnD4yEBygqrLBwNmExU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfC1Sip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:38:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44082 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfC1Sio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:38:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id i21so16584379oib.11;
        Thu, 28 Mar 2019 11:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CqbjMfLF5yty5z0sWtkYupJ+LsMShcu40O3GKLLil0k=;
        b=fyERlPFGOFZqU82B2z5B7e4aIARt5V6A19DERNmXbqlCSvDRdKIySSyChUq4pzA/zQ
         AkhtQj1R0UtsjoAsjWy6bTAOC233RH4HWYDnUpnutjzczuM1418IF7WS7P+YGG65lK01
         E+zPswg35JISoJ/YrACrtL2evmpZvnTrAC0RVk1Y9vOGtCl/LlV/RMsqEoZcR+ZuNgFX
         fzbM6WAPtwOdwY6ab+RrGwbR1EBsPcGhQwNCrFDm+y3jyRNC/tIFKefJpze2ZG09Eh5l
         cj/DpvvfxZ1hqQmTC3Id/RDqOTYOsEZyt+7R4uIuhsXAxq/Akd1fTXCWGFiGDkapFao6
         zPWA==
X-Gm-Message-State: APjAAAUjlbW9QYHSAveB6BiCNSaKx0oh1J7GrHdFUof19qAM/A+yrjNm
        +q0u57s+tiyuwGVsq8/VCQ==
X-Google-Smtp-Source: APXvYqw8OQeTIDAN8XvE7tbypYPit/cLN8EQv3uIhGjZUFSbW5W8gAvZDtLpbiVX1PrKNGpdrPUN2Q==
X-Received: by 2002:aca:eb93:: with SMTP id j141mr1006726oih.178.1553798323660;
        Thu, 28 Mar 2019 11:38:43 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s185sm9938851oif.30.2019.03.28.11.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:38:42 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:38:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
Cc:     jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: Add bindings for TI TLA202x ADCs
Message-ID: <20190328183842.GA9079@bogus>
References: <1553608583-29006-1-git-send-email-ibtsam.haq.0x01@gmail.com>
 <1553608583-29006-2-git-send-email-ibtsam.haq.0x01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553608583-29006-2-git-send-email-ibtsam.haq.0x01@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:56:20PM +0100, Ibtsam Ul-Haq wrote:
> This adds devicetree bindings for TI TLA202x ADCs.
> 
> Signed-off-by: Ibtsam Ul-Haq <ibtsam.haq.0x01@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti-tla2024.txt     | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt b/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
> new file mode 100644
> index 0000000..a4934df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-tla2024.txt
> @@ -0,0 +1,45 @@
> +Texas Instruments' TLA2021/TLA2022/TLA2024 12-bit ADC driver
> +
> +Required properties:
> +
> +- compatible: should be one of:
> +  "ti,tla2024"
> +  "ti,tla2022"
> +  "ti,tla2021"
> +
> +- reg: should contain the I2C Address of the device
> +
> +Required subnodes:
> +
> +The ADC channels are configured as subnodes of the ADC.
> +The channels can be single-ended or differential, the input pins are
> +also set in the subnode.
> +
> +Possible channels in TLA2024:
> +  single: <0>, <1>, <2>, <3>
> +  differential: <0 1>, <0 3>, <1 3>, <2 3>
> +
> +In TLA2021/TLA2022 only the differential channel <0 1> is allowed.
> +
> +Example:
> +
> +tla2024_0: adc0@49 {

adc@49

> +	compatible = "ti,tla2024";
> +	reg = <0x49>;
> +
> +	v0@0 {

Unit-address without 'reg' is not valid.

> +		single-channel = <0>;

Look at the common adc binding or adi,ad7124.txt for how to do 
multi-channel with differential channels.

> +	};
> +
> +	v1@1 {
> +		single-channel = <1>;
> +	};
> +
> +	v23@2 {
> +		diff-channels = <2 3>;
> +	};
> +
> +	v01@3 {
> +		diff-channels = <0 1>;
> +	};
> +};
> -- 
> 2.7.4
> 
