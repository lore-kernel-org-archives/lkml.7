Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9D3C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E281F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ndBhnS1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfDOMK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:10:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfDOMKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:10:24 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3FCA6Cb010283;
        Mon, 15 Apr 2019 07:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555330206;
        bh=nh8tiFsg+r61BkbikI3Ou2Ia9voB3uRJcWOV22GdB+o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ndBhnS1a94+Ci9xqjM+Cqum8jKDX8Yy3jw/eaqfhOgqTQ/ZkuUo5i4atgRLzVrY2z
         Mbqbtx3kWKdMWvL8Jd0nE8q8WIKtwo6vj2++V+2XJkMRx+wO5P7EakIT9fHZrUtgt7
         sJPi1X/TokHaoMGfHmKZO0iYUIAJ+hXQs801fs90=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3FCA6cZ100057
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Apr 2019 07:10:06 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 15
 Apr 2019 07:10:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 15 Apr 2019 07:10:06 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3FCA5MR007139;
        Mon, 15 Apr 2019 07:10:05 -0500
Subject: Re: [PATCH v3 2/3] dt-bindings: backlight: add lm3630a bindings
To:     Brian Masney <masneyb@onstation.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <robh+dt@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mark.rutland@arm.com>, <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <jonathan@marek.ca>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-3-masneyb@onstation.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <051b5306-9dab-6249-9e41-b815dce1f2e2@ti.com>
Date:   Mon, 15 Apr 2019 07:10:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415072905.2861-3-masneyb@onstation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian
On 4/15/19 2:29 AM, Brian Masney wrote:
> Add new backlight bindings for the TI LM3630A dual-string white LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Rob: Since the common bindings aren't converted to the new JSON schema
> yet, I'm not sure how to do led-sources here. I would expect that we'd
> have the uint32-array on the common binding once it exists. I had to
> add it here to keep 'make dt_binding_check' happy. I left the
> description off though for that property since that'll come from common
> once its converted.
> 
> Changes since v2:
> - Update description of max-brightness
> - Add description for reg
> - Correct typo: s/tranisiton/transition
> - Remove label from bindings since this isn't on backlight_properties
> - add reg to control banks
> - add additionalProperties
> 
>  .../leds/backlight/lm3630a-backlight.yaml     | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..cccd43c02732
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -0,0 +1,124 @@
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
> +    description: The I2C address of the device
> +    maxItems: 1
> +
> +  ti,linear-mapping-mode:
> +    description: |
> +      Enable linear mapping mode. If disabled, then it will use exponential
> +      mapping mode in which the ramp up/down appears to have a more uniform
> +      transition to the human eye.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^led@[01]$":
> +    type: object
> +    description: |
> +      Properties for a string of connected LEDs.
> +
> +    properties:
> +      reg:
> +        description: Control Bank
> +        maxItems: 1
> +        minimum: 0
> +        maximum: 1
> +
> +      led-sources:
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              minimum: 0
> +              maximum: 1
> +
> +      default-brightness:
> +        description: Default brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +      max-brightness:
> +        description: Maximum brightness that is allowed during runtime.
> +        minimum: 0
> +        maximum: 255
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
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
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                        reg = <0>;
> +                        led-sources = <0 1>;
> +                        default-brightness = <200>;
> +                        max-brightness = <255>;
> +                };
> +        };
> +    };
> +  - |

I noticed we are missing "label".  It is defined as optional and it is hard coded in the driver
but wondering if there is a need to add it.


Dan
<snip>
