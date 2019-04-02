Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EE3206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 12:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fvC9B68Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfDBM5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 08:57:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55044 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfDBM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 08:57:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32Cuuqe006919;
        Tue, 2 Apr 2019 07:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554209816;
        bh=zw8RfeR9DL3cFUqXxz+KFS09xU7hht+cflVWLrPiDCI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fvC9B68YPODUBW7M/79vrHu5RZm8UkthuxFZOuaiaDYvgdiIY61TKPs7vJ57bE7vd
         dBeOwXAaqMnkBVD97TcO9wFV+8srvRiHqPE3qclFE0I8E1gSD0aacdOf8q1PhgeNas
         wA7QkPxLyoNXMIsz9lJIFQknjrpNh8+kj2/J6wno=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32Cuue8096303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 07:56:56 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 07:56:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 07:56:56 -0500
Received: from [172.22.72.122] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32CutAA070466;
        Tue, 2 Apr 2019 07:56:55 -0500
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Brian Masney <masneyb@onstation.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
Date:   Tue, 2 Apr 2019 07:56:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401103034.21062-3-masneyb@onstation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On 4/1/19 5:30 AM, Brian Masney wrote:
> Add new backlight bindings for the TI LM3630A dual-string white LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../leds/backlight/lm3630a-backlight.yaml     | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..42a8c59d237a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3630A High-Efficiency Dual-String White LED
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Daniel Thompson <daniel.thompson@linaro.org>
> +  - Jingoo Han <jingoohan1@gmail.com>
> +
> +description: |
> +  The LM3630A is a current-mode boost converter which supplies the power and
> +  controls the current in up to two strings of 10 LEDs per string.
> +  https://www.ti.com/product/LM3630A
> +
> +properties:
> +  compatible:
> +    const: ti,lm3630a
> +
> +  reg:
> +    maxItems: 1
> +

No description on the reg here.  Assumed to be the i2c address?

> +  ti,linear-mapping-mode:
> +    description: |
> +      Enable linear mapping mode. If disabled, then it will use exponential
> +      mapping mode in which the ramp up/down appears to have a more uniform
> +      tranisiton to the human eye.

s/tranisiton/transition

> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^led*$":
> +    type: object
> +    description: |
> +      Properties for a string of connected LEDs.
> +

I have written a few of these drivers that have control bank support to control.  We have
been defining the reg property as the control bank id

reg 0 - Control bank A
reg 1 - Control bank B

Then use the led-sources to define what outputs are associated with which control bank.

This way the hardware can just have CB B enabled without CB A.

something like below would allow just control bank B to be enabled.

led@1 {
	reg = <1>;
	label = "main-lcd";
	default-brightness = <200>;
	max-brightness = <255>;
};

This would connect control bank B to control bank A.  Or just use a flag to denote to connect them
and not use led-sources.  But led-sources is the property of choice.

led@0 {
	reg = <0>;
	led-sources = < 0 1 >;
	label = "main-lcd";
	default-brightness = <200>;
	max-brightness = <255>;
};

And just the presence of 2 child nodes would indicate individual bank control
led@0 {
	reg = <0>;
	label = "main-lcd";
	default-brightness = <200>;
	max-brightness = <255>;
};

led@1 {
	reg = <1>;
	label = "main-keypad";
	default-brightness = <200>;
	max-brightness = <255>;
};

> +    properties:
> +      label:
> +        description: |
> +          The label for this LED. If omitted, the label is taken from the node
> +          name (excluding the unit address). It has to uniquely identify a
> +          device, i.e. no other LED class device can be assigned the same label.
> +
> +      led-sources:
> +        description: |
> +          List of device current outputs the LED is connected to.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              minimum: 0
> +              maximum: 1
> +

label and led-sources are already defined in the common.txt no need to redefine them here.

> +      default-brightness:
> +        description: Default brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +      max-brightness:
> +        description: Maximum brightness level on boot.

This is not the max brightness on boot.  This is the max brightness that is allowed during runtime.

Dan

> +        minimum: 0
> +        maximum: 255
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible = "ti,lm3630a";
> +                status = "ok";
> +                reg = <0x38>;
> +
> +                led {
> +                        label = "main-lcd";
> +                        led-sources = <0 1>;
> +                        default-brightness = <200>;
> +                        max-brightness = <255>;
> +                };
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible = "ti,lm3630a";
> +                status = "ok";
> +                reg = <0x38>;
> +
> +                led-bank-a {
> +                        led-sources = <0>;
> +                        default-brightness = <150>;
> +                        ti,linear-mapping-mode;
> +                };
> +
> +                led-bank-b {
> +                        led-sources = <1>;
> +                        default-brightness = <225>;
> +                        ti,linear-mapping-mode;
> +                };
> +        };
> +    };
> 


-- 
------------------
Dan Murphy
