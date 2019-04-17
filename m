Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9727BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6648E21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cRC7gS/Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cRC7gS/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfDQMdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:33:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDQMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:33:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CA09760790; Wed, 17 Apr 2019 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555504409;
        bh=mIUl/lK3z8hrpza368ukUXruD7D/cbUW1PF08vtFFX8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cRC7gS/Y1jPcgIDg9RroVJzRPwRqOvngMwuiI392JJSkUw1GbrsaeMokuOkPeSlJW
         uMV15AhiJFmV/H2k1lOE12NaQbm0Bu6gsXgKelhJeYoQDUVLxJDbASfjh1F/WNXw5t
         +YXkPJnj1XU/87UmE+v3zb6SBi2qn89sUmmHhPuc=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3ADA26047C;
        Wed, 17 Apr 2019 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555504409;
        bh=mIUl/lK3z8hrpza368ukUXruD7D/cbUW1PF08vtFFX8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cRC7gS/Y1jPcgIDg9RroVJzRPwRqOvngMwuiI392JJSkUw1GbrsaeMokuOkPeSlJW
         uMV15AhiJFmV/H2k1lOE12NaQbm0Bu6gsXgKelhJeYoQDUVLxJDbASfjh1F/WNXw5t
         +YXkPJnj1XU/87UmE+v3zb6SBi2qn89sUmmHhPuc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3ADA26047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: rtl8723bs: fix spelling mistake: "nonprintabl"
 -> "non-printable"
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190417120047.20015-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <46e89cfc-ae55-2df3-b69a-1b70e145e6f9@codeaurora.org>
Date:   Wed, 17 Apr 2019 18:03:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417120047.20015-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2019 5:30 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in an RT_TRACE message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/staging/rtl8723bs/core/rtw_ioctl_set.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> index 0c8a050b2a81..bd75bca1ac6e 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ioctl_set.c
> @@ -44,7 +44,7 @@ u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid)
>   	for (i = 0; i < ssid->SsidLength; i++) {
>   		/* wifi, printable ascii code must be supported */
>   		if (!((ssid->Ssid[i] >= 0x20) && (ssid->Ssid[i] <= 0x7e))) {
> -			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid has nonprintabl ascii\n"));
> +			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("ssid has non-printable ascii\n"));
>   			ret = false;
>   			break;
>   		}
