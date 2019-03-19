Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE2C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6D220643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="WkSaC6+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCSMJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:09:55 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46749 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCSMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:09:55 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 9988925AD6C;
        Tue, 19 Mar 2019 23:09:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552997392; bh=sq09idYA6etiUJXOWgEwzGF/lH22KPwTJZqKwbK7c7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WkSaC6+emQdglpI0x7YVqxx45C3cTHC7yHDnEvmvyTPn/24KFdsW3GDMKpQ3DDm4L
         QwUTdY79Te/S6IbNOHveAdF1adYjWt35f4lm0PRNlPyQD/BkNlU86etgDzUBm4ztrc
         0l/IIT9UOVQgg8mQIhZO4x/F675+pEWMhlH6R5/c=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 01491940663; Tue, 19 Mar 2019 13:09:50 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:09:50 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 3/4] input: da9063_onkey: convert header to SPDX
Message-ID: <20190319120950.cu3vpuximogjzdtz@verge.net.au>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318155728.28365-4-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:57:26PM +0100, Wolfram Sang wrote:
> Covnert the header of the source file to SPDX.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/input/misc/da9063_onkey.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
> index 3e9c353d82ef..7b8ae905a6fb 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -1,16 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * OnKey device driver for DA9063, DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version 2
> - * of the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>
> -- 
> 2.11.0
> 
