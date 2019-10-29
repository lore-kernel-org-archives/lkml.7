Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49FCCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7326F21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572375562;
	bh=DnrJj9nOzaA6P29ZDDVBM/Y/2X8RqJms5ZY2E1b67XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vms+5wSdF1YIBKEvRlgVzxr7rYv2Nx+i7HMxhwX/JefkightyzILtxWtSHfetqcTW
	 zmY9qR8pxcxjAE2lMGwmp5NxbUtyw7C6dtSVJi+FcQIs1+ZvsWP2wzTnyD+epe9DE/
	 tj0mmYJU6hsqKf3wG+NBh3L6WxfT0k/Li4Rs/z2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbfJ2S7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:59:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44532 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfJ2S7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:59:20 -0400
Received: by mail-oi1-f195.google.com with SMTP id s71so9865824oih.11;
        Tue, 29 Oct 2019 11:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbW0B9s33za8M6w/VE4RAdJj372wopfiVHvYx/5lzV8=;
        b=OHm+5fM9o46PGGHqSTnofx5NYwp8HSQ8PwFc/4coq3G07AR+8I/O1Da+Q/QwM3B1pl
         T9n4LlUx7NKrV6zDJVRJeEPtzIw5HoEF297rhGkA1hsMzqgX3lGwAage2g0/pFMevCG1
         Jnu1CzX23zT7s9gvckgn3C1wU7cV0oAh6qsUMI/hK3t/I0WvG9Cl9swdu9pke68P2HAk
         Mtm8wJs6SbZfzAS54a/Uz7yh7E/EWG9Z5ksY5hHoWCRlhPUqaNsTasN5HJq8WfFGPa6K
         JPioXWp3mEGMM97Yl1dxINWhbfZgjBoGWXN9n+iljrJyti2NVDW6ZHWSejf34cCRFycM
         /jvA==
X-Gm-Message-State: APjAAAXfN+QEMOM/wTvAP0Y80SYOwb+EvHgvKyjDgyXdD3xwcegwMqHs
        wePRv7/E9BrdMNaqi5xWhg==
X-Google-Smtp-Source: APXvYqzCYq3KtcJTg/u8ba3wAtt300fBoCT87IEubd8faZr8MJMw32nqZ9gqVS7HHtglOZo8yKOmfQ==
X-Received: by 2002:aca:1309:: with SMTP id e9mr5606883oii.72.1572375559336;
        Tue, 29 Oct 2019 11:59:19 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a88sm5149017otb.0.2019.10.29.11.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 11:59:18 -0700 (PDT)
Date:   Tue, 29 Oct 2019 13:59:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Anil Varughese <aniljoy@cadence.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 01/14] dt-bindings: phy: Sierra: Add bindings for
 Sierra in TI's J721E
Message-ID: <20191029185916.GA19313@bogus>
References: <20191023125735.4713-1-kishon@ti.com>
 <20191023125735.4713-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023125735.4713-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:27:22PM +0530, Kishon Vijay Abraham I wrote:
> Add DT binding documentation for Sierra PHY IP used in TI's J721E
> SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-sierra.txt  | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> index 6e1b47bfce43..bf90ef7e005e 100644
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt
> @@ -2,21 +2,24 @@ Cadence Sierra PHY
>  -----------------------
>  
>  Required properties:
> -- compatible:	cdns,sierra-phy-t0
> -- clocks:	Must contain an entry in clock-names.
> -		See ../clocks/clock-bindings.txt for details.
> -- clock-names:	Must be "phy_clk"
> +- compatible:	Must be "cdns,sierra-phy-t0" for Sierra in Cadence platform
> +		Must be "ti,sierra-phy-t0" for Sierra in TI's J721E SoC.
>  - resets:	Must contain an entry for each in reset-names.
>  		See ../reset/reset.txt for details.
>  - reset-names:	Must include "sierra_reset" and "sierra_apb".
>  		"sierra_reset" must control the reset line to the PHY.
>  		"sierra_apb" must control the reset line to the APB PHY
> -		interface.
> +		interface ("sierra_apb" is optional).
>  - reg:		register range for the PHY.
>  - #address-cells: Must be 1
>  - #size-cells:	Must be 0
>  
>  Optional properties:
> +- clocks:		Must contain an entry in clock-names.
> +			See ../clocks/clock-bindings.txt for details.
> +- clock-names:		Must be "phy_clk". Must contain "cmn_refclk" and
> +			"cmn_refclk1" for configuring the frequency of the
> +			clock to the lanes.

I don't understand how the same block can have completely different 
clocks. Did the original binding forget some? 

TI needs 0, 1 or 3 clocks? Reads like it could be any.

Rob
