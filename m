Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26398C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF5F2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999686;
	bh=4EU19QJuCTP6k4kjUw9UvVVABJ2lyWdKqJWUsvJ4ljU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o99WFE9Q0iDOQ4I8Hur/m26dSMw+PO6GxNyUGEpfrNyw9zemBSz8Z/NHZx+xyljXW
	 I2Af4/F225Q6qE1J5jZIp/2mOph6eqDUJOYy33KhAE6ZUJnhmJvd85pGGFkawp49CX
	 B28Gs36AsI0IVxPolf5ToFxTSbMRZBf9WC/2PFVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfGXUVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:21:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32900 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfGXUVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:21:21 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so92420608iog.0;
        Wed, 24 Jul 2019 13:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJ9nHyNd7LCl6+mSB0G4S2X04kojrU0TsARgzmq3agw=;
        b=BNIkH6qp4rBtneav00A8EL89rmsoggKpUyuYQ0vsM5uYaURpwi8w4DypecMZfuCTJw
         cXQgDBPZWPbtZ+2z2UppAf4Tan/7ZbY3AKCYTt6vgjkLTK9MXLV9YRlY609xqmeMawcs
         7MPKQiDaOnvOWAsVvWLLKHQYkvwOVByAg1pNOeO7PFad90/wAZY9ZmEQP3KhEXUc1OUP
         Ktj+p7FRQe+MnTro59nU1W0RSj4CIDgldRCHSqM7HbEcUmd/FghCLZjtfTwZJBUsdbbj
         SDsLcFBOcnatkOE6ZTa3tWbiz91Zf5Zlp3g1rZZ1KtlWuKaSnaIEs6JqX8XSLqLH3qDi
         EI4g==
X-Gm-Message-State: APjAAAUdoMwK8Ci6fUS6OX3VlWhUNSNr+5MUpK+tzqOHugmCpR60k6Lg
        IDxn/BXDrlXa+VMF6D1t8w==
X-Google-Smtp-Source: APXvYqwprV5ylAQXl6gUtT7NZHmcnqBWl3IgOcCq5QcBmtI4uojyhvDVa9K+DeOobOHPeGdMYTW9+Q==
X-Received: by 2002:a5e:8a46:: with SMTP id o6mr45348991iom.36.1563999680305;
        Wed, 24 Jul 2019 13:21:20 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id r24sm34281026ioc.76.2019.07.24.13.21.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:21:19 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:21:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     bbrezillon@kernel.org, matthias.bgg@gmail.com,
        mark.rutland@arm.com, linux-i3c@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
        liguo.zhang@mediatek.com, xinping.qian@mediatek.com
Subject: Re: [PATCH v3 1/2] dt-bindings: i3c: Document MediaTek I3C master
 bindings
Message-ID: <20190724202119.GA26566@bogus>
References: <1562677762-24067-1-git-send-email-qii.wang@mediatek.com>
 <1562677762-24067-2-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562677762-24067-2-git-send-email-qii.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:09:21PM +0800, Qii Wang wrote:
> Document MediaTek I3C master DT bindings.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   48 ++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> new file mode 100644
> index 0000000..d32eda6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> @@ -0,0 +1,48 @@
> +Bindings for MediaTek I3C master block
> +=====================================
> +
> +Required properties:
> +--------------------
> +- compatible: shall be "mediatek,i3c-master"

Needs to be SoC specific.

> +- reg: physical base address of the controller and apdma base, length of
> +  memory mapped region.
> +- reg-names: shall be "main" for master controller and "dma" for apdma.
> +- interrupts: the interrupt line connected to this I3C master.
> +- clocks: shall reference the i3c and apdma clocks.
> +- clock-names: shall include "main" and "dma".
> +
> +Mandatory properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- #address-cells: shall be set to 3
> +- #size-cells: shall be set to 0
> +
> +Optional properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- i2c-scl-hz
> +- i3c-scl-hz
> +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +	i3c0: i3c@1100d000 {
> +		compatible = "mediatek,i3c-master";
> +		reg = <0x1100d000 0x1000>,
> +		      <0x11000300 0x80>;
> +		reg-names = "main", "dma";
> +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&infracfg CLK_INFRA_I3C0>,
> +			 <&infracfg CLK_INFRA_AP_DMA>;
> +		clock-names = "main", "dma";
> +		#address-cells = <3>;
> +		#size-cells = <0>;
> +		i2c-scl-hz = <100000>;
> +
> +		nunchuk: nunchuk@52 {
> +			compatible = "nintendo,nunchuk";
> +			reg = <0x52 0x0 0x10>;
> +		};
> +	};
> -- 
> 1.7.9.5
> 
