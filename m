Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC418C2D0C5
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08C12073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 07:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbfLNHyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 02:54:16 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:60306 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfLNHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 02:54:16 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 495CB804FD;
        Sat, 14 Dec 2019 08:54:13 +0100 (CET)
Date:   Sat, 14 Dec 2019 08:54:12 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     thierry.reding@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 2/3] dt-bindings: display: panel: Add binding document
 for Xinpeng XPP055C272
Message-ID: <20191214075412.GB22818@ravnborg.org>
References: <20191209144208.4863-1-heiko@sntech.de>
 <20191209144208.4863-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209144208.4863-2-heiko@sntech.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=NXpJzYs8AAAA:8
        a=gEfo2CItAAAA:8 a=7gkXJVJtAAAA:8 a=kqpNkawWe9FrIPx1R8MA:9
        a=CjuIK1q_8ugA:10 a=cwV61pgf2j4Cq8VD9hE_:22 a=sptkURWiP4Gy88Gu7hUp:22
        a=E9Po1WZjFZOl8hwRPBS3:22 a=pHzHmUro8NiASowvMSCR:22
        a=6VlIyEUom7LUIeUMNQJH:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko.


On Mon, Dec 09, 2019 at 03:42:07PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> 
> The XPP055C272 is a 5.5" 720x1280 DSI display.
Can we get the size info included in the title in the binding?
Then all relavant info is in the binding, and no git digging is needed.

> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> ---
>  .../display/panel/xinpeng,xpp055c272.yaml     | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> new file mode 100644
> index 000000000000..4515d44d189b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/sony,acx424akp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xinpeng XPP055C272 720x1280 DSI panel
> +
> +maintainers:
> +  - Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: xinpeng,xpp055c272
> +  reg: true
> +  backlight: true
> +  port: true
> +  reset-gpios: true
> +  iovcc-supply:
> +     description: regulator that supplies the iovcc voltage
> +  vci-supply:
> +     description: regulator that supplies the vci voltage
> +
> +required:
> +  - compatible
> +  - reg
One would assume the display also required power to operate.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dsi@ff450000 {
> +        panel@0 {
> +            compatible = "xinpeng,xpp055c272";
> +            reg = <0>;
> +            backlight = <&backlight>;
> +            iovcc-supply = <&vcc_1v8>;
> +            vci-supply = <&vcc3v3_lcd>;
> +        };
> +    };
> +
> +...

With the few things mentioned above fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
