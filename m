Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEDDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAAA20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Sw4fRtxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfC0Lgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:36:39 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55757 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfC0Lgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:36:37 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 46C2425B7E0;
        Wed, 27 Mar 2019 22:36:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553686595; bh=/hp9coc2hIp4pKiPSQNWP4+V1LCBbN32SHEAj+5T9eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sw4fRtxGQDzaIYMBaVeIW5BX/rEjAhYaUDs0a53OFMdkwkiDuK1H6VuaZiekpFu8w
         GuOo9t9gTqmHoq61SrFjQFProIncuig3qohgoA6kDBIwCyvmvgkZ1z9fDR8uQvoZ89
         3FVNLexXFtpaB3E7p2EuoeNuoHXul9MBP66gtGHY=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 7B32C940376; Wed, 27 Mar 2019 12:36:33 +0100 (CET)
Date:   Wed, 27 Mar 2019 12:36:33 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] regulator: da9063: convert header to SPDX
Message-ID: <20190327113609.4xtvntnl7vlh77rd@verge.net.au>
References: <20190325203155.8885-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325203155.8885-1-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:31:55PM +0100, Wolfram Sang wrote:
> Covnert the header of the source file to SPDX.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Change since V1: use C++ comments everywhere

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
>  drivers/regulator/da9063-regulator.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
> index 06ee844a969d..82107c9e09f0 100644
> --- a/drivers/regulator/da9063-regulator.c
> +++ b/drivers/regulator/da9063-regulator.c
> @@ -1,18 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Regulator driver for DA9063 PMIC series
> +//
> +// Copyright 2012 Dialog Semiconductors Ltd.
> +// Copyright 2013 Philipp Zabel, Pengutronix
> +//
> +// Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
>  
> -/*
> - * Regulator driver for DA9063 PMIC series
> - *
> - * Copyright 2012 Dialog Semiconductors Ltd.
> - * Copyright 2013 Philipp Zabel, Pengutronix
> - *
> - * Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the  License, or (at your
> - *  option) any later version.
> - *
> - */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> -- 
> 2.19.1
> 
