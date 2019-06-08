Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18962C468BC
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07C521537
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfFHNbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 09:31:16 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:60898 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFHNbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:31:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1F41A9E9162;
        Sat,  8 Jun 2019 14:31:13 +0100 (BST)
Date:   Sat, 8 Jun 2019 14:31:11 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Thomas Meyer <thomas@m3y3r.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: ftm-quaddec: needs HAS_IOMEM
Message-ID: <20190608143111.6c481920@archlinux>
In-Reply-To: <20190601213805.32733-1-thomas@m3y3r.de>
References: <20190601213805.32733-1-thomas@m3y3r.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  1 Jun 2019 23:38:05 +0200
Thomas Meyer <thomas@m3y3r.de> wrote:

> the driver fails for UML with:
> drivers/counter/ftm-quaddec.c:301: undefined reference to `devm_ioremap'
> 
> Fix it by depending on HAS_IOMEM
Missing Signed-off-by.

Unfortunately I came across another patch for this before yours so
already have this fixed in the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 138ecd8a8fbd..6298344b536b 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -50,6 +50,7 @@ config STM32_LPTIMER_CNT
>  	  module will be called stm32-lptimer-cnt.
>  
>  config FTM_QUADDEC
> +	depends on HAS_IOMEM
>  	tristate "Flex Timer Module Quadrature decoder driver"
>  	help
>  	  Select this option to enable the Flex Timer Quadrature decoder

