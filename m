Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E865C4360F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E163B20866
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 12:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551614578;
	bh=KgdQDtxgQ118FkZlxzN63vgDDYILbYgMsZg802FZ35Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WT/EVSGET5nfGkqjOvKMlwsiEWn+KgXLPMtCi0eY1xbokNqlh9XZDLDRT/7EMJteJ
	 WUji8OCVn8HLjvgwqSd69vR6jcsVJovmn2fpVMeiRPWmVhNhhnfosQwK8WusYxRysx
	 acamAOdR5GpkvVnpuexMlKGDMX141SpRnAZqE7ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfCCMC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 07:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfCCMC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 07:02:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC05620857;
        Sun,  3 Mar 2019 12:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551614575;
        bh=KgdQDtxgQ118FkZlxzN63vgDDYILbYgMsZg802FZ35Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vBEefFpueD3s9ynU/bwjmV7YTzaFWXrJC14jLtNvZcDDYcNDN6ILRWzh29YAvk/DO
         Vmw1zZJ4vPNNrnDV4295DWrwfneyhomVpBYX2EAv/vzuYhOQu7z4Kx7bGAkM4K2crn
         uAVpUWrNfNIttZJZl3j2+NvrZaiLGyqQwy2NDMUM=
Date:   Sun, 3 Mar 2019 12:02:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 2/4] staging: iio: ad5933: change help rule message
Message-ID: <20190303120250.61ee5492@archlinux>
In-Reply-To: <20190301025258.bcvj5rg57io4najb@smtp.gmail.com>
References: <20190301025258.bcvj5rg57io4najb@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 23:52:58 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Remove the previous comment about direct access via sysfs which would
> lead one think ad5933 driver has limitations it actually doesn't.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
This is fine. Will pick up once the rest of the series is ready.

Jonathan

> ---
>  drivers/staging/iio/impedance-analyzer/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
> index dd97b6bb3fd0..b9a679cdd146 100644
> --- a/drivers/staging/iio/impedance-analyzer/Kconfig
> +++ b/drivers/staging/iio/impedance-analyzer/Kconfig
> @@ -10,7 +10,7 @@ config AD5933
>  	select IIO_KFIFO_BUF
>  	help
>  	  Say yes here to build support for Analog Devices Impedance Converter,
> -	  Network Analyzer, AD5933/4, provides direct access via sysfs.
> +	  Network Analyzer, AD5933/4.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5933.

