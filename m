Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D44C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF58218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556069669;
	bh=q0AR+xmHRqNIkXPP4AddehGqwV7G2543yzfYGghtAqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=h/yOl7j7P6cA1mULwwZ9+HA7jGf747HNm3a0yrOIYoV5e3d0YswD58C8Mko9BJt9j
	 B0RCpREGd4pxwl/4Al7H2rHVCuLnx/IrElsa6+29J2y7L4BgT6JkAWO/l9HJ3tXGSE
	 WwJsIOHGHQLYMe4QFgqaySH8V00vgH5xlj75bXXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfDXBe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbfDXBe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:34:28 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF810218D2;
        Wed, 24 Apr 2019 01:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556069666;
        bh=q0AR+xmHRqNIkXPP4AddehGqwV7G2543yzfYGghtAqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lif1nmu86A5TXzEbCS2u7dDSnpkbIo/rPgx97nyY2UjEpLHh+7lwmqBVGCiCEOhmQ
         4KBL1XyrzHM1UiV9ni1N2FXyd7FxzlhtiyMJFCBGduVQfa6tIeeSplnrte5xSEYtGU
         ruX+goByjLLgDafvwjJkGElEmlGUWFlFRocWB+QQ=
Received: by mail-qt1-f174.google.com with SMTP id h16so8176354qtk.6;
        Tue, 23 Apr 2019 18:34:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUGPuKM8LbZud4JTmcTz1QQlvd/8Zsfn6U05fak/p6exynS6r4y
        xhv16V5qMa8bdlhJKf7sW9l7dlq82JqqOgKtRw==
X-Google-Smtp-Source: APXvYqzlOkwUOSjmcmV0KLs1GFv/OS3wfwjWvI9nTiU5U02Uf8Q1prWXKd/DnscglndF4vpeDBhfC/fu4sTBbXeuIzA=
X-Received: by 2002:a0c:d2f2:: with SMTP id x47mr23216877qvh.90.1556069665869;
 Tue, 23 Apr 2019 18:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190416084552.1538-1-masneyb@onstation.org> <20190422135238.27b9892d@archlinux>
In-Reply-To: <20190422135238.27b9892d@archlinux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Apr 2019 20:34:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJo4jA=_dLJ7QJ-LOhSYrXDAcVN01119do0a+y4odpFng@mail.gmail.com>
Message-ID: <CAL_JsqJo4jA=_dLJ7QJ-LOhSYrXDAcVN01119do0a+y4odpFng@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: tsl2772: convert bindings to YAML format
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 7:52 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 16 Apr 2019 04:45:51 -0400
> Brian Masney <masneyb@onstation.org> wrote:
>
> > Convert the tsl2772 device tree bindings to the new YAML format.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> Hi Brian,
>
> Good to see this.  I'm afraid it's all a bit new to me so what
> I haven't yet understood is how prescriptive we should be.
> For example, are the phandle references below needed or not?
>
> So for a while yet I'm going to be relying on Rob and others
> to review these and put me on the right track.
>
> Jonathan
>
> > ---
> >  .../devicetree/bindings/iio/light/tsl2772.txt | 42 ---------
> >  .../bindings/iio/light/tsl2772.yaml           | 85 +++++++++++++++++++
> >  2 files changed, 85 insertions(+), 42 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> >

> > diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> > new file mode 100644
> > index 000000000000..b3ac182288d2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> > @@ -0,0 +1,85 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

Do you have the rights on the original file to add BSD license?

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/tsl2772.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMS/TAOS Ambient Light Sensor (ALS) and Proximity Detector
> > +
> > +maintainers:
> > +  - Brian Masney <masneyb@onstation.org>
> > +
> > +description: |
> > +  Ambient light sensing and proximity detection with an i2c interface.
> > +  https://ams.com/documents/20143/36005/TSL2772_DS000181_2-00.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - amstaos,tsl2571
> > +      - amstaos,tsl2671
> > +      - amstaos,tmd2671
> > +      - amstaos,tsl2771
> > +      - amstaos,tmd2771
> > +      - amstaos,tsl2572
> > +      - amstaos,tsl2672
> > +      - amstaos,tmd2672
> > +      - amstaos,tsl2772
> > +      - amstaos,tmd2772
> > +      - avago,apds9930
> > +
> > +  reg:
> > +    description: The I2C address of the device

No need for description on common properties unless you have something
unique to add.

> > +    maxItems: 1
> > +
> > +  amstaos,proximity-diodes:
> > +    description: Proximity diodes to enable
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      - minItems: 1
> > +        maxItems: 2
> > +        items:
> > +          minimum: 0
> > +          maximum: 1
>
> Do we need to represent that these can't be <1 0> ?
> (specified in old docs)
> We also have a tighter spec than the uint32-array format in types.yaml
> as don't allow <0>, <1> under the current binding where only <0, 1> is
> allowed.

The uint32-array definition is loose to avoid lots of warnings on
common properties where we can't define the exact size. Over time we
need to tighten up the dts syntax to be consistent (I have a dtc patch
which can spew out lots of warnings to fix these).

So this case is correct. '<0, 1>' means a single array with 2
elements. '<0>, <1>' means 2 arrays each with a single element. There
shouldn't be lots of occurrences.

> > +
> > +  interrupts:
> > +    description: Interrupt generated by the device

No need for description.

> > +    maxItems: 1
> > +
> > +  led-max-microamp:
> > +    description: Current for the proximity LED

This device only has proximity LEDs, right?

> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [13000, 25000, 50000, 100000]

We should assume a common schema for 'led-max-microamp', so we just
need the enum.

> > +
> > +  vdd-supply:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Regulator that provides power to the sensor

Same here for '*-supply'. So just the description is enough.

> > +
> > +  vddio-supply:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Regulator that provides power to the bus
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        tsl2772@39 {

proximity-sensor@39

> > +                compatible = "amstaos,tsl2772";
> > +                reg = <0x39>;
> > +                interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> > +                vdd-supply = <&pm8941_l17>;
> > +                vddio-supply = <&pm8941_lvs1>;
> > +                amstaos,proximity-diodes = <0>;
> > +                led-max-microamp = <100000>;
> > +        };
> > +    };
> > +...
>
