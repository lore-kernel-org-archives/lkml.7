Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC7C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B6E207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgAGIc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:32:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55085 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgAGIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:32:58 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iokIL-0007M3-Hu; Tue, 07 Jan 2020 09:32:57 +0100
Message-ID: <bb0651eb7b1c81755ec43fe9d85f27a5fd83af88.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Kconfig: Set CONFIG_RESET_QCOM_AOSS as tristate
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Todd Kjos <tkjos@google.com>, Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 07 Jan 2020 09:32:56 +0100
In-Reply-To: <20200107010350.58657-1-john.stultz@linaro.org>
References: <20200107010350.58657-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 01:03 +0000, John Stultz wrote:
> Allow CONFIG_RESET_QCOM_AOSS to be set as as =m
> to allow for the driver to be loaded from a modules.
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 3ad7817ce1f0..45e70524af36 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -99,7 +99,7 @@ config RESET_PISTACHIO
>  	  This enables the reset driver for ImgTec Pistachio SoCs.
>  
>  config RESET_QCOM_AOSS
> -	bool "Qcom AOSS Reset Driver"
> +	tristate "Qcom AOSS Reset Driver"

This doesn't seem right on its own, the driver still uses
builtin_platform_driver().

regards
Philipp

