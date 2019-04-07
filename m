Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29CCC282DE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8136521738
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 11:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554635036;
	bh=KvtSte/zwqJdwqPVKiN0szfPNy7gcHrfZyIjZuQWHWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QvPdHOwR1L288/U+xw2lZc8VVXEjXeKXgRa2QIsG6GZpo0cp4Z0mmgxeJz+iNJAHm
	 CCjFOY/bPvlJX4xw8fTi1iSpkwJOkOoUYdNe0JcXWKYiCA4GYEKTKU3Tg5xvXTlRXc
	 vN63bNg0LBQ4kxZ0igtOVUQbQ2LB4eeeGbG/ig8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDGLDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 07:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbfDGLDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 07:03:55 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCF8620880;
        Sun,  7 Apr 2019 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554635034;
        bh=KvtSte/zwqJdwqPVKiN0szfPNy7gcHrfZyIjZuQWHWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jecddVqgOxBuWtyiY7w93FN78+FJ9d6SmGhlN83DlN/vP/LViZj5j5o6yaWDEYozH
         7Etv3IrtrBSN5Ov3RqhOFqagB1CiBcRWcNnrPE8fyNAPKZeywTqndsuT0gOipleUKK
         toLtinALv4Z5hNUygGSrFPXgmxcvWk5xsl/kJtKU=
Date:   Sun, 7 Apr 2019 12:03:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        Haibo Chen <haibo.chen@freescale.com>
Subject: Re: [PATCH 2/6] iio: imx7d_adc: Replace pr_err with dev_err
Message-ID: <20190407120349.0215fd71@archlinux>
In-Reply-To: <20190403070325.1077-3-andrew.smirnov@gmail.com>
References: <20190403070325.1077-1-andrew.smirnov@gmail.com>
        <20190403070325.1077-3-andrew.smirnov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Apr 2019 00:03:21 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> Replace combination of pr_err()/dev_name() with an equivalent call for
> dev_err().
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
Applied, thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 3bbd657409d5..72cfe9834bcb 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -388,8 +388,9 @@ static irqreturn_t imx7d_adc_isr(int irq, void *dev_id)
>  	 * timeout flags.
>  	 */
>  	if (status & IMX7D_REG_ADC_INT_STATUS_CHANNEL_CONV_TIME_OUT) {
> -		pr_err("%s: ADC got conversion time out interrupt: 0x%08x\n",
> -			dev_name(info->dev), status);
> +		dev_err(info->dev,
> +			"ADC got conversion time out interrupt: 0x%08x\n",
> +			status);
>  		status &= ~IMX7D_REG_ADC_INT_STATUS_CHANNEL_CONV_TIME_OUT;
>  		writel(status, info->regs + IMX7D_REG_ADC_INT_STATUS);
>  	}

