Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2773C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A81218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552759488;
	bh=gaTEheMCIDSd7k3aq63ketAro3iax0eCVhVpnxcbYnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rEUxa0JxFWFCkbJgOj956Pn70ZyZGWWZlHjAqKpXlxzgx7i97ywVHhyNVrvkVHsDT
	 nk/Xj5cznjgf/dPUFKycrqePfWjEBbtALv5Qgx7BJgCLRfBMN+5xpjF5ZwrauUZqr+
	 Cuq+dJNG2rRSjccECzRVKiT0Sa1Frp4WUv5SVgnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfCPSEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 14:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfCPSEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 14:04:47 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8AF218D0;
        Sat, 16 Mar 2019 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552759486;
        bh=gaTEheMCIDSd7k3aq63ketAro3iax0eCVhVpnxcbYnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a9KsrvnaSecocDSsYucr/qIfigpLAiuCveqScE+uiHnJOc0S93Mb0uk9KbgYpOFVf
         gQx5EVY7d7oSkPqkpmiBpqfe/Ra8GY5z/D/AajP8bECFv9lSPu1jrXJouQ7lKWBrMp
         CiK6y6z85wtvv6/EJcUiJ+OjIFgBjvM/QeG5VkYo=
Date:   Sat, 16 Mar 2019 18:04:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Renato Lui Geh <renatogeh@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 09/11] staging: iio: ad7780: add new copyright holder
Message-ID: <20190316180439.5cb0740c@archlinux>
In-Reply-To: <7cfb577d4e07b00a820b35dc56c58809120f8f39.1552700652.git.renatogeh@gmail.com>
References: <cover.1552700652.git.renatogeh@gmail.com>
        <7cfb577d4e07b00a820b35dc56c58809120f8f39.1552700652.git.renatogeh@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 23:15:26 -0300
Renato Lui Geh <renatogeh@gmail.com> wrote:

> This patch adds a new copyright holder to the ad7780 driver.
> 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
Applied thanks

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index ff61ffa0da9f..23b731a92e32 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -3,6 +3,7 @@
>   * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
>   *
>   * Copyright 2011 Analog Devices Inc.
> + * Copyright 2019 Renato Lui Geh
>   */
>  
>  #include <linux/interrupt.h>

