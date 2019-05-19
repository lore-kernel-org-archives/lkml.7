Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324FBC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CCB2054F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558288344;
	bh=CHcqzmd7f/zzrLlSymUwD4OBdmYfCokpiaI12KylP3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=relSxymY7RSN5uEXzs9PLQ77N7f/kjbvvQf18VuwQ9W2jYRpJIEgl6QHlieGzAS4a
	 CpAUgg1INFcBQUpF+RlonO4WXUCljsc9hL66q4Z5pBe7SwZrrTi34zc8DgfZ39fAYp
	 WMzdGb+4BJy178i+cEZrmKMaPqIADYxX9Q42A0I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbfESRwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 13:52:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfESRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 13:52:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DFE52053B;
        Sun, 19 May 2019 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558262552;
        bh=CHcqzmd7f/zzrLlSymUwD4OBdmYfCokpiaI12KylP3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YoczuPBn+eukyQ1MAURP/eFXVYH/RWtodIFqDMtNq25p9n6hwz62XWBo/F9LWWa/0
         YOoxWq5RRNsjdOVxGSFQmZkNV9ceO08KaPoQ53yEPhR8omKbP2ZRtH8ZtIUgueVO4v
         N5ClsS8OP2AvujGUYIR/wdMcx1OBeHgqv5Xb9WaI=
Date:   Sun, 19 May 2019 11:42:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Thiago Estrela <thiagestrela@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Tiago Napoli <napoli.tiago96@gmail.com>,
        Pedro Sousa <pedroteosousa@gmail.com>
Subject: Re: [PATCH] staging: iio: adis16203: Add of_device_id table
Message-ID: <20190519114226.68b86590@archlinux>
In-Reply-To: <20190518224213.25927-1-thiagestrela@gmail.com>
References: <20190518224213.25927-1-thiagestrela@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2019 19:42:13 -0300
Thiago Estrela <thiagestrela@gmail.com> wrote:

> Accomplish device tree compatibility to driver ADIS16203
> by adding of_device_id table and making a subsequent call to
> MODULE_DEVICE_TABLE.
> 
> Signed-off-by: Thiago Estrela <thiagestrela@gmail.com>
> Signed-off-by: Tiago Napoli <napoli.tiago96@gmail.com>
> Co-developed-by: Tiago Napoli <napoli.tiago96@gmail.com>
> Signed-off-by: Pedro Sousa <pedroteosousa@gmail.com>
> Co-developed-by: Pedro Sousa <pedroteosousa@gmail.com>
> Reviewed-by: Matheus Tavares <matheus.bernardino@usp.br>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Another nice patch.  Certainly seems like the dev day was
successful and welcome to so many new people.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to see if we missed anything.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/accel/adis16203.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index 70381756a64a..a5d974ac2e3b 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -311,9 +311,17 @@ static int adis16203_remove(struct spi_device *spi)
>  	return 0;
>  }
>  
> +static const struct of_device_id adis16203_of_match[] = {
> +	{ .compatible = "adi,adis16203" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, adis16203_of_match);
> +
>  static struct spi_driver adis16203_driver = {
>  	.driver = {
>  		.name = "adis16203",
> +		.of_match_table = adis16203_of_match,
>  	},
>  	.probe = adis16203_probe,
>  	.remove = adis16203_remove,

