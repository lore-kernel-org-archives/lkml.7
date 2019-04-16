Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D78C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F262075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eI5lyWqX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VWZsRDCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfDPG6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:58:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbfDPG6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:58:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1540A608D4; Tue, 16 Apr 2019 06:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555397893;
        bh=xkYts39MEJAK8g8EIi9wJOxU/vlUuyMyWYyA/Shlmfc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eI5lyWqXvu0CFcpMBQngaVD9C7R7BHDu2ZrkOogsXAwEYeXmOEKLkcqAvfq455dxj
         nnPHJxKecleUKc+0OQIzAAsJ99nmWD2U4Eiwh48HlEqIJXnUzZgp8Lt8hQq23JtRj0
         7cygBYjniZcZwGSq1wTAMlhzqZS0RYL+zV59Gxmo=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA442608D4;
        Tue, 16 Apr 2019 06:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555397892;
        bh=xkYts39MEJAK8g8EIi9wJOxU/vlUuyMyWYyA/Shlmfc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VWZsRDCkvBeKkxY1l1CxhQg6wGbiJ8yAqlblexrUMGhDNZG+vKcpZA1VRfsR6Hq1B
         M22k1eHoOB3jsRw3Jvftrd5oBDwUmbR1nZvLAhUzjGfSD0aspOlWJTFjDvx7vt1Ypp
         muE+fW2wN49PuzWKv0ftFrWfKBj5hIqAn2nJO+uk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA442608D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: fix spelling mistake
 "capabilites" -> "capabilities"
To:     Colin King <colin.king@canonical.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190415125204.7386-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <520f6626-246b-005f-53ef-df2f75a89cd9@codeaurora.org>
Date:   Tue, 16 Apr 2019 12:24:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415125204.7386-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2019 6:22 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a module parameter description. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/platform/x86/thinkpad_acpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 57d9ae9d8e56..9192b686e9a6 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10269,7 +10269,7 @@ MODULE_PARM_DESC(volume_mode,
>   
>   module_param_named(volume_capabilities, volume_capabilities, uint, 0444);
>   MODULE_PARM_DESC(volume_capabilities,
> -		 "Selects the mixer capabilites: 0=auto, 1=volume and mute, 2=mute only");
> +		 "Selects the mixer capabilities: 0=auto, 1=volume and mute, 2=mute only");
>   
>   module_param_named(volume_control, volume_control_allowed, bool, 0444);
>   MODULE_PARM_DESC(volume_control,
