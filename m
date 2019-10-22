Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA7DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA69C20663
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfJVJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:09:46 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56757 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388171AbfJVJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:09:45 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iMqAi-0005fH-FW; Tue, 22 Oct 2019 11:09:44 +0200
Message-ID: <b20a2d34d6a42e376ab48d944d2540b1776d103d.camel@pengutronix.de>
Subject: Re: [PATCHv2] reset: build simple reset controller driver for Agilex
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 22 Oct 2019 11:09:44 +0200
In-Reply-To: <20191014151827.9486-1-dinguyen@kernel.org>
References: <20191014151827.9486-1-dinguyen@kernel.org>
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

On Mon, 2019-10-14 at 10:18 -0500, Dinh Nguyen wrote:
> The Intel SoCFPGA Agilex platform shares the same reset controller that
> is on the Stratix10.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: rebase to v5.4-rc1
> ---
>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7b07281aa0ae..46f7986c3587 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -129,7 +129,7 @@ config RESET_SCMI
>  
>  config RESET_SIMPLE
>  	bool "Simple Reset Controller Driver" if COMPILE_TEST
> -	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN || ARC
> +	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN || ARC || ARCH_AGILEX
>  	help
>  	  This enables a simple reset controller driver for reset lines that
>  	  that can be asserted and deasserted by toggling bits in a contiguous,

Thank you, applied to reset/next.

regards
Philipp

