Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC6FC3276F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC3F24670
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 15:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgADPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 10:48:43 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40338 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgADPsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 10:48:43 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 41C8180613;
        Sat,  4 Jan 2020 16:48:40 +0100 (CET)
Date:   Sat, 4 Jan 2020 16:48:39 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     dri-devel@lists.freedesktop.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, maxime@cerno.tech,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: display: panel: Add binding document
 for Leadtek LTK500HD1829
Message-ID: <20200104154839.GG17768@ravnborg.org>
References: <20191224112641.30647-1-heiko@sntech.de>
 <20191224112641.30647-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224112641.30647-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=NXpJzYs8AAAA:8
        a=VwQbUJbxAAAA:8 a=gEfo2CItAAAA:8 a=mFv9uhqcPa-cGL3CgD8A:9
        a=CjuIK1q_8ugA:10 a=cwV61pgf2j4Cq8VD9hE_:22 a=AjGcO6oz07-iQ99wixmX:22
        a=sptkURWiP4Gy88Gu7hUp:22 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 12:26:40PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The LTK500HD1829 is a 5.0" 720x1280 DSI display.
> 
> changes in v2:
> - fix id (Maxime)
> - drop port (Maxime)
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Applied to drm-misc-next.
Updated example to pass dt_bindings_check while applying.
(Missing #address,size-celss properties)

	Sam


> ---
>  .../display/panel/leadtek,ltk500hd1829.yaml   | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
> new file mode 100644
> index 000000000000..123869533a5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/leadtek,ltk500hd1829.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Leadtek LTK500HD1829 5.0in 720x1280 DSI panel
> +
> +maintainers:
> +  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: leadtek,ltk500hd1829
> +  reg: true
> +  backlight: true
> +  reset-gpios: true
> +  iovcc-supply:
> +     description: regulator that supplies the iovcc voltage
> +  vcc-supply:
> +     description: regulator that supplies the vcc voltage
> +
> +required:
> +  - compatible
> +  - reg
> +  - backlight
> +  - iovcc-supply
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsi@ff450000 {
> +        panel@0 {
> +            compatible = "leadtek,ltk500hd1829";
> +            reg = <0>;
> +            backlight = <&backlight>;
> +            iovcc-supply = <&vcc_1v8>;
> +            vcc-supply = <&vcc_2v8>;
> +        };
> +    };
> +
> +...
> -- 
> 2.24.0
