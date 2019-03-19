Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639A6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3423F20643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="clV8xkWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCSMLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:11:03 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:46801 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfCSMLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:11:02 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 295D825BEFA;
        Tue, 19 Mar 2019 23:11:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552997460; bh=IfZBIVzzrIX2AUkpIVFUFDbZY5IUtM6z9xpYc7Xrm+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clV8xkWJQXQGgIWbjff4E8mSbi3DyaDZgMx2patz70PmXLh3ekB0ZM7X6ytJ6gCg2
         1cXfe6ycISrdC6DhGHL6QWwgTZkOMI65KbesWqzAt2ukD0D4U32jKIHh5U8IlK5ieG
         dGJhxU4aRzUXW8aKTsX90+FoSm8hGzG6a/1fes1I=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 8CCBE940663; Tue, 19 Mar 2019 13:10:58 +0100 (CET)
Date:   Tue, 19 Mar 2019 13:10:58 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/4] regulator: da9063: convert header to SPDX
Message-ID: <20190319121058.3c4usp5xrhfs5ifq@verge.net.au>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-3-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318155728.28365-3-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:57:25PM +0100, Wolfram Sang wrote:
> Covnert the header of the source file to SPDX.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/regulator/da9063-regulator.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index 2b0c7a85306a..42dca1cac077 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -1,4 +1,4 @@
> -
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Regulator driver for DA9063 PMIC series
>   *
> @@ -6,12 +6,6 @@
>   * Copyright 2013 Philipp Zabel, Pengutronix
>   *
>   * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -- 
> 2.11.0
> 
