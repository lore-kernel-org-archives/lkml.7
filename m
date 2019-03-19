Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4436120643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Wm8LymYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCSMKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:10:51 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46788 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCSMKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:10:51 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 3AAD125B7CA;
        Tue, 19 Mar 2019 23:10:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552997449; bh=6yaS1E3oMZBfAGROKWHSUoq/Z4GxBvWi2rntbEPR1fE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wm8LymYjPMgP0oTMosXWGcPeIPA4ZNvicoHu/0xfwko+1qsSxxfVS07EepqL6M10X
         TNPil8oxq6xHuYu4AVe1b5X8UsgybbFlTCwwwtji2s8bTyedsX2CFo/w285CWtR6AY
         DfLPN6zZ918hQpvIytos3XVSpf9rhDTwYwtVijbk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A4F05940663; Tue, 19 Mar 2019 13:10:47 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:10:47 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 1/4] mfd: da9063: convert headers to SPDX
Message-ID: <20190319121047.g3yz7lhmd2fn77lw@verge.net.au>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318155728.28365-2-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:57:24PM +0100, Wolfram Sang wrote:
> Covnert the headers of the source and include files to SPDX.
> And fix some typos in the descriptions ("interrupt" instead of "I2C").
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/mfd/da9063-core.c            | 8 ++------
>  drivers/mfd/da9063-i2c.c             | 9 ++-------
>  drivers/mfd/da9063-irq.c             | 9 ++-------
>  include/linux/mfd/da9063/core.h      | 7 +------
>  include/linux/mfd/da9063/registers.h | 7 +------
>  5 files changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index 6e4ce49b4405..4e5ebb7f2ef0 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -1,5 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
> - * da9063-core.c: Device access for Dialog DA9063 modules
> + * Device access for Dialog DA9063 modules
>   *
>   * Copyright 2012 Dialog Semiconductors Ltd.
>   * Copyright 2013 Philipp Zabel, Pengutronix
> @@ -7,11 +8,6 @@
>   * Author: Krystian Garbaciak, Dialog Semiconductor
>   * Author: Michal Hajduk, Dialog Semiconductor
>   *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
>   */
>  
>  #include <linux/kernel.h>
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 50a24b1921d0..4a97ba0a35bb 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -1,15 +1,10 @@
> -/* da9063-i2c.c: Interrupt support for Dialog DA9063
> +// SPDX-License-Identifier: GPL-2.0+
> +/* I2C support for Dialog DA9063
>   *
>   * Copyright 2012 Dialog Semiconductor Ltd.
>   * Copyright 2013 Philipp Zabel, Pengutronix
>   *
>   * Author: Krystian Garbaciak, Dialog Semiconductor
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
>   */
>  
>  #include <linux/kernel.h>
> diff --git a/drivers/mfd/da9063-irq.c b/drivers/mfd/da9063-irq.c
> index ecc0c8ce6c58..e12b3dd0c99b 100644
> --- a/drivers/mfd/da9063-irq.c
> +++ b/drivers/mfd/da9063-irq.c
> @@ -1,15 +1,10 @@
> -/* da9063-irq.c: Interrupts support for Dialog DA9063
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Interrupt support for Dialog DA9063
>   *
>   * Copyright 2012 Dialog Semiconductor Ltd.
>   * Copyright 2013 Philipp Zabel, Pengutronix
>   *
>   * Author: Michal Hajduk, Dialog Semiconductor
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
>   */
>  
>  #include <linux/kernel.h>
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index 71b09154e2db..5cd06ab26352 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Definitions for DA9063 MFD driver
>   *
> @@ -5,12 +6,6 @@
>   *
>   * Author: Michal Hajduk, Dialog Semiconductor
>   * Author: Krystian Garbaciak, Dialog Semiconductor
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
>   */
>  
>  #ifndef __MFD_DA9063_CORE_H__
> diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
> index 5d42859cb441..272f984b766d 100644
> --- a/include/linux/mfd/da9063/registers.h
> +++ b/include/linux/mfd/da9063/registers.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Registers definition for DA9063 modules
>   *
> @@ -5,12 +6,6 @@
>   *
>   * Author: Michal Hajduk, Dialog Semiconductor
>   * Author: Krystian Garbaciak, Dialog Semiconductor
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
>   */
>  
>  #ifndef _DA9063_REG_H
> -- 
> 2.11.0
> 
