Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65080ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B40821848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YM/HSvh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfJOLjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:39:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54618 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfJOLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:39:05 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF960324;
        Tue, 15 Oct 2019 13:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1571139542;
        bh=yoPsqnguXofm64qXBaPQ6QLvJoVxEAIjVYEFwiQ79VI=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YM/HSvh9aRCsibtOOiXQFe+YmDHCnEcfYjBb147pA0B6/MBqt3+bkBvTZ2rkwcMWw
         N/4AFHgP2TzQ6AmWRQKo+xYHbNCiKPEtk6v+Yf5557i1KaafWEDTnySU7r0V5X3zb4
         YJ4I4UejFCBGUdxu/XaXhAQpiHb+y6rSL9SLas6c=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH v5 1/8] dt-bindings: display: renesas,cmm: Add R-Car CMM
 documentation
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu,
        VenkataRajesh.Kalakodima@in.bosch.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, koji.matsuoka.xm@renesas.com,
        muroya@ksk.co.jp, Harsha.ManjulaMallikarjun@in.bosch.com,
        ezequiel@collabora.com, seanpaul@chromium.org,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
References: <20191015104621.62514-1-jacopo+renesas@jmondi.org>
 <20191015104621.62514-2-jacopo+renesas@jmondi.org>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <ef8e16cf-a1ef-6cf7-8735-b620a3d8f318@ideasonboard.com>
Date:   Tue, 15 Oct 2019 12:38:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104621.62514-2-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 15/10/2019 11:46, Jacopo Mondi wrote:
> Add device tree bindings documentation for the Renesas R-Car Display
> Unit Color Management Module.
> 
> CMM is the image enhancement module available on each R-Car DU video
> channel on R-Car Gen2 and Gen3 SoCs (V3H and V3M excluded).
> 

LGTM. Good to see how we get started with the new yaml bindings. I guess
we've got plenty of conversion work to do there ..

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../bindings/display/renesas,cmm.yaml         | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/renesas,cmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/renesas,cmm.yaml b/Documentation/devicetree/bindings/display/renesas,cmm.yaml
> new file mode 100644
> index 000000000000..a57037b9e9ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/renesas,cmm.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/renesas,cmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car Color Management Module (CMM)
> +
> +maintainers:
> +  - Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> +  - Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> +  - Jacopo Mondi <jacopo+renesas@jmondi.org>
> +
> +description: |+
> +  Renesas R-Car color management module connected to R-Car DU video channels.
> +  It provides image enhancement functions such as 1-D look-up tables (LUT),
> +  3-D look-up tables (CLU), 1D-histogram generation (HGO), and color
> +  space conversion (CSC).
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - renesas,r8a7795-cmm
> +          - renesas,r8a7796-cmm
> +          - renesas,r8a77965-cmm
> +          - renesas,r8a77990-cmm
> +          - renesas,r8a77995-cmm
> +        - const: renesas,rcar-gen3-cmm
> +      - items:
> +        - const: renesas,rcar-gen2-cmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - resets
> +  - power-domains
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a7796-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a7796-sysc.h>
> +
> +    cmm0: cmm@fea40000 {
> +         compatible = "renesas,r8a7796-cmm",
> +                      "renesas,rcar-gen3-cmm";
> +         reg = <0 0xfea40000 0 0x1000>;
> +         power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> +         clocks = <&cpg CPG_MOD 711>;
> +         resets = <&cpg 711>;
> +    };
> --
> 2.23.0
> 

