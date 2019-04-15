Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7815320880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LpXjUdMV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LpXjUdMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfDOOxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:53:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53460 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDOOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:53:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D0D426141D; Mon, 15 Apr 2019 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555339998;
        bh=HLFTU8G8i5D5dNPQuEfeiJ8ZaAz3p5YUdxnsBiGnSAQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LpXjUdMV7l+YsJL2n1mOpWVkyJoj09jF6zno+OAtaybpBa4lM7kDlQXmmHYFEJnMg
         w19blp47VZLmInnls3CtsUry9WbNiN653GTch0qsUqX/Igp09cplVVrnDFVsQ5w2dp
         gvgwuaTNjcPkThomSYEvnP8owj1hreo9p3SAPXBk=
Received: from [10.204.79.29] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6947760E75;
        Mon, 15 Apr 2019 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555339998;
        bh=HLFTU8G8i5D5dNPQuEfeiJ8ZaAz3p5YUdxnsBiGnSAQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LpXjUdMV7l+YsJL2n1mOpWVkyJoj09jF6zno+OAtaybpBa4lM7kDlQXmmHYFEJnMg
         w19blp47VZLmInnls3CtsUry9WbNiN653GTch0qsUqX/Igp09cplVVrnDFVsQ5w2dp
         gvgwuaTNjcPkThomSYEvnP8owj1hreo9p3SAPXBk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6947760E75
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] wimax/i2400m: fix spelling mistake "accesibility" ->
 "accessibility"
To:     Colin King <colin.king@canonical.com>,
        Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190415101555.10584-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <95c23c24-cb22-ab5f-52f8-a22a428c9a2f@codeaurora.org>
Date:   Mon, 15 Apr 2019 20:23:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415101555.10584-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2019 3:45 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the I2400M_MS_ACCESSIBILITY_ERROR message
> string, fix this.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/net/wimax/i2400m/control.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wimax/i2400m/control.c b/drivers/net/wimax/i2400m/control.c
> index ef298d8525c5..6837fac3987b 100644
> --- a/drivers/net/wimax/i2400m/control.c
> +++ b/drivers/net/wimax/i2400m/control.c
> @@ -254,7 +254,7 @@ static const struct
>   	[I2400M_MS_ILLEGAL_VALUE] = { "illegal value", -EINVAL },
>   	[I2400M_MS_MISSING_PARAMS] = { "missing parameters", -ENOMSG },
>   	[I2400M_MS_VERSION_ERROR] = { "bad version", -EIO },
> -	[I2400M_MS_ACCESSIBILITY_ERROR] = { "accesibility error", -EIO },
> +	[I2400M_MS_ACCESSIBILITY_ERROR] = { "accessibility error", -EIO },
>   	[I2400M_MS_BUSY] = { "busy", -EBUSY },
>   	[I2400M_MS_CORRUPTED_TLV] = { "corrupted TLV", -EILSEQ },
>   	[I2400M_MS_UNINITIALIZED] = { "uninitialized", -EILSEQ },
