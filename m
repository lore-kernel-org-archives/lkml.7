Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD43C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E6A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554099452;
	bh=qAxsK83Y1E8BjJeMAKQuophDBP/wZFhiTPSMxBrviBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mqlOqyuV0H6XdN1R9jcrGmr+7AgtBEn+A8+0y1FuSXZQP3CAB/h8sHtswacldV+q2
	 BbG2pPQA3Xv4K7eL9cmrqAOtS9JX4m9CN6ALjkf6Gemck8Wy5zoBf8kOPfdKdGxxYz
	 BJtgEdTYkRi/jCXlJs1jFzBkiXDn9TKQipse1CuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfDAGRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfDAGRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:17:30 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E5520896;
        Mon,  1 Apr 2019 06:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554099449;
        bh=qAxsK83Y1E8BjJeMAKQuophDBP/wZFhiTPSMxBrviBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SfxMmEZNQNoX+06pp66GrG5dw838/zsOmLP83bFOt4qnkjZx75B1fb4hH/3ra5WUR
         BwpXFw1ttdy78ziDlyO9jfRpCbnq1A7hMMtu18uBG8c0r1htdmDw1dM1EfiSwOVCB0
         JAQuFqLJG5rPbKo12pr+eh/pN4ZNA189wVpSXSnA=
Received: by mail-qt1-f174.google.com with SMTP id z16so9496321qtn.4;
        Sun, 31 Mar 2019 23:17:28 -0700 (PDT)
X-Gm-Message-State: APjAAAXslC+jv9CcxgE5d4i2BC8R6uD02541akvvEk5JZ2eqNlH04/+W
        fKGCQmP2p5U0Cw5kv5nzAGCNqlFwSsLu8Mlt2g==
X-Google-Smtp-Source: APXvYqxeeYo6Cmd+D0paXHCY6OGLFuvNxYN7v0qdPyDO/7InSYef8iOe5yGB0KdF6alvXQM88Cqy4doEJV3IvW8d4ls=
X-Received: by 2002:aed:35b0:: with SMTP id c45mr52888123qte.144.1554099448033;
 Sun, 31 Mar 2019 23:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190331164753.xifw6kkiwdg4xpzo@arbad>
In-Reply-To: <20190331164753.xifw6kkiwdg4xpzo@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Apr 2019 01:17:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJuu1hgmRm0Vom4Q8aXFXBJoReTzGz6UEv6bQ+QHnQLtQ@mail.gmail.com>
Message-ID: <CAL_JsqJuu1hgmRm0Vom4Q8aXFXBJoReTzGz6UEv6bQ+QHnQLtQ@mail.gmail.com>
Subject: Re: [PATCH] bmp085.yaml: transform DT documentation of iio sensor
 into YAML
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:48 AM Andreas Klinger <ak@it-klinger.de> wrote:
>
> use bmp085.txt and change it into yaml format
>
> fix links to datasheets in replaced documentation
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../devicetree/bindings/iio/pressure/bmp085.txt    | 27 --------
>  .../devicetree/bindings/iio/pressure/bmp085.yaml   | 71 ++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
>
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> deleted file mode 100644
> index 61c72e63c584..000000000000
> --- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -BMP085/BMP18x/BMP28x digital pressure sensors
> -
> -Required properties:
> -- compatible: must be one of:
> -  "bosch,bmp085"
> -  "bosch,bmp180"
> -  "bosch,bmp280"
> -  "bosch,bme280"
> -
> -Optional properties:
> -- interrupts: interrupt mapping for IRQ
> -- reset-gpios: a GPIO line handling reset of the sensor: as the line is
> -  active low, it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)
> -- vddd-supply: digital voltage regulator (see regulator/regulator.txt)
> -- vdda-supply: analog voltage regulator (see regulator/regulator.txt)
> -
> -Example:
> -
> -pressure@77 {
> -       compatible = "bosch,bmp085";
> -       reg = <0x77>;
> -       interrupt-parent = <&gpio0>;
> -       interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> -       reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
> -       vddd-supply = <&foo>;
> -       vdda-supply = <&bar>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> new file mode 100644
> index 000000000000..884f889c1ca5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/bmp085.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: BMP085/BMP180/BMP280/BME280 pressure iio sensors
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Pressure, temperature and humidity iio sensors with i2c and spi interfaces
> +
> +  Specifications about the sensor can be found at:
> +    https://www.bosch-sensortec.com/bst/products/all_products/bmp180
> +    https://www.bosch-sensortec.com/bst/products/all_products/bmp280
> +    https://www.bosch-sensortec.com/bst/products/all_products/bme280
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - bosch,bmp085
> +          - bosch,bmp180
> +          - bosch,bmp280
> +          - bosch,bme280

This too can be just:

compatible:
  enum:
    - bosch,bmp085
    - bosch,bmp180
    - bosch,bmp280
    - bosch,bme280

> +  vddd-supply:
> +    description:
> +      digital voltage regulator (see regulator/regulator.txt)
> +    maxItems: 1
> +
> +  vdda-supply:
> +    description:
> +      analog voltage regulator (see regulator/regulator.txt)
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      A GPIO line handling reset of the sensor. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW (see gpio/gpio.txt)
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt mapping for IRQ (BMP085 only)

Needs a 'maxItems: 1'

> +
> +required:
> +  - compatible
> +  - vddd-supply
> +  - vdda-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pressure@77 {
> +          compatible = "bosch,bmp085";
> +          reg = <0x77>;
> +          interrupt-parent = <&gpio0>;
> +          interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +          reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
> +          vddd-supply = <&foo>;
> +          vdda-supply = <&bar>;
> +      };
> +    };
> --
> 2.11.0
