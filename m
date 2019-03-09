Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA92C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB58120815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552155417;
	bh=wg4B8WczmM1LQB4wVY05qmDc4v+aN9CL3r6Gic+SD7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VeeohrBLZcDnxB3Huh5e374TbmLTcOyTCy+0Jwf5fcXvErrpmiKrORzjClchTi9t0
	 PlVhd/IUVvvbQ458zRAyxCLivPXBGwGpQV/n4kJvuFIjHDSOmxdMMwcUwi4Bm9IxAa
	 WPf0QsLQfh2hbge9pUgLRM3+rMfakD4IMXNKDBfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCISQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfCISQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:16:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B52206DF;
        Sat,  9 Mar 2019 18:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552155414;
        bh=wg4B8WczmM1LQB4wVY05qmDc4v+aN9CL3r6Gic+SD7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qWcgmXsr7Vsqmuev06onPcdpokRe3u7fMw/XWUTOGnigGLmeBP05rTBu3dlMheUpQ
         h0WsTH51Z2zeUH/dWGr3t7PL+PZbD6H0yyNJgLGKa5OC6Q8YXpZFVlKMq9h+6PGyqy
         eX1Xa16ryhqNkM8GOtAlrEqOHFLPARS6VrAHgRaI=
Date:   Sat, 9 Mar 2019 18:16:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Yang <decatf@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: accel: kxcjk1013: Add device tree support
Message-ID: <20190309181649.228507de@archlinux>
In-Reply-To: <20190304151912.11485-4-decatf@gmail.com>
References: <20190304151912.11485-1-decatf@gmail.com>
        <20190304151912.11485-4-decatf@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 10:19:12 -0500
Robert Yang <decatf@gmail.com> wrote:

> Add device tree support for kxcjk-1013 accelerometer sensors.
> 
> Signed-off-by: Robert Yang <decatf@gmail.com>
One comment below. 

Applied with that minor tweak to the togreg branch of iio.git
and pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7096e577b23f..e4cbc443e6ed 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1510,10 +1510,20 @@ static const struct i2c_device_id kxcjk1013_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
>  
> +static const struct of_device_id kxcjk1013_of_match[] = {
> +	{ .compatible = "kionix,kxcjk1013", },
> +	{ .compatible = "kionix,kxcj91008", },
> +	{ .compatible = "kionix,kxtj21009", },
> +	{ .compatible = "kionix,kxtf9", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, kxcjk1013_of_match);
> +
>  static struct i2c_driver kxcjk1013_driver = {
>  	.driver = {
>  		.name	= KXCJK1013_DRV_NAME,
>  		.acpi_match_table = ACPI_PTR(kx_acpi_match),
> +		.of_match_table = of_match_ptr(kxcjk1013_of_match),
Sorry. I'd missed this before, but general preference is to not
use of_match_table any more because it stops people using the
somewhat odd ACPI object that lets you used dt bindings
via ACPI.

I'll drop it.

>  		.pm	= &kxcjk1013_pm_ops,
>  	},
>  	.probe		= kxcjk1013_probe,

