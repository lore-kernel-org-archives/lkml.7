Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023521773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hxC5qc3h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OQg1iZ4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfC1GjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:39:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54504 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1GjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:39:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 173C860790; Thu, 28 Mar 2019 06:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553755143;
        bh=CvV8zEEjHKku4QBZSmVmgrklKgbjoBhyrTSm1oxg51M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hxC5qc3hgxzi97K/1CcQcvleK/WBuKp3z/zJgGqaaxybn5xNzuMJGkQ5ZCK9rRlnM
         VuGDlyjC6aDs+3ducPlVlI8cc55P3mrWptLV1zS4yBXGuVJf7Nf0LgIX1LFg03P678
         d/QJY1m02Mo7edNHWhE0lGahCREy9sLF4LjdBN68=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 593A660364;
        Thu, 28 Mar 2019 06:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553755142;
        bh=CvV8zEEjHKku4QBZSmVmgrklKgbjoBhyrTSm1oxg51M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OQg1iZ4frIMrondasiLgK7xUd4C0UgI20zJnrAB9EYyaTo1YZDL+G/GV6wO3tm6B9
         Ojj/qKCP98HpDipryi/YBQ2Qk2EA1Gg/VL0OVvZtLNTOFyp7zSnZsaodS/BcDhEze4
         ZMYhPVusEEPVNjWR/pqh562SJWRZRkyetokSMh+I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 593A660364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] arch:sh:mach-sh03/rtc.c : Remove duplicate header
To:     jagdsh.linux@gmail.com, ysato@users.sourceforge.jp,
        dalias@libc.org, paul.burton@mips.com, arnd@arndb.de
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1553721642-38293-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b85268d2-939f-f012-ce3d-b6689dffe254@codeaurora.org>
Date:   Thu, 28 Mar 2019 12:08:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553721642-38293-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 2:50 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate header which is included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


> ---
>   arch/sh/boards/mach-sh03/rtc.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/sh/boards/mach-sh03/rtc.c b/arch/sh/boards/mach-sh03/rtc.c
> index 8b23ed7..165e2cc 100644
> --- a/arch/sh/boards/mach-sh03/rtc.c
> +++ b/arch/sh/boards/mach-sh03/rtc.c
> @@ -14,7 +14,6 @@
>   #include <linux/rtc.h>
>   #include <linux/spinlock.h>
>   #include <linux/io.h>
> -#include <linux/rtc.h>
>   #include <linux/platform_device.h>
>   
>   #define RTC_BASE	0xb0000000
