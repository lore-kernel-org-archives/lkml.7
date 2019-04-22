Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4AFC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2AE92087E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555929288;
	bh=YNsexiBG78n5sLUZEj12x9nYdJWuV2dQ6xZ01xqKp6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y150WdP8xEVj6RpvS2UFxx9MSf4QeNIe9T/WubYHXCHUcTXhRrDIGpjuc8W67N2Z6
	 +m8z+uLaT6Kl613pjz2nDN4jB67q1brS2Io+4rcGpChK+e+/O+96yy1MkiiZIiX9vd
	 QEPAzMnNm2xalBMuJlc2l5wGULKXOXq+8aUNX4ZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfDVKes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfDVKer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:34:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6572075A;
        Mon, 22 Apr 2019 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555929286;
        bh=YNsexiBG78n5sLUZEj12x9nYdJWuV2dQ6xZ01xqKp6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mOJDl9J7ag9QTGedD8fFgIpfdnhdzYHw+KRIAtGcyWsa0ZosXpXs1k8XgIvBiv4UY
         9Rc1zcBjacLyQz+7srp4R9KQ/qxm71QVAg+bemnVabFHeflMdnteckAbIPND/N33Y9
         GBT7h7KGEX8weHqucLv83WqrME7XkceSPO0nmZkQ=
Date:   Mon, 22 Apr 2019 11:34:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: imx7d_adc: Add local struct device pointer
 in imx7d_adc_probe()
Message-ID: <20190422113442.57645818@archlinux>
In-Reply-To: <20190414183504.23286-2-andrew.smirnov@gmail.com>
References: <20190414183504.23286-1-andrew.smirnov@gmail.com>
        <20190414183504.23286-2-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 11:34:59 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Use a local "struct device *dev" in imx7d_adc_probe() for brevity. No
> functional change intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
I applied some of these from V1.  Please be sure to only send updates
of patches that were not applied.

Thanks

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index ad6764fb2a23..3bbd657409d5 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -438,51 +438,51 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  	struct imx7d_adc *info;
>  	struct iio_dev *indio_dev;
>  	struct resource *mem;
> +	struct device *dev = &pdev->dev;
>  	int irq;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
>  	if (!indio_dev) {
>  		dev_err(&pdev->dev, "Failed allocating iio device\n");
>  		return -ENOMEM;
>  	}
>  
>  	info = iio_priv(indio_dev);
> -	info->dev = &pdev->dev;
> +	info->dev = dev;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	info->regs = devm_ioremap_resource(&pdev->dev, mem);
> +	info->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(info->regs)) {
>  		ret = PTR_ERR(info->regs);
> -		dev_err(&pdev->dev,
> -			"Failed to remap adc memory, err = %d\n", ret);
> +		dev_err(dev, "Failed to remap adc memory, err = %d\n", ret);
>  		return ret;
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "No irq resource?\n");
> +		dev_err(dev, "No irq resource?\n");
>  		return irq;
>  	}
>  
> -	info->clk = devm_clk_get(&pdev->dev, "adc");
> +	info->clk = devm_clk_get(dev, "adc");
>  	if (IS_ERR(info->clk)) {
>  		ret = PTR_ERR(info->clk);
> -		dev_err(&pdev->dev, "Failed getting clock, err = %d\n", ret);
> +		dev_err(dev, "Failed getting clock, err = %d\n", ret);
>  		return ret;
>  	}
>  
> -	info->vref = devm_regulator_get(&pdev->dev, "vref");
> +	info->vref = devm_regulator_get(dev, "vref");
>  	if (IS_ERR(info->vref)) {
>  		ret = PTR_ERR(info->vref);
> -		dev_err(&pdev->dev,
> +		dev_err(dev,
>  			"Failed getting reference voltage, err = %d\n", ret);
>  		return ret;
>  	}
>  
>  	ret = regulator_enable(info->vref);
>  	if (ret) {
> -		dev_err(&pdev->dev,
> +		dev_err(dev,
>  			"Can't enable adc reference top voltage, err = %d\n",
>  			ret);
>  		return ret;
> @@ -492,8 +492,8 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  
>  	init_completion(&info->completion);
>  
> -	indio_dev->name = dev_name(&pdev->dev);
> -	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->dev.parent = dev;
>  	indio_dev->info = &imx7d_adc_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = imx7d_adc_iio_channels;
> @@ -501,16 +501,15 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  
>  	ret = clk_prepare_enable(info->clk);
>  	if (ret) {
> -		dev_err(&pdev->dev,
> -			"Could not prepare or enable the clock.\n");
> +		dev_err(dev, "Could not prepare or enable the clock.\n");
>  		goto error_adc_clk_enable;
>  	}
>  
> -	ret = devm_request_irq(info->dev, irq,
> -				imx7d_adc_isr, 0,
> -				dev_name(&pdev->dev), info);
> +	ret = devm_request_irq(dev, irq,
> +			       imx7d_adc_isr, 0,
> +			       dev_name(dev), info);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "Failed requesting irq, irq = %d\n", irq);
> +		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
>  		goto error_iio_device_register;
>  	}
>  

