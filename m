Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1674EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93872146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554024784;
	bh=hL/t9/rbnTS3dcyc94ugZAmWA+NDU89tJApECKylftg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NUbXJmkOM0HRqHGDEnzKHBgZAA/Ffj3oio0diB/gqG5AFKf2/MUdOcVx4aHPZaooT
	 Br/IgeH3/Jc7g9ua6wG3joR8XdnwPnT7dcd68+jlSa5rZuywwX3vojS+n2GrWeHYZc
	 qWle9yrB7PY9LB67lxynMGYquoez3z0i91XihG3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfCaJdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfCaJdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:33:02 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05090206DD;
        Sun, 31 Mar 2019 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554024782;
        bh=hL/t9/rbnTS3dcyc94ugZAmWA+NDU89tJApECKylftg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=esYwa1HtVthRFFAmi47Xm/z2Rpc5Xvd870xeq5Li0mNmZWUGsPA/rbXwDyASunWc/
         PpHZ66Aoo1fzuHBhi4yJUIvVFjfu4aMpiZTD82R8hjWxzM7aW4xnmzvXkfHbd93gQH
         tqBDDw2Wm1VvDMHEWceFB4Ryo8SRFsv2XC5q64AU=
Date:   Sun, 31 Mar 2019 10:32:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Sicilia <sicilia.cristian@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] staging: iio: adc: ad7192: Converted bool to
 bitfield format
Message-ID: <20190331103256.0b1e5e96@archlinux>
In-Reply-To: <1d0e1d2c7011bfd2d20e8dd728256bf245861a8e.1553447138.git.sicilia.cristian@gmail.com>
References: <cover.1553366098.git.sicilia.cristian@gmail.com>
        <cover.1553447138.git.sicilia.cristian@gmail.com>
        <1d0e1d2c7011bfd2d20e8dd728256bf245861a8e.1553447138.git.sicilia.cristian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Mar 2019 18:23:11 +0100
Cristian Sicilia <sicilia.cristian@gmail.com> wrote:

> Changed bool format to bitfield format to save space.
> 
> Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
This driver is undergoing active rework to move out of staging
and in the meantime these fields have been dropped.

So not applied as no longer relevant.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> index 7433a43..9c1d223 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -35,13 +35,13 @@ struct ad7192_platform_data {
>  	u16		vref_mv;
>  	u8		clock_source_sel;
>  	u32		ext_clk_hz;
> -	bool		refin2_en;
> -	bool		rej60_en;
> -	bool		sinc3_en;
> -	bool		chop_en;
> -	bool		buf_en;
> -	bool		unipolar_en;
> -	bool		burnout_curr_en;
> +	u8		refin2_en:1;
> +	u8		rej60_en:1;
> +	u8		sinc3_en:1;
> +	u8		chop_en:1;
> +	u8		buf_en:1;
> +	u8		unipolar_en:1;
> +	u8		burnout_curr_en:1;
>  };
>  
>  #endif /* IIO_ADC_AD7192_H_ */

