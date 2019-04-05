Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B2FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38E221850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 05:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cfHOmacq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KttP02Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDEFgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 01:36:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDEFgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 01:36:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 947FC60790; Fri,  5 Apr 2019 05:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554442581;
        bh=KADfR1jLsHMyswwbWgTFbGgDJvTJyGCYksS+okMNwA4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cfHOmacqGURGXVxXE/JSlL/CcVjmPkwuauwZf4Zxk5XIluHnhImbUnhiQaSHleC21
         IZrusvivgk3ZV4tBfxY5xln/5eYTn0u6z+kxuTfYYnqQ/ZetMr59Pv8XAAEWig4VFc
         dYb2bzQ8qnz27SmgwheIjnXhBYamJv9KaY2/NkkQ=
Received: from [10.252.218.116] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4E2D60790;
        Fri,  5 Apr 2019 05:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554442580;
        bh=KADfR1jLsHMyswwbWgTFbGgDJvTJyGCYksS+okMNwA4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KttP02KsGtTmTHvzxqZCnKvvRQFhbx4gqLtJs4lNrF6blkEUN8NdaHLIguW8I/7M+
         wHvPs5bu8X6/vfnotoSU3PZ2t3G/nzoGY0yOEbvx3/9cNawR1QgzJ6K7SrpScSN5Ta
         vcXbSIXqG2gu/V+RzShRSRjtBF6ZtHB09SD9kqRg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4E2D60790
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] extcon: axp288: Add a depends on ACPI to the Kconfig
 entry
To:     Yue Haibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, wens@csie.org, hdegoede@redhat.com,
        rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20190404104222.23900-1-yuehaibing@huawei.com>
 <20190404141748.27048-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9903c0fc-3016-49ea-0120-bab4eb857cf4@codeaurora.org>
Date:   Fri, 5 Apr 2019 11:06:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404141748.27048-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 7:47 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> As Hans de Goede pointed, using this driver without ACPI
> makes little sense, so add ACPI dependency to Kconfig entry
> to fix a build error while CONFIG_ACPI is not set.
>
> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>      put_device(&adev->dev);
>
> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This looks good too.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
> v2: rework patch
> ---
>   drivers/extcon/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 1ed4b45..de06faf 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -30,7 +30,7 @@ config EXTCON_ARIZONA
>   
>   config EXTCON_AXP288
>   	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_SUPPORT && X86
> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
>   	select USB_ROLE_SWITCH
>   	help
>   	  Say Y here to enable support for USB peripheral detection
