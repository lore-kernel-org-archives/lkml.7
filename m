Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46D4C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99EC218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552760495;
	bh=c6VJW+smZumq8wLrdBrZiIka9l2DsDsfTxrfnhkMjkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WHd3z2zBGThurc/tyhjFUtcmLAfLOSIRHX9KnxoNknYcTC17uK60qYcvVY/YjTGjT
	 hCjYVDp9t0GBad30LyJPBoVcYeiRYMEMP4vN0BwxhGV4RFT4vhwOqLdkD3DmE7A5cE
	 hXRgapC7AvA40333+hxhXrXHrudYlbow9491Ms5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCPSVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPSVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:21:34 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EED4218FC;
        Sat, 16 Mar 2019 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552760492;
        bh=c6VJW+smZumq8wLrdBrZiIka9l2DsDsfTxrfnhkMjkQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fC/U2M7EDVKNHBQxmTS4RzPU3tn9x17ySy+XZEg1wManhemvj2Lii3BiGdOWx74ew
         WqRTUcnHTHbUWF6y6SqgLBA18W1bRkxJ8W5xSLk15nIFcfxLgRTG/ByXQ2tpJ4g11B
         lGkyOB5VDJ/VDJjs11tt67PGAYvdQBw2LCjrAmxw=
Date:   Sat, 16 Mar 2019 18:21:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 11/11] staging: iio: ad7780: add device tree binding
Message-ID: <20190316182125.5ba5d5fe@archlinux>
In-Reply-To: <fce522fbe69b6d5ab8f06c70d18cf097f256711c.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <fce522fbe69b6d5ab8f06c70d18cf097f256711c.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:16:13 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Adds a device tree binding for the ad7780 driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Seems like a straight forward binding so applied to the togreg branch
of iio.git and pushed out as testing for the autobuilders to play with it.

Thanks,
Jonathan

> ---
>  .../bindings/iio/adc/adi,ad7780.txt           | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> new file mode 100644
> index 000000000000..440e52555349
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
> @@ -0,0 +1,48 @@
> +* Analog Devices AD7170/AD7171/AD7780/AD7781
> +
> +Data sheets:
> +
> +- AD7170:
> +	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7170.pdf
> +- AD7171:
> +	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7171.pdf
> +- AD7780:
> +	* https://www.analog.com/media/en/technical-documentation/data-sheets/ad7780.pdf
> +- AD7781:
> +	* https://www.analog.com/media/en/technical-documentation/data-sheets/AD7781.pdf
> +
> +Required properties:
> +
> +- compatible: should be one of
> +	* "adi,ad7170"
> +	* "adi,ad7171"
> +	* "adi,ad7780"
> +	* "adi,ad7781"
> +- reg: spi chip select number for the device
> +- vref-supply: the regulator supply for the ADC reference voltage
> +
> +Optional properties:
> +
> +- powerdown-gpios:  must be the device tree identifier of the PDRST pin. If
> +		    specified, it will be asserted during driver probe. As the
> +		    line is active high, it should be marked GPIO_ACTIVE_HIGH.
> +- adi,gain-gpios:   must be the device tree identifier of the GAIN pin. Only for
> +		    the ad778x chips. If specified, it will be asserted during
> +		    driver probe. As the line is active low, it should be marked
> +		    GPIO_ACTIVE_LOW.
> +- adi,filter-gpios: must be the device tree identifier of the FILTER pin. Only
> +		    for the ad778x chips. If specified, it will be asserted
> +		    during driver probe. As the line is active low, it should be
> +		    marked GPIO_ACTIVE_LOW.
> +
> +Example:
> +
> +adc@0 {
> +	compatible =  "adi,ad7780";
> +	reg =	      <0>;
> +	vref-supply = <&vdd_supply>
> +
> +	powerdown-gpios  = <&gpio 12 GPIO_ACTIVE_HIGH>;
> +	adi,gain-gpios   = <&gpio  5 GPIO_ACTIVE_LOW>;
> +	adi,filter-gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
> +};

