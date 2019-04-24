Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AAFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0C020685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZXfLcAgw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kIVCYBN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfDXGGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:06:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfDXGGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:06:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 86FCC60712; Wed, 24 Apr 2019 06:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556085995;
        bh=enAMM3Xj8ORmOssE1Hz0WzPVPS4RBC+A3No5jfZB4C8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZXfLcAgwyzgj4cwO9LDWVsRca97uZyweB084YZjKfm+fP6hY4U8Q9ljFZeqhEUfSN
         WR1VASCiUZZk/uTA9BX5QvwJnqwCsRvwHwEIsDnploA7u0qCbSSu/tGDwPa/CA0gjY
         bMnucIRHCN8NLg3enapwxEJBO4dksCGh74724d2U=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A36FE602F2;
        Wed, 24 Apr 2019 06:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556085994;
        bh=enAMM3Xj8ORmOssE1Hz0WzPVPS4RBC+A3No5jfZB4C8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kIVCYBN3XkiQgoq63ANfzxP7q0y9WhXiHwo7eVgGJBiKOHtq0GUoD68FblGT7Cay8
         RNbxh/zDoPyBinP6x1uXU6shRk8ihJbCbkb8RdbR3qF6pKb9W55VCaZQ9eYgauttZJ
         f11DVHVexTOWe2+Voy+sQJItezoatVxKkdWicVmw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A36FE602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] staging: kpc2000: remove duplicated include from
 kp2000_module.c
To:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190424025000.93077-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2316d2d2-d505-cca2-0ed0-dccbd5fe67fd@codeaurora.org>
Date:   Wed, 24 Apr 2019 11:36:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424025000.93077-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/2019 8:20 AM, YueHaibing wrote:
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/staging/kpc2000/kpc2000/kp2000_module.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/kpc2000/kpc2000/kp2000_module.c b/drivers/staging/kpc2000/kpc2000/kp2000_module.c
> index 661b0b74ed66..fa3bd266ba54 100644
> --- a/drivers/staging/kpc2000/kpc2000/kp2000_module.c
> +++ b/drivers/staging/kpc2000/kpc2000/kp2000_module.c
> @@ -5,7 +5,6 @@
>   #include <linux/types.h>
>   #include <linux/export.h>
>   #include <linux/slab.h>
> -#include <linux/pci.h>
>   #include <asm/io.h>
>   #include <linux/io.h>
>   #include <linux/mfd/core.h>
>
>
>
>
>
