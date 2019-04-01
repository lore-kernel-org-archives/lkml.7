Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF61BC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0CD20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZTGVhDDe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="h9DqxqPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfDAFrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:47:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAFrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:47:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F9BE60590; Mon,  1 Apr 2019 05:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554097622;
        bh=qUaRkBEouZeQXMblCwkEvjL4i30DovJ6dmggp65jgcg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZTGVhDDeB5VbILHeT45zGU9/+f6PR5Wtwa4lAGy7ErQRD9NSTzJ3/JDoARnsabiKl
         AzJcTquoZxqQzlFFqxr/U85rtzxvf4CEmekl3iTKbUp8ZL5QqVfaNqdzVgtplcbSfu
         qiI6N/IUeFv3WrcMGMtXY7q8CmMBYvBjxQPJR6RE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D0A3D60736;
        Mon,  1 Apr 2019 05:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554097621;
        bh=qUaRkBEouZeQXMblCwkEvjL4i30DovJ6dmggp65jgcg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=h9DqxqPdxhJblFSIZvoXZPxeCi0gdMkHW4kM2S2N15pqZXe/jpZOVuAJOxiYUqv+g
         gK2fBTT8XjuWPvPpNDgjj6RPcJ8d6KJw3G4SHhUr+JXemneSKEVcMv4Y0ONXRQ9Vgg
         csrkwAODVKZk8rhJ9pxHx4x3Od1Zg03nV6bx/MK8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D0A3D60736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 2/4] rtc: ps3: convert to SPDX identifier
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190320124428.14445-1-alexandre.belloni@bootlin.com>
 <20190320124428.14445-2-alexandre.belloni@bootlin.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1bc5452c-d88b-fbe0-5fa8-79e07f4fd6f6@codeaurora.org>
Date:   Mon, 1 Apr 2019 11:16:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190320124428.14445-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 6:14 PM, Alexandre Belloni wrote:
> Use SPDX-License-Identifier instead of a verbose license text.
>
> The original text refers to version 2 so also update MODULE_LICENSE() to
> "GPL v2" instead of "GPL".
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-ps3.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/rtc/rtc-ps3.c b/drivers/rtc/rtc-ps3.c
> index bffc5713e16f..7e2a941a195b 100644
> --- a/drivers/rtc/rtc-ps3.c
> +++ b/drivers/rtc/rtc-ps3.c
> @@ -1,20 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0


Should we not keep it like.
https://lkml.org/lkml/2019/2/13/570

Cheers,
Mukesh

>   /*
>    * PS3 RTC Driver
>    *
>    * Copyright 2009 Sony Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; version 2 of the License.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.
> - * If not, see <http://www.gnu.org/licenses/>.
>    */
>   
>   #include <linux/kernel.h>
> @@ -77,6 +65,6 @@ static struct platform_driver ps3_rtc_driver = {
>   module_platform_driver_probe(ps3_rtc_driver, ps3_rtc_probe);
>   
>   MODULE_AUTHOR("Sony Corporation");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>   MODULE_DESCRIPTION("ps3 RTC driver");
>   MODULE_ALIAS("platform:rtc-ps3");
