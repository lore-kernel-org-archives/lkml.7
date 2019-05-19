Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D65C072AD
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2823204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558286847;
	bh=T3PsiJ+c9i291nIGZ2UJklxfGuIhW4xPOj6zpxSXP3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gOHSH8Qkb9bS3CBaOZ5s7zUZ0n9UxXT3AhF6CNwkZ7ElEZLjZ4pJnNnx9SRkUiwfW
	 r36S4p7pJHol6w/JMz2LhLoAYZgghrBeJeMxsZZLVvaRoaDh0PRJvS7TdOgRm3SQPE
	 tk514jf1a++L6cOp32tKue3XqVu9YQhESbUkUMss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfESR11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfESR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:27:22 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EDB12183F;
        Sun, 19 May 2019 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558265389;
        bh=T3PsiJ+c9i291nIGZ2UJklxfGuIhW4xPOj6zpxSXP3s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SZOgNiRVAUi0n9HlyMsrDYDcQ3GAuk80VbWExE/h+pnvz0yHO14J3nxnpmPoXux9o
         SwwtR9H1InRvEE1LyD1kj+mqGirUYxqkvByp+aVg1axkPWRs7wogGN6QjDuJAMMcOv
         99eYUDktqKFKO76p/eO840BFIIHVu3jxj++2hBj8=
Date:   Sun, 19 May 2019 12:29:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?Sm/Do28=?= Victor Marques de Oliveira 
        <joao.marques.oliveira@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        "Thiago L . A . Miller" <tmiller@mochsl.org.br>,
        "Osvaldo M . Yasuda" <omyasuda@yahoo.com.br>
Subject: Re: [PATCH] dt-bindings: iio: ad7949: switch binding to yaml
Message-ID: <20190519122944.3326e803@archlinux>
In-Reply-To: <20190518224036.29596-1-joao.marques.oliveira@usp.br>
References: <20190518224036.29596-1-joao.marques.oliveira@usp.br>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2019 19:40:36 -0300
Jo=C3=A3o Victor Marques de Oliveira         <joao.marques.oliveira@usp.br>=
 wrote:

> Changes switches from old text bindings, to YAML bindings, and also
> include adi,reference-select property to specify the source for the
> reference voltage signal.
>=20
> Signed-off-by: Jo=C3=A3o Victor Marques de Oliveira <joao.marques.oliveir=
a@usp.br>
> Signed-off-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
> Co-developed-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
> Signed-off-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> Co-developed-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> ---
> We're adding Charles-Antoine Couret as main dt maintainer since we have
> just switched documentation to yaml format.=20

Hmm. I'm not sure it makes sense to list you all as maintainers
of this rather simple binding.

We also just went through some changes on the reference handling so
I think you are based on stale information here.

Thanks,

Jonathan

>=20
>  .../devicetree/bindings/iio/adc/ad7949.txt    | 16 -----
>  .../devicetree/bindings/iio/adc/ad7949.yaml   | 71 +++++++++++++++++++
>  2 files changed, 71 insertions(+), 16 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Docum=
entation/devicetree/bindings/iio/adc/ad7949.txt
> deleted file mode 100644
> index c7f5057356b1..000000000000
> --- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -* Analog Devices AD7949/AD7682/AD7689
> -
> -Required properties:
> - - compatible: Should be one of
> -	* "adi,ad7949"
> -	* "adi,ad7682"
> -	* "adi,ad7689"
> - - reg: spi chip select number for the device
> - - vref-supply: The regulator supply for ADC reference voltage
> -
> -Example:
> -adc@0 {
> -	compatible =3D "adi,ad7949";
> -	reg =3D <0>;
> -	vref-supply =3D <&vdd_supply>;
> -};
> diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.yaml b/Docu=
mentation/devicetree/bindings/iio/adc/ad7949.yaml
> new file mode 100644
> index 000000000000..111c9e26f8e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ad7949.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ad7949.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +
> +title: Analog Devices AD7949/AD7682/AD7689
> +
> +maintainers:
> +  - Charles-Antoine Couret <charles-antoine.couret@essensium.com>
> +  - Jo=C3=A3o Victor Marques de Oliveira <joao.marques.oliveira@usp.br>
> +  - Thiago L. A. Miller <tmiller@mochsl.org.br>
> +  - Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7949
> +      - adi,ad7682
> +      - adi,ad7689
> +
> +  reg: =20
> +    description:
> +      spi chip select number for the device
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      The regulator supply for ADC reference voltage
> +    maxItems: 1
> +
> +  adi,reference-select:
> +    enum: [0, 1, 2, 3, 6, 7]
> +    description:
> +        Select the reference voltage source to use when converting the i=
nput voltages.
> +            0 - Internal 2.5V reference; temperature sensor enabled
> +            1 - Internal 4.096V reference; temperature sensor enabled
> +            2 - External reference, temperature sensor enabled, no buffer
> +            3 - External reference, temperature sensor enabled, buffer e=
nabled
> +            6 - External reference, temperature sensor disabled, no buff=
er
> +            7 - External reference, temperature sensor disabled, buffer =
enabled
This is changing...

> +    maxItems: 1
> +
> +required:
> +  - compatible=20
> +  - reg
> +  - vref-supply
> +
> +examples:
> +  - |
> +    spi0 {
> +        #address-cells =3D <0x1>;
> +        #size-cells =3D <0x0>;
> +        adc@0 {
> +            compatible =3D "adi,ad7949";
> +            reg =3D <0>;
> +            adi,reference-select =3D <0>;
> +            vref-supply =3D <&vdd_supply>;
> +        };
> +    };
> +  - |
> +    spi0 {
> +        #address-cells =3D <0x1>;
> +        #size-cells =3D <0x0>;
> +        adc@0 {
> +            compatible =3D "adi,ad7949";
> +            reg =3D <0>;
> +            adi,reference-select =3D <0>;
> +        };
> +    };

