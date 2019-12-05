Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21717C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E861A22525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575559012;
	bh=WIK65c6WJMswuB1/yzsaX0B0TqDvDhjVpIdXeK0c/Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oJdQOVPAlchBu14NF0HydofFChsclonvrzw7eNGDiBnKoEc7Tett5roqVMd06wSv7
	 ZSCq7nzuhRw+kuhSmIvBu7h274VEXHw70FboMWIG2caoE8jQSoidge5NkBgHWzTAly
	 O1x+j0o0bElyCYD9YAnDkfgPbTc3b0fSgdj4olLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfLEPQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:16:51 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45889 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:16:50 -0500
Received: by mail-oi1-f194.google.com with SMTP id v10so3002513oiv.12;
        Thu, 05 Dec 2019 07:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X30L2/SCmmy4K42AOTapqg9tKMhPdm3eZC6cSR8du98=;
        b=XQz2YfLztJW5y4gcuRfrtmsitouZOdzhCplZMmeaCleNdJjmWb3bddIdCAl+8u1Xl7
         77ZWFoPvtz2oJfChCfB086yeH9SZxxoSroI5S5rYUlLxLjhra6rx5Q1cGykOkRyMZ1LK
         PsuV9Jv8LVvw+5ODQRAZ3/z/TZYUDghMFn5jv3sUnZ5Af/2RqNaRu0FjIEsZk+OZnq/F
         K5IbRqz4oyfPPp2cqkiChVfc2WCFnfc96q8dxq1UGEGlB0s2hHXf8iiackjQywyXkZd/
         VLs3rupKb8+ZtbA5ddGa2IkYhvm+hZEP7311+lqaileHg2MmmaC1ScpoTOOKZnb+atOv
         hzCA==
X-Gm-Message-State: APjAAAWTLRXZsZ8LVWae+3EAMqyhg088stj1UH/VdD1QmYA2vCojIXzS
        jtUhbK9Vg0DqhMGKwulLvQ==
X-Google-Smtp-Source: APXvYqzHqt/rY6XQcuU7ueo8b9ybugfDYukAes39oBqOVVyEu3v063qYQtF2pekF0yMjPZb9r5Dd2A==
X-Received: by 2002:aca:f083:: with SMTP id o125mr7281931oih.122.1575559009391;
        Thu, 05 Dec 2019 07:16:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e17sm3469100otq.58.2019.12.05.07.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:16:48 -0800 (PST)
Date:   Thu, 5 Dec 2019 09:16:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: document the fsl-sai driver
Message-ID: <20191205151648.GA5680@bogus>
References: <20191122235622.8818-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122235622.8818-1-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 12:56:21AM +0100, Michael Walle wrote:
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/clock/fsl,sai-clock.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
> new file mode 100644
> index 000000000000..7116c8bc24d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings please: (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/fsl,sai-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale SAI bitclock-as-a-clock binding
> +
> +maintainers:
> +  - Michael Walle <michael@walle.cc>
> +
> +description: |
> +  It is possible to use the BCLK pin of a SAI module as a generic clock
> +  output. Some SoC are very constrained in their pin multiplexer
> +  configuration. Eg. pins can only be changed groups. For example, on the
> +  LS1028A SoC you can only enable SAIs in pairs. If you use only one SAI,
> +  the second pins are wasted. Using this binding it is possible to use the
> +  clock of the second SAI as a MCLK clock for an audio codec, for example.
> +
> +  This is a composite of a gated clock and a divider clock.
> +
> +properties:
> +  compatible:
> +    const: fsl,vf610-sai-clock
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +

Add:

additionalProperties: false

> +examples:
> +  - |
> +    mclk: clock-mclk@f130080 {
> +        compatible = "fsl,vf610-sai-clock";
> +        reg = <0x0 0xf130080 0x0 0x80>;

Examples are built now and this will fail because the default 
#address-cells and #size-cells are 1.

> +        #clock-cells = <0>;
> +        clocks = <&parentclk>;
> +    };
> -- 
> 2.20.1
> 
