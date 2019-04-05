Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C54C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFDA20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZvDvVVNo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FOaxdlgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfDEMrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:47:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfDEMrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:47:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4DF3E6118C; Fri,  5 Apr 2019 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554468433;
        bh=atSbh04puzQYQhG2D7ZurJM3R3QUVMwL02EZRJpAkUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZvDvVVNoK/cFHgBdTjReuRHqG/TDoG9Kp7MjgSIICN1jHke7YsUxR11ic/yvK2Okd
         cPfhGzp/5RfZdxSpx9RJRNNy5watBtbnKnU9TRMK+/Fa7LmWomfkVAdx2my1KSTGce
         Ein4Udy36wgN4oD8I8dJtbhqeqNUAcX0ttFJpA74=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 38BF660DAA;
        Fri,  5 Apr 2019 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554468430;
        bh=atSbh04puzQYQhG2D7ZurJM3R3QUVMwL02EZRJpAkUg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FOaxdlglL/W1WMiTuimQG92soSiM0eiMJhDq9TkkK72iHtgAIaVM626TDSQ3l4Yph
         kJ00a1bI3eJh9YeHNLUSxlwheWEJaScaJcZBFAyy7KX8tm55yGFHD26NyZoeBYIqWW
         kQzJEXL5xB1Uvu7G2/MM8K+GcQdxV1hz3cD6dj8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 38BF660DAA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX
 identifier
To:     Andra Danciu <andradanciu1997@gmail.com>, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-3-andradanciu1997@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
Date:   Fri, 5 Apr 2019 18:17:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405115010.28838-3-andradanciu1997@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2019 5:19 PM, Andra Danciu wrote:
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>   sound/soc/fsl/efika-audio-fabric.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
> index 667f4215dfc0..3e832902fc99 100644
> --- a/sound/soc/fsl/efika-audio-fabric.c
> +++ b/sound/soc/fsl/efika-audio-fabric.c
> @@ -1,14 +1,9 @@
> -/*
> - * Efika driver for the PSC of the Freescale MPC52xx
> - * configured as AC97 interface
> - *
> - * Copyright 2008 Jon Smirl, Digispeaker
> - * Author: Jon Smirl <jonsmirl@gmail.com>
> - *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2. This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
> - */
> +// SPDX-License-Identifier: GPL-2.0

Don't change entire thing with //. only above line with the license is 
enough.

Please apply this rule every patch of yours.

Thanks,
Mukesh


> +// Efika driver for the PSC of the Freescale MPC52xx
> +// configured as AC97 interface
> +//
> +// Copyright 2008 Jon Smirl, Digispeaker
> +// Author: Jon Smirl <jonsmirl@gmail.com>

>   
>   #include <linux/init.h>
>   #include <linux/module.h>
