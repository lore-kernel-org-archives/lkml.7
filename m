Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFB3C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE425218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553964226;
	bh=GlqX8+RZjomke+ZWzcX7VRr8X1ZDH8aS5tlfpZxB2U0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o/wqhHBwAekzLGH3o/s2qrD0IPFWB2BshvN+E3j671tTjZZbXcPzNXY8Qy5cvYtl+
	 0ZmRgmQ2gA+qwzFq7b+ys6fdEFpi/LBmMQFoM9f9W8LF00bKGNQcxLxZLIf65ReFXQ
	 Wuw/kjAdMlWPo/vEuLiPlPXB2c0xZ4WAwK7CgRVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfC3Qnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbfC3Qnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:43:45 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A63218D0;
        Sat, 30 Mar 2019 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553964224;
        bh=GlqX8+RZjomke+ZWzcX7VRr8X1ZDH8aS5tlfpZxB2U0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oyeFY+DMbevufMpQWvU5J2RZgabJBTYaeAUbfKik8903YnLuze5+0sYYU+BwmRUrC
         F8jmTgZJP0CadqIgxPA1MHiVI5IoC3byqh/4gK6sQPLI5MBX6xE7/NvuoJAgpNRXS6
         DKD4IpUJiVMdZV0IqU8EeAkvLuRY8Aj8MfatYS5k=
Date:   Sat, 30 Mar 2019 16:43:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] iio:temperature:max31856:Add device tree bind
 info
Message-ID: <20190330164338.620238b9@archlinux>
In-Reply-To: <20190326111842.12399-2-patrick.havelange@essensium.com>
References: <20190326111842.12399-1-patrick.havelange@essensium.com>
        <20190326111842.12399-2-patrick.havelange@essensium.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 12:18:41 +0100
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> 
> This patch added device tree binding info for MAX31856 driver.
> 
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes
> v1 -> v2
> [Matt
>  - Removed comment block and added possibilities of
>    thermocouple type in device tree binding doc.
> 
> v2 -> v3
>  - Rebased
> 
> v3 -> v4
>  - Removed one-shot property related information.
>  - Used standard name 'temp-sensor'
> 
> v4 -> v5
> [Patrick
>  - Rename thermocouple type to maxim,thermocouple-type for DT entry
> 
> v5 -> v6
> [Patrick
>  - use generic thermocouple-type for DT entry
> 
> v6 -> v7
> [Patrick
>  - None
> ---
>  .../bindings/iio/temperature/max31856.txt     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/max31856.txt b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> new file mode 100644
> index 000000000000..06ab43bb4de8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/max31856.txt
> @@ -0,0 +1,24 @@
> +Maxim MAX31856 thermocouple support
> +
> +https://datasheets.maximintegrated.com/en/ds/MAX31856.pdf
> +
> +Optional property:
> +	- thermocouple-type: Type of thermocouple (THERMOCOUPLE_TYPE_K if
> +		omitted). Supported types are B, E, J, K, N, R, S, T.
> +
> +Required properties:
> +	- compatible: must be "maxim,max31856"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: As per datasheet max. supported freq is 5000000
> +	- spi-cpha: must be defined for max31856 to enable SPI mode 1
> +
> +	Refer to spi/spi-bus.txt for generic SPI slave bindings.
> +
> + Example:
> +	temp-sensor@0 {
> +		compatible = "maxim,max31856";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +		spi-cpha;
> +		thermocouple-type = <THERMOCOUPLE_TYPE_K>;
> +	};

