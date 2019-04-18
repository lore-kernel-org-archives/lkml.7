Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023C3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59E7214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gBdq5Dz+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gBdq5Dz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbfDRTDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:03:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49794 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfDRTDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:03:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A514F61344; Thu, 18 Apr 2019 19:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555614234;
        bh=UMKACQEF4lvLciPIWottq7xCrqsMT3j1PdQTbL2W9Zw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gBdq5Dz+sYYfqANkRKWO4FR+f+7cwU3BZ65bm7VrzUEPUfFbI5oJIW90db6sHvaVS
         IguWnoj6p2EbaYXl96yxVnIkhXA4Xcb2yr1Vy+QzuYDw0sKWUm3b9vYJHv1cGNhBMR
         O9K8X0DmkW/4L7obOCOYPkVScjpawBDj+I+9DsyA=
Received: from [10.79.161.32] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C2B46118C;
        Thu, 18 Apr 2019 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555614234;
        bh=UMKACQEF4lvLciPIWottq7xCrqsMT3j1PdQTbL2W9Zw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gBdq5Dz+sYYfqANkRKWO4FR+f+7cwU3BZ65bm7VrzUEPUfFbI5oJIW90db6sHvaVS
         IguWnoj6p2EbaYXl96yxVnIkhXA4Xcb2yr1Vy+QzuYDw0sKWUm3b9vYJHv1cGNhBMR
         O9K8X0DmkW/4L7obOCOYPkVScjpawBDj+I+9DsyA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C2B46118C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] ARM: kprobes: fix spelling mistake "undefeined" ->
 "undefined"
To:     Colin King <colin.king@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418173857.31285-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c0144664-aa17-7ae1-dedb-ec2723682f56@codeaurora.org>
Date:   Fri, 19 Apr 2019 00:33:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418173857.31285-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 11:08 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake on the TEST_UNSUPPORTED macro. Fix this.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   arch/arm/probes/kprobes/test-thumb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/probes/kprobes/test-thumb.c b/arch/arm/probes/kprobes/test-thumb.c
> index b683b4517458..6841909757cd 100644
> --- a/arch/arm/probes/kprobes/test-thumb.c
> +++ b/arch/arm/probes/kprobes/test-thumb.c
> @@ -787,7 +787,7 @@ CONDITION_INSTRUCTIONS(22,
>   
>   	TEST_UNSUPPORTED(__inst_thumb32(0xf7f08000) " @ smc #0")
>   
> -	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefeined")
> +	TEST_UNSUPPORTED(__inst_thumb32(0xf7f0a000) " @ undefined")
>   
>   	TEST_BF(  "b.w	2f")
>   	TEST_BB(  "b.w	2b")
