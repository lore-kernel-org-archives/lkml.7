Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C32BC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431F420866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551617677;
	bh=QY/xf8iR2RiXz4DvzpG44suuZ9B6rYUhcfgGhNXLrIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2bIfWjW4UN9rN6XRYAptGrG2Qv1m8jXiEljw9rzwqhui4zGWFzP4QahoI+gpAhsO7
	 d1W6YrB9W8HhQZxDn5H8exGaj0M+Po2XIL7+zeXUQTDH1oi8ySIa5fCPHNPTrR6Qz9
	 0aTRpA5Zh+kseDIzF4SjLbF551+aBgHSKmVneSCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCCMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:54:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCCMyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:54:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660ED20857;
        Sun,  3 Mar 2019 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551617674;
        bh=QY/xf8iR2RiXz4DvzpG44suuZ9B6rYUhcfgGhNXLrIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=djTHR53GpqA0PnjXzko0FFS+/0NYkGe5JCAwTQ7JrgV+7VFJsYiEXXgAIXhjHVndd
         TXKa+Uz2X1MVg+u1RmBy6GZyXgSAizwSwrzZa2jqX4FvWaCpJh9YOk1h04HyQHnyxc
         uLtt7v2W5oqzV7mdHOj9zqrby1hN67lkbNC4INBY=
Date:   Sun, 3 Mar 2019 12:54:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] iio: imu: adis16480: Add docs for ADIS16480 IMU
Message-ID: <20190303125429.3f2c7d70@archlinux>
In-Reply-To: <1551284068-4882-8-git-send-email-stefan.popa@analog.com>
References: <1551284068-4882-1-git-send-email-stefan.popa@analog.com>
        <1551284068-4882-8-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 18:14:28 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Document support for ADIS16480 Inertial Measurement Unit.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Applied.

Thanks,

Jonathan

> ---
>  .../devicetree/bindings/iio/imu/adi,adis16480.txt  | 49 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> new file mode 100644
> index 0000000..39ab016
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
> @@ -0,0 +1,49 @@
> +
> +Analog Devices ADIS16480 and similar IMUs
> +
> +Required properties for the ADIS16480:
> +
> +- compatible: Must be one of
> +	* "adi,adis16375"
> +	* "adi,adis16480"
> +	* "adi,adis16485"
> +	* "adi,adis16488"
> +	* "adi,adis16495-1"
> +	* "adi,adis16495-2"
> +	* "adi,adis16495-3"
> +	* "adi,adis16497-1"
> +	* "adi,adis16497-2"
> +	* "adi,adis16497-3"
> +- reg: SPI chip select number for the device
> +- spi-max-frequency: Max SPI frequency to use
> +	see: Documentation/devicetree/bindings/spi/spi-bus.txt
> +- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
> +- spi-cpol: See Documentation/devicetree/bindings/spi/spi-bus.txt
> +- interrupts: interrupt mapping for IRQ, accepted values are:
> +	* IRQF_TRIGGER_RISING
> +	* IRQF_TRIGGER_FALLING
> +
> +Optional properties:
> +
> +- interrupt-names: Data ready line selection. Valid values are:
> +	* DIO1
> +	* DIO2
> +	* DIO3
> +	* DIO4
> +	If this field is left empty, DIO1 is assigned as default data ready
> +	signal.
> +- reset-gpios: must be the device tree identifier of the RESET pin. As the line
> +	is active low, it should be marked GPIO_ACTIVE_LOW.
> +
> +Example:
> +
> +	imu@0 {
> +		compatible = "adi,adis16495-1";
> +		reg = <0>;
> +		spi-max-frequency = <3200000>;
> +		spi-cpol;
> +		spi-cpha;
> +		interrupts = <25 IRQF_TRIGGER_FALLING>;
> +		interrupt-parent = <&gpio>;
> +		interrupt-names = "DIO2";
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e4091ac..beecd1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -942,6 +942,7 @@ F:	drivers/dma/dma-axi-dmac.c
>  ANALOG DEVICES INC IIO DRIVERS
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +M:	Stefan Popa <stefan.popa@analog.com>
>  W:	http://wiki.analog.com/
>  W:	http://ez.analog.com/community/linux-device-drivers
>  S:	Supported

