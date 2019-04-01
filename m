Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB4FC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E92B20850
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 05:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XnsujHgE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JOWyT+Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfDAFub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 01:50:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36512 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfDAFua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 01:50:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 15E71607C6; Mon,  1 Apr 2019 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554097830;
        bh=CVk3947aZDf0VDC7kHmg6Cdx5x3CAOuoEiyyVElhuK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XnsujHgE/TCLRS0ZDhPvWQncXVeb7q87uzjC2C9++aup3S1UySU4IyjscfQIAVBu1
         RxTbx++NuBgLXt11BG19sm5zIcvV91O6FA4ktGRrmRbHX4dlKzwmQqmIwfffbutC4b
         SLMkZjPDiB0U766I84ftH2/Q9l8/NqXKdgYmd7rM=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0183607C6;
        Mon,  1 Apr 2019 05:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554097829;
        bh=CVk3947aZDf0VDC7kHmg6Cdx5x3CAOuoEiyyVElhuK8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JOWyT+DxMVjhboFScia9g6UeRgvBGY9Dr4RGPrYqRDZCQs5tlRWkYsmzLkf5vbhKZ
         75Vgf/tM6zuCswyLmTQcqrGi76Vn6CwP166JdERO+Cc6BXSWCNBKkOLSZhQdeUorD4
         DmTtgXTRR18Nf4ZTG8nrZokAR5CuBAdikpC2wzIA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0183607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 3/7] rtc: xgene: convert to SPDX identifier
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190320123233.13519-1-alexandre.belloni@bootlin.com>
 <20190320123233.13519-3-alexandre.belloni@bootlin.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6dc833be-ed4b-a090-2df7-846ac1c59fc4@codeaurora.org>
Date:   Mon, 1 Apr 2019 11:20:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190320123233.13519-3-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 6:02 PM, Alexandre Belloni wrote:
> Use SPDX-License-Identifier instead of a verbose license text.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com


Please refer https://lkml.org/lkml/2019/2/13/570 for more discussion on 
this.
once you fix that in all your SPDX license patches,you can take mine.,

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/rtc/rtc-xgene.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
> index e360f8917556..ba9121d02f02 100644
> --- a/drivers/rtc/rtc-xgene.c
> +++ b/drivers/rtc/rtc-xgene.c
> @@ -1,23 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * APM X-Gene SoC Real Time Clock Driver
>    *
>    * Copyright (c) 2014, Applied Micro Circuits Corporation
>    * Author: Rameshwar Prasad Sahu <rsahu@apm.com>
>    *         Loc Ho <lho@apm.com>
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> - *
>    */
>   
>   #include <linux/init.h>
