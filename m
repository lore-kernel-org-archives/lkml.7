Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EF320823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553605110;
	bh=jkPL84ue2AseSFDDn3sETNJ+7t0GUkREXhNb9O60bpA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pXaI9/A6oEHZV7XEMygZij3M5V09UQOUiYKyxsXQuBCGO1qOr9oxlzO/ca/hNTeEG
	 v3w0ZfRU1a5X5o+3z+c2rRi7eoP/GD8Fpl8RCj7NJ0dmquKzzbDxudJRemFutiKkpH
	 n+po8ofc+QpIRYGeyvVngJeLDyJ2DwZhiHDwXaEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfCZM63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbfCZM63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:58:29 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8CE20879;
        Tue, 26 Mar 2019 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553605108;
        bh=jkPL84ue2AseSFDDn3sETNJ+7t0GUkREXhNb9O60bpA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uJmjm5IoZJwmOtH1IkLK9wTcIXcM6z7+MlsGydjQir1lkzqWTiWnaWPypPst/vz6k
         F+/l2FuQTEv1VfaHHDZOfGux4YrSafawhjNQKQdRr8XxsSshO2+EBerjCCw266XRLL
         Zksa/grSBvy/7DXM1HX0qY0i76fme256mvyUg6Dc=
Received: by mail-qk1-f169.google.com with SMTP id o129so7487428qke.8;
        Tue, 26 Mar 2019 05:58:27 -0700 (PDT)
X-Gm-Message-State: APjAAAWhzdC4xrSKbye/VN1F+IgZ7STsq275P7iF+deyNbu90SR3lVru
        GSqQNw5Is4B2dnVEALucuupuW+Wm5xdX8fxj2Q==
X-Google-Smtp-Source: APXvYqzdyw1vrow8jR1Tqk8fXJvXa6GqNK+tJO2xlvS9DnX5cczRaGDHhefLAsodVy6x/WQgLR2E6RVF6nK+WQ0BgLc=
X-Received: by 2002:a37:4a12:: with SMTP id x18mr23396589qka.184.1553605107103;
 Tue, 26 Mar 2019 05:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190326123121.ibe3olu3yxptauws@arbad>
In-Reply-To: <20190326123121.ibe3olu3yxptauws@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Mar 2019 07:58:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6TAqZgqWGvdA4aaEPiZeBxug4gV6mwZoUOHB1mSZzFw@mail.gmail.com>
Message-ID: <CAL_JsqK6TAqZgqWGvdA4aaEPiZeBxug4gV6mwZoUOHB1mSZzFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] devantech-srf04.yaml: transform DT binding to YAML
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 7:31 AM Andreas Klinger <ak@it-klinger.de> wrote:
>
> use devantech-srf04.txt and transform binding into yaml

I'd just collapse these into 1 patch.

>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/devantech-srf04.yaml    | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> new file mode 100644
> index 000000000000..cd065393b062
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/devantech-srf04.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Devantech SRF04 ultrasonic range finder
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Bit-banging driver using two GPIOs:
> +  - trigger-gpio is raised by the driver to start sending out an ultrasonic
> +    burst
> +  - echo-gpio is held high by the sensor after sending ultrasonic burst
> +    until it is received once again
> +
> +  Specifications about the driver can be found at:
> +  http://www.robot-electronics.co.uk/htm/srf04tech.htm
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#

This doesn't belong. It's not a I2C bus controller.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: devantech,srf04
> +
> +  trig-gpios:
> +    description:
> +      Definition of the GPIO for the triggering (output) This GPIO is set
> +      for about 10 us by the driver to tell the device it should initiate
> +      the measurement cycle.
> +    maxItems: 1
> +
> +  echo-gpios:
> +    description:
> +      Definition of the GPIO for the echo (input)
> +      This GPIO is set by the device as soon as an ultrasonic burst is sent
> +      out and reset when the first echo is received.
> +      Thus this GPIO is set while the ultrasonic waves are doing one round
> +      trip.
> +      It needs to be an GPIO which is able to deliver an interrupt because
> +      the time between two interrupts is measured in the driver.
> +      See Documentation/devicetree/bindings/gpio/gpio.txt for information
> +      on how to specify a consumer gpio.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - trig-gpios
> +  - echo-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    proximity {
> +        compatible = "devantech,srf04";
> +        trig-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +        echo-gpios = <&gpio2  6 GPIO_ACTIVE_HIGH>;
> +    };
> --
> 2.11.0
