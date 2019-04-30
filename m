Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964DDC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6492E21707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c1sgpEK0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NGszjabW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfD3PPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:15:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3PPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:15:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 69801608CC; Tue, 30 Apr 2019 15:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556637300;
        bh=kDESwusWoNlcpai8Hhzx6F56ctP3yrdln4AYiKvAfV8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c1sgpEK08p4Viz1h4LYj6Cao84cdjI9PfQEvvyfI2gC39lQMqATS6Vkz71eAMRVk3
         zyt5lnrSlAjG7+XHdk43lmCcVZDoZb1OcSMoeZQdD6E9XJtgTDSglUbvKlaR2HlK9t
         cT9RuN6onAqG5g2PjoKlCBgXH5v8KybDokVHBUMg=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16EA8608CC;
        Tue, 30 Apr 2019 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556637299;
        bh=kDESwusWoNlcpai8Hhzx6F56ctP3yrdln4AYiKvAfV8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NGszjabWnBd3WE0yIF9zNcz+MIBW+FGB93qE1XbqQJ+DH2UPbDykJ+hFrUPjmcATt
         r3bgvbM+XpxTGm3mQL3GjIbKdnp1NetdzGhwtEs1avU4Px9/GQo15OcXqLiwOTDXc/
         yDsyxNQk2xgEu2pFXBa4Zk8JSiPwXwJhNUlR6zpM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16EA8608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] firmware_loader: Fix a typo ("syfs" -> "sysfs")
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190430145610.1291-1-j.neuschaefer@gmx.net>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a87e799e-73d3-6971-2df5-59ba34fb1446@codeaurora.org>
Date:   Tue, 30 Apr 2019 20:44:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430145610.1291-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/30/2019 8:26 PM, Jonathan Neuschäfer wrote:
> "sysfs" was misspelled in a comment and a log message.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/base/firmware_loader/fallback.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index b5c865fe263b..f962488546b6 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -674,8 +674,8 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
>    *
>    * This function is called if direct lookup for the firmware failed, it enables
>    * a fallback mechanism through userspace by exposing a sysfs loading
> - * interface. Userspace is in charge of loading the firmware through the syfs
> - * loading interface. This syfs fallback mechanism may be disabled completely
> + * interface. Userspace is in charge of loading the firmware through the sysfs
> + * loading interface. This sysfs fallback mechanism may be disabled completely
>    * on a system by setting the proc sysctl value ignore_sysfs_fallback to true.
>    * If this false we check if the internal API caller set the @FW_OPT_NOFALLBACK
>    * flag, if so it would also disable the fallback mechanism. A system may want
> @@ -693,7 +693,7 @@ int firmware_fallback_sysfs(struct firmware *fw, const char *name,
>   		return ret;
>
>   	if (!(opt_flags & FW_OPT_NO_WARN))
> -		dev_warn(device, "Falling back to syfs fallback for: %s\n",
> +		dev_warn(device, "Falling back to sysfs fallback for: %s\n",
>   				 name);
>   	else
>   		dev_dbg(device, "Falling back to sysfs fallback for: %s\n",
> --
> 2.20.1
>
