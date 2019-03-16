Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF03C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1C21903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552759436;
	bh=SHHYDrj+G4caF/KKHv4FkpYMAeYmGpdR27X5omly/AM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=be/sjgB/UKWYJXl84UMW89RlGX/PntesSC4sKlczWPtg6d6CUwyyloCkEHGE/E/a0
	 6tbEgb0CFM6kR33ymWWtfsHQHlXDRYiyGfKLJ+UWm6siD4i5XegCQUbRaFyvEysSdT
	 qvF9Q7pLZuQkYUQ0JXByMFxx+RSmujQY4IxX5g2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCPSDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPSDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:03:54 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81462218D0;
        Sat, 16 Mar 2019 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552759434;
        bh=SHHYDrj+G4caF/KKHv4FkpYMAeYmGpdR27X5omly/AM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QvZ9L8cUrUAImfqhX6/8zRLC/kaRUT3rdevGGnW1gJ4eKaMBgnEvaCgVFeGUZKXV/
         o3D0J1838S4Q5XBiQ6rEgVHwOS5HL20dtz2Tug/CVh/39ck10aHIR8HEtY2MRPbh5i
         WNtOmlmczZ3XRhp+ROuqghsJBdqAqMOLhXJTIank=
Date:   Sat, 16 Mar 2019 18:03:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 08/11] staging: iio: ad7780: add SPDX identifier
Message-ID: <20190316180347.1a6c2bf6@archlinux>
In-Reply-To: <4344b002e730538b737e576b7d262687ab62473c.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <4344b002e730538b737e576b7d262687ab62473c.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:15:13 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> Add SPDX identifier (GPL-2.0) to the AD7780 driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Applied

> ---
>  drivers/staging/iio/adc/ad7780.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 568c5b4472ff..ff61ffa0da9f 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>   */
>  
>  #include <linux/interrupt.h>

