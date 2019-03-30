Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB08C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C946217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 18:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JIy3nOsV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mv6nZ78e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfC3SPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 14:15:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39614 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbfC3SPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 14:15:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BD3AA608FC; Sat, 30 Mar 2019 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553969701;
        bh=Sl4mpVEtWUWi6PQhxgVnvMiUSuvf91C2qd5+jSeuHQ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JIy3nOsVlKKO/EOjMJ9J3FPuyF3vGWbhI5EhpCBSOzTVMprW+9L/nxherw0faNM+P
         SO8tSXjggKyUEz9RNe4J6KWxObJg5Y0WPFgsO87X+Qnvw1nMH8SlwmuxieFUojLaUe
         0gFJD4kWwBjTB15TzslTn5QwAGFeHmlnhDjBt1HA=
Received: from [10.79.169.97] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 116AC60712;
        Sat, 30 Mar 2019 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553969700;
        bh=Sl4mpVEtWUWi6PQhxgVnvMiUSuvf91C2qd5+jSeuHQ8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mv6nZ78e7IdSi1GXXBtlZTNyEDZOZpfqJPcyeiZnQ3QqR7rs+0O5MQJViQ9ddHmiP
         wpNOUbZRgVTTqK4i4+ckx2QQ1VvbOQU8T16kzYsZzASUWzzCUSlyeLnRatPuayySVW
         XY098r2h8JIclHdk8YK79r7SkP8Y5uDA0JmlrXx4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 116AC60712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] media: dvb: clean up redundant break statements
To:     Colin King <colin.king@canonical.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Sean Young <sean@mess.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190330152503.9923-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7392df5f-af02-18aa-beb8-36052f52a170@codeaurora.org>
Date:   Sat, 30 Mar 2019 23:44:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330152503.9923-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2019 8:55 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several places where a break statement occurs before
> a following break statement; these are unnecessary and can be
> removed to clean up the code a little.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


> ---
>   drivers/media/dvb-frontends/drxd_hard.c | 30 +++++--------------------
>   1 file changed, 5 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
> index 0a5b15bee1d7..c597d6fc3046 100644
> --- a/drivers/media/dvb-frontends/drxd_hard.c
> +++ b/drivers/media/dvb-frontends/drxd_hard.c
> @@ -2263,61 +2263,41 @@ static int DRX_Start(struct drxd_state *state, s32 off)
>   		case DRX_CHANNEL_LOW:
>   			transmissionParams |= SC_RA_RAM_OP_PARAM_PRIO_LO;
>   			status = Write16(state, EC_SB_REG_PRIOR__A, EC_SB_REG_PRIOR_LO, 0x0000);
> -			if (status < 0)
> -				break;
>   			break;
>   		case DRX_CHANNEL_HIGH:
>   			transmissionParams |= SC_RA_RAM_OP_PARAM_PRIO_HI;
>   			status = Write16(state, EC_SB_REG_PRIOR__A, EC_SB_REG_PRIOR_HI, 0x0000);
> -			if (status < 0)
> -				break;
>   			break;
> -
>   		}
>   
>   		switch (p->code_rate_HP) {
>   		case FEC_1_2:
>   			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_1_2;
> -			if (state->type_A) {
> +			if (state->type_A)
>   				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C1_2, 0x0000);
> -				if (status < 0)
> -					break;
> -			}
>   			break;
>   		default:
>   			operationMode |= SC_RA_RAM_OP_AUTO_RATE__M;
>   			/* fall through */
>   		case FEC_2_3:
>   			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_2_3;
> -			if (state->type_A) {
> +			if (state->type_A)
>   				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C2_3, 0x0000);
> -				if (status < 0)
> -					break;
> -			}
>   			break;
>   		case FEC_3_4:
>   			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_3_4;
> -			if (state->type_A) {
> +			if (state->type_A)
>   				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C3_4, 0x0000);
> -				if (status < 0)
> -					break;
> -			}
>   			break;
>   		case FEC_5_6:
>   			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_5_6;
> -			if (state->type_A) {
> +			if (state->type_A)
>   				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C5_6, 0x0000);
> -				if (status < 0)
> -					break;
> -			}
>   			break;
>   		case FEC_7_8:
>   			transmissionParams |= SC_RA_RAM_OP_PARAM_RATE_7_8;
> -			if (state->type_A) {
> +			if (state->type_A)
>   				status = Write16(state, EC_VD_REG_SET_CODERATE__A, EC_VD_REG_SET_CODERATE_C7_8, 0x0000);
> -				if (status < 0)
> -					break;
> -			}
>   			break;
>   		}
>   		if (status < 0)
