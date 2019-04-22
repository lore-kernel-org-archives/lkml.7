Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD9FC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B0B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555937567;
	bh=el5Z1PfhoB/P6yOS7WEN7W06+yOjjEAa5i4h/mTQtww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KngPPNFW0mJG/vxjrC7kMjH6nj8hfeZmO0/62eLo561Tux3kboAX70mVI7Oz1+I/X
	 RhxdZZbvKZN0tryLBwprSIF+hj4SV1lrS4Pp2ZVlOrtpX0UPcp6qzPsV0D2QZd2nTR
	 b2l2iRTxUHf0gLyiGYVjWbQBpm1GiK7Ly27A8+lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfDVMwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfDVMwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 08:52:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABDF02077C;
        Mon, 22 Apr 2019 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555937564;
        bh=el5Z1PfhoB/P6yOS7WEN7W06+yOjjEAa5i4h/mTQtww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AcNMM4M66qUgHtlqbctGc1Rp2yuDobZXVJ16nG2BAavJxbqwWSSRv/9/pAFJ5vjfo
         qISpfJmjoa3fckAsFLijE+ge1o5pfgTdjpkxm9RWmE3Q8+SCqZHJ9tUrk0cyESoMZV
         ggEDwocCVKvjm4WvPN2yfVnBxcGw+tsAXVk8s7AM=
Date:   Mon, 22 Apr 2019 13:52:38 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robh+dt@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: tsl2772: convert bindings to YAML
 format
Message-ID: <20190422135238.27b9892d@archlinux>
In-Reply-To: <20190416084552.1538-1-masneyb@onstation.org>
References: <20190416084552.1538-1-masneyb@onstation.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 04:45:51 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Convert the tsl2772 device tree bindings to the new YAML format.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hi Brian,

Good to see this.  I'm afraid it's all a bit new to me so what
I haven't yet understood is how prescriptive we should be.
For example, are the phandle references below needed or not?

So for a while yet I'm going to be relying on Rob and others
to review these and put me on the right track.

Jonathan

> ---
>  .../devicetree/bindings/iio/light/tsl2772.txt | 42 ---------
>  .../bindings/iio/light/tsl2772.yaml           | 85 +++++++++++++++++++
>  2 files changed, 85 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.txt b/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> deleted file mode 100644
> index 1c5e6f17a1df..000000000000
> --- a/Documentation/devicetree/bindings/iio/light/tsl2772.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -* AMS/TAOS ALS and proximity sensor
> -
> -Required properties:
> -
> -  - compatible: Should be one of
> -		"amstaos,tsl2571"
> -		"amstaos,tsl2671"
> -		"amstaos,tmd2671"
> -		"amstaos,tsl2771"
> -		"amstaos,tmd2771"
> -		"amstaos,tsl2572"
> -		"amstaos,tsl2672"
> -		"amstaos,tmd2672"
> -		"amstaos,tsl2772"
> -		"amstaos,tmd2772"
> -		"avago,apds9930"
> -  - reg: the I2C address of the device
> -
> -Optional properties:
> -
> -  - amstaos,proximity-diodes - proximity diodes to enable. <0>, <1>, or <0 1>
> -                               are the only valid values.
> -  - led-max-microamp - current for the proximity LED. Must be 100000, 50000,
> -                       25000, or 13000.
> -  - vdd-supply: phandle to the regulator that provides power to the sensor.
> -  - vddio-supply: phandle to the regulator that provides power to the bus.
> -  - interrupts: the sole interrupt generated by the device
> -
> -  Refer to interrupt-controller/interrupts.txt for generic interrupt client
> -  node bindings.
> -
> -Example:
> -
> -tsl2772@39 {
> -	compatible = "amstaos,tsl2772";
> -	reg = <0x39>;
> -	interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> -	vdd-supply = <&pm8941_l17>;
> -	vddio-supply = <&pm8941_lvs1>;
> -	amstaos,proximity-diodes = <0>;
> -	led-max-microamp = <100000>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> new file mode 100644
> index 000000000000..b3ac182288d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/tsl2772.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS/TAOS Ambient Light Sensor (ALS) and Proximity Detector
> +
> +maintainers:
> +  - Brian Masney <masneyb@onstation.org>
> +
> +description: |
> +  Ambient light sensing and proximity detection with an i2c interface.
> +  https://ams.com/documents/20143/36005/TSL2772_DS000181_2-00.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - amstaos,tsl2571
> +      - amstaos,tsl2671
> +      - amstaos,tmd2671
> +      - amstaos,tsl2771
> +      - amstaos,tmd2771
> +      - amstaos,tsl2572
> +      - amstaos,tsl2672
> +      - amstaos,tmd2672
> +      - amstaos,tsl2772
> +      - amstaos,tmd2772
> +      - avago,apds9930
> +
> +  reg:
> +    description: The I2C address of the device
> +    maxItems: 1
> +
> +  amstaos,proximity-diodes:
> +    description: Proximity diodes to enable
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 2
> +        items:
> +          minimum: 0
> +          maximum: 1

Do we need to represent that these can't be <1 0> ?
(specified in old docs)
We also have a tighter spec than the uint32-array format in types.yaml
as don't allow <0>, <1> under the current binding where only <0, 1> is
allowed.

> +
> +  interrupts:
> +    description: Interrupt generated by the device
> +    maxItems: 1
> +
> +  led-max-microamp:
> +    description: Current for the proximity LED
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [13000, 25000, 50000, 100000]
> +
> +  vdd-supply:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Regulator that provides power to the bus
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        tsl2772@39 {
> +                compatible = "amstaos,tsl2772";
> +                reg = <0x39>;
> +                interrupts-extended = <&msmgpio 61 IRQ_TYPE_EDGE_FALLING>;
> +                vdd-supply = <&pm8941_l17>;
> +                vddio-supply = <&pm8941_lvs1>;
> +                amstaos,proximity-diodes = <0>;
> +                led-max-microamp = <100000>;
> +        };
> +    };
> +...

