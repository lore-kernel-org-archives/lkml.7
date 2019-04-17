Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A6C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8548320693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M2APMcox";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BN2PP0Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729901AbfDQGb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:31:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfDQGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:31:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 290BF60907; Wed, 17 Apr 2019 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555482685;
        bh=HQXq3NgF3tyRYydYhPRkw5TJvBmleRQ9ra25bsKrqIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M2APMcoxsT6ejRZJQ8YMfdEj7tNX+pjSDdy6dGV8Aj26j5jDxwUVIxEkLmc9XuQd6
         FlVkbRFPIBWOeL80MyQfqUh63LFGIXT0G4QEyI+O2jlN8K/+GG5Wa+gAS2IRdx6dH4
         H0MxvWxJc73G3J67QV6nFHVNxEWs1LMosO/fOxFA=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A172860770;
        Wed, 17 Apr 2019 06:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555482684;
        bh=HQXq3NgF3tyRYydYhPRkw5TJvBmleRQ9ra25bsKrqIs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BN2PP0Z91g9bG2uAeS8yBsAKGke6JJbUv3xiOxIH8e0lbFf3vZpkdC2jQl9fIL6N8
         SZpiuXghd8xKJ/FBDmqP8yxbnHkiC0ihtS52gEvjVfU0sQQcd5aG+Q3nbTUcUdR4VT
         ZnD/tqkhShP7SFlT2X5dlyH3Q+WNWidCY1gLQHOs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A172860770
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] watchdog: intel_scu_watchdog: fix spelling mistake:
 "set_hearbeat" -> "set_heartbeat"
To:     Colin King <colin.king@canonical.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190416133318.21045-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <8149cea7-d7dd-2907-3f85-caba792b7cf0@codeaurora.org>
Date:   Wed, 17 Apr 2019 12:01:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416133318.21045-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/16/2019 7:03 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/watchdog/intel_scu_watchdog.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
> index 0caab6241eb7..718f7db35bec 100644
> --- a/drivers/watchdog/intel_scu_watchdog.c
> +++ b/drivers/watchdog/intel_scu_watchdog.c
> @@ -224,7 +224,7 @@ static int intel_scu_set_heartbeat(u32 t)
>   		 watchdog_device.timer_tbl_ptr->freq_hz);
>   	pr_debug("set_heartbeat: timer_set is %x (hex)\n",
>   		 watchdog_device.timer_set);
> -	pr_debug("set_hearbeat: timer_margin is %x (hex)\n", timer_margin);
> +	pr_debug("set_heartbeat: timer_margin is %x (hex)\n", timer_margin);
>   	pr_debug("set_heartbeat: threshold is %x (hex)\n",
>   		 watchdog_device.threshold);
>   	pr_debug("set_heartbeat: soft_threshold is %x (hex)\n",
