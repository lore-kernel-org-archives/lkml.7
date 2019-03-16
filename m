Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA86C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC132218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552761522;
	bh=uU95wIzDSWeCSMx+FkXnOS+9LYCv/+/sspT/KY1cr/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DnB7Ke1bBmIdcuAOKP/sI/sLWV1rDOo8HGVHRQz8pZp4zcUAaNqn85KM9+utasoqT
	 gAUtYky6PRJPRO5NH17Lo0JQkWSHI2aaGVFJf0AQ+zH9nernYceHeCaKvndiHMCYap
	 Jk2IOwRM5nj2nfufvaFOYyNuFOcd6QzVdXDA65Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfCPSil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPSik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:38:40 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31982218A1;
        Sat, 16 Mar 2019 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552761520;
        bh=uU95wIzDSWeCSMx+FkXnOS+9LYCv/+/sspT/KY1cr/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QhaYRu7qcrHrmcNhEqptSgHTsgJ3MiljD0LI7if6DskieJGUxFKQZfSCuvNq2VW9g
         FZoEoeMtGcUl6SBlN0rDExjJIRo7b3qOzpmVPYMR/p6CapAeuKrntp7GSx9i/saN6I
         gqf5PA/x1YUvy42eWAStn4AJ/IMIWTlSMgYBzuqo=
Date:   Sat, 16 Mar 2019 18:38:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v4 4/7] staging: iio: ad5933: change help rule message
Message-ID: <20190316183834.0e6ae2e4@archlinux>
In-Reply-To: <20190316150718.kl27r5vqendxj3mw@smtp.gmail.com>
References: <20190316150718.kl27r5vqendxj3mw@smtp.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2019 12:07:18 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Remove the previous comment about direct access via sysfs which would
> lead one think ad5933 driver has limitations it actually doesn't.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Applied.

Thanks,

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

