Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BBBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1002082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lQxxN/HW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lQxxN/HW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfDCF64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:58:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38102 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCF64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:58:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AB933609D4; Wed,  3 Apr 2019 05:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554271135;
        bh=uuSYTyz7mm/ToHFKa9hdTlKmu72P3FgW+DmjCgy4KRE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lQxxN/HWph457HJvZQ9GQP5K1RYzP1qqcjj2a0+RdtRIMXtDK4YO6KYDoaErpfKc1
         Uu6beMpuWhyqZzIVjC5YdFcK7OgKYUcs66fftG0Xl0PldYDpv7XC1Z89IAgj620y6s
         WdFEibfVnlfyt5/wzSPTaSaN1rtMBPiJ6OLTID2o=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60C9A602F2;
        Wed,  3 Apr 2019 05:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554271135;
        bh=uuSYTyz7mm/ToHFKa9hdTlKmu72P3FgW+DmjCgy4KRE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lQxxN/HWph457HJvZQ9GQP5K1RYzP1qqcjj2a0+RdtRIMXtDK4YO6KYDoaErpfKc1
         Uu6beMpuWhyqZzIVjC5YdFcK7OgKYUcs66fftG0Xl0PldYDpv7XC1Z89IAgj620y6s
         WdFEibfVnlfyt5/wzSPTaSaN1rtMBPiJ6OLTID2o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60C9A602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 1/3] habanalabs: remove extra semicolon
To:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
References: <20190402170709.29562-1-oded.gabbay@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <74f65488-9516-f2b5-61a7-1067529d1379@codeaurora.org>
Date:   Wed, 3 Apr 2019 11:28:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402170709.29562-1-oded.gabbay@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/2019 10:37 PM, Oded Gabbay wrote:
> This patch removes an extra ; after the closing brackets of a while loop.
>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/misc/habanalabs/device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> index e3797f582436..6cbfd560721e 100644
> --- a/drivers/misc/habanalabs/device.c
> +++ b/drivers/misc/habanalabs/device.c
> @@ -1044,7 +1044,7 @@ void hl_device_fini(struct hl_device *hdev)
>   			WARN(1, "Failed to remove device because reset function did not finish\n");
>   			return;
>   		}
> -	};
> +	}
>   
>   	/* Mark device as disabled */
>   	hdev->disabled = true;
