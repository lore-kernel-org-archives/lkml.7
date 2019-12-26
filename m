Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D0C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B4C20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577398618;
	bh=0L9Nxw8tHUfaed+EVqY2W57qZcn4K0EBLoqMF4gfqKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GKaERTlfj5W5PkiFcQADwBC7gfkuoRdsu9bq7ijlcp36vYxQy044/eXECXEHx2vyF
	 YCITssSDYRZ/V6fpucdfVe0iI8KkruVwkd+NOSAE59oVP/fF7SsXGNhnnpk3M7vvPs
	 k+Bt1gTwtpK/mKvx2sF0NPXx9YUbefGyZFFEYTq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLZWQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:16:57 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35956 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:16:56 -0500
Received: by mail-il1-f195.google.com with SMTP id b15so21110038iln.3;
        Thu, 26 Dec 2019 14:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c1233G68iIMKSmTg8gExOV9G7MK88VcLTE787wpWiSI=;
        b=YQVNzr1ElbX2M6N/tVctS3XuaNZu1XUuIAJToMmfEPqsqgJZdqmxhxfne2FeCFv7Oy
         1uzTbTEQOc0LacB6cw3eKIxuR1Lg0TKlR/cBkWutAkY6L44W1C1jm8yMvIxC/xYKJo0J
         VWzRh+MGyklwL1+THKIEGP5K6ZZrKfd5BBM+CYREzgYxqkr9mKPrMs2Z/SP1Mjdjqwc3
         C65kthWHgWJ0idzUsI+GOr9zdeG4RAGgV3BUoureYH4Etyr8YQzbCnSi/tIoVhy3Ervx
         qyysiylbL0s6CdiJmxsEDuN0eqJeoQqppYDEk4R+P0DyKqjoqlVtJr8cu7v8AmnYlqnl
         f64A==
X-Gm-Message-State: APjAAAX3lfd5Ow8Uy+tDM0A9rVsbc43tIIVM9GjULOCCs2OaWya6DwCY
        s29DxBR+dcVBL5OH5eq+rw==
X-Google-Smtp-Source: APXvYqwrTHrpveC8FOrI/2ALsPbX+H1w5hN2bKpOogG2X5dEkCR+uqN65kpfSBmCcoD62bm8nJuq5w==
X-Received: by 2002:a92:5fd9:: with SMTP id i86mr16419441ill.304.1577398615734;
        Thu, 26 Dec 2019 14:16:55 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s10sm8826255ioc.4.2019.12.26.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:16:55 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:16:54 -0700
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bd718x7: Yamlify and add BD71850
Message-ID: <20191226221654.GA30474@bogus>
References: <20191217084824.GA26539@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217084824.GA26539@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:48:24AM +0200, Matti Vaittinen wrote:
> Convert ROHM bd71837 and bd71847 PMIC binding text docs to yaml. Split
> the binding document to two separate documents (own for BD71837 and BD71847)
> as they have different amount of regulators. This way we can better enforce
> the node name check for regulators. ROHM is also providing BD71850 - which
> is almost identical to BD71847 - main difference is some initial regulator
> states. The BD71850 can be driven by same driver and it has same buck/LDO
> setup as BD71847 - add it to BD71847 binding document and introduce
> compatible for it.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Oh dear how bad I am with yaml...

Looks pretty good overall.

I hope 'yamlify' doesn't catch on. :)


> 
> Lee, I think the support series for BD71828 included some changes
> to drivers/mfd/rohm-bd718x7.c - I will add BD71850 compatible to next
> version of that series in order to avoid conflicts. Does that work
> for you?
> 
>  .../bindings/mfd/rohm,bd71837-pmic.txt        |  90 --------
>  .../bindings/mfd/rohm,bd71837-pmic.yaml       | 198 ++++++++++++++++++
>  .../bindings/mfd/rohm,bd71847-pmic.yaml       | 181 ++++++++++++++++
>  .../regulator/rohm,bd71837-regulator.txt      | 162 --------------
>  .../regulator/rohm,bd71837-regulator.yaml     | 103 +++++++++
>  .../regulator/rohm,bd71847-regulator.yaml     |  97 +++++++++
>  6 files changed, 579 insertions(+), 252 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
>  delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml


> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> new file mode 100644
> index 000000000000..3a6d408aebbd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> @@ -0,0 +1,198 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/rohm,bd71837-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROHM BD71837 Power Management Integrated Circuit bindings
> +
> +maintainers:
> +  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +
> +description: |
> +  BD71837MWV is programmable Power Management ICs for powering single-core,
> +  dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for low
> +  BOM cost and compact solution footprint. BD71837MWV  integrates 8 Buck
> +  regulators and 7 LDOs.
> +  Datasheet for BD71837 is available at
> +  https://www.rohm.com/products/power-management/power-management-ic-for-system/industrial-consumer-applications/nxp-imx/bd71837amwv-product
> +
> +properties:
> +  compatible:
> +    const: rohm,bd71837
> +
> +  reg:
> +    description:
> +      I2C slave address.
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 0
> +
> +# The BD718x7 supports two different HW states as reset target states. States
> +# are called as SNVS and READY. At READY state all the PMIC power outputs go
> +# down and OTP is reload. At the SNVS state all other logic and external
> +# devices apart from the SNVS power domain are shut off. Please refer to NXP
> +# i.MX8 documentation for further information regarding SNVS state. When a
> +# reset is done via SNVS state the PMIC OTP data is not reload. This causes
> +# power outputs that have been under SW control to stay down when reset has
> +# switched power state to SNVS. If reset is done via READY state the power
> +# outputs will be returned to HW control by OTP loading. Thus the reset
> +# target state is set to READY by default. If SNVS state is used the boot
> +# crucial regulators must have the regulator-always-on and regulator-boot-on
> +# properties set in regulator node.
> +
> +  rohm,reset-snvs-powered:
> +    description: |
> +      Transfer PMIC to SNVS state at reset
> +    type: boolean
> +
> +# Configure the "short press" and "long press" timers for the power button.
> +# Values are rounded to what hardware supports (500ms multiple for short and
> +# 1000ms multiple for long). If these properties are not present the existing
> +# configuration (from bootloader or OTP) is not touched.

You can use 'multipleOf' keyword below for some constraints.

Same for the other file.

> +
> +  rohm,short-press-ms:
> +    description:
> +      Short press duration in milliseconds
> +
> +  rohm,long-press-ms:
> +    description:
> +      Long press duration in milliseconds
> +
> +  regulators:
> +    $ref: ../regulator/rohm,bd71837-regulator.yaml
> +    description:
> +      List of child nodes that specify the regulators.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - "#clock-cells"
> +  - regulators

additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/leds/common.h>
> +    #
> +
> +    i2c {
> +      pmic: pmic@4b {
> +            compatible = "rohm,bd71837";
> +            reg = <0x4b>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> +            #clock-cells = <0>;
> +            clocks = <&osc 0>;
> +            clock-output-names = "bd71837-32k-out";

Not documented.

> +            rohm,reset-snvs-powered;
> +
> +            regulators {
> +                buck1: BUCK1 {
> +                    regulator-name = "buck1";
> +                    regulator-min-microvolt = <700000>;
> +                    regulator-max-microvolt = <1300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                    regulator-ramp-delay = <1250>;
> +                    rohm,dvs-run-voltage = <900000>;
> +                    rohm,dvs-idle-voltage = <850000>;
> +                    rohm,dvs-suspend-voltage = <800000>;
> +                };
> +                buck2: BUCK2 {
> +                    regulator-name = "buck2";
> +                    regulator-min-microvolt = <700000>;
> +                    regulator-max-microvolt = <1300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                    regulator-ramp-delay = <1250>;
> +                    rohm,dvs-run-voltage = <1000000>;
> +                    rohm,dvs-idle-voltage = <900000>;
> +                };
> +                buck3: BUCK3 {
> +                    regulator-name = "buck3";
> +                    regulator-min-microvolt = <700000>;
> +                    regulator-max-microvolt = <1300000>;
> +                    regulator-boot-on;
> +                    rohm,dvs-run-voltage = <1000000>;
> +                };
> +                buck4: BUCK4 {
> +                    regulator-name = "buck4";
> +                    regulator-min-microvolt = <700000>;
> +                    regulator-max-microvolt = <1300000>;
> +                    regulator-boot-on;
> +                    rohm,dvs-run-voltage = <1000000>;
> +                };
> +                buck5: BUCK5 {
> +                    regulator-name = "buck5";
> +                    regulator-min-microvolt = <700000>;
> +                    regulator-max-microvolt = <1350000>;
> +                    regulator-boot-on;
> +                };
> +                buck6: BUCK6 {
> +                    regulator-name = "buck6";
> +                    regulator-min-microvolt = <3000000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                };
> +                buck7: BUCK7 {
> +                    regulator-name = "buck7";
> +                    regulator-min-microvolt = <1605000>;
> +                    regulator-max-microvolt = <1995000>;
> +                    regulator-boot-on;
> +                };
> +                buck8: BUCK8 {
> +                    regulator-name = "buck8";
> +                    regulator-min-microvolt = <800000>;
> +                    regulator-max-microvolt = <1400000>;
> +                };
> +
> +                ldo1: LDO1 {
> +                    regulator-name = "ldo1";
> +                    regulator-min-microvolt = <3000000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                };
> +                ldo2: LDO2 {
> +                    regulator-name = "ldo2";
> +                    regulator-min-microvolt = <900000>;
> +                    regulator-max-microvolt = <900000>;
> +                    regulator-boot-on;
> +                };
> +                ldo3: LDO3 {
> +                    regulator-name = "ldo3";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                ldo4: LDO4 {
> +                    regulator-name = "ldo4";
> +                    regulator-min-microvolt = <900000>;
> +                    regulator-max-microvolt = <1800000>;
> +                };
> +                ldo5: LDO5 {
> +                    regulator-name = "ldo5";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +                ldo6: LDO6 {
> +                    regulator-name = "ldo6";
> +                    regulator-min-microvolt = <900000>;
> +                    regulator-max-microvolt = <1800000>;
> +                };
> +                ldo7_reg: LDO7 {
> +                    regulator-name = "ldo7";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                };
> +            };
> +        };
> +    };
