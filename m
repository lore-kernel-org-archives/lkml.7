Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA55DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A710220855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="To+QDyim";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ogfksduy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfDDKHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:07:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:07:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6EAD261196; Thu,  4 Apr 2019 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554372426;
        bh=Gvx+GSeLRF8fMRFVdIkbckROCXnorSjtVkrrnOXgURs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=To+QDyimpzpuQEG523RAZkdUbVq/DP6ezr6WlzBTFfcX0X3jeBFlIGzCBy9gbw9Dc
         gFlN0ZbWxB/iCKkBzt7kUrBjUe4/UIg2Igpgo50Ak10I2OEyvAj31Zaou17IlId6bo
         y2in0y1bLKm0AEFGzhBiGJletK9sVl8ghuMTxcO4=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18BCC60E40;
        Thu,  4 Apr 2019 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554372425;
        bh=Gvx+GSeLRF8fMRFVdIkbckROCXnorSjtVkrrnOXgURs=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ogfksduyx6cJloR2TV9QQwSLJinejNJS43z9rOW+NIy/IFGb0LgVFrm7gHwyDUGUQ
         RMgxGkdOToJjwbyLLg536ArBGEtqPp0ZEYS0zHKqZib+bAdDtS1V3c9mj4MaK7ZtKd
         IqyjVbfCneUSfyuKVTuNtZiMrA8cOBj733kh+N8s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18BCC60E40
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: comedi: Fix spelling mistake
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190404012404.GA2098@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <3ed1d62d-ac31-bfd0-fcb8-5a245923e828@codeaurora.org>
Date:   Thu, 4 Apr 2019 15:37:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404012404.GA2098@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 6:54 AM, Hariprasad Kelam wrote:
> changes interupts --> interrupts to fix warning reported by checkpatch
> tool
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/comedi/drivers/dt2811.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/comedi/drivers/dt2811.c b/drivers/staging/comedi/drivers/dt2811.c
> index 05207a5..8a1f9ef 100644
> --- a/drivers/staging/comedi/drivers/dt2811.c
> +++ b/drivers/staging/comedi/drivers/dt2811.c
> @@ -52,7 +52,7 @@
>   #define DT2811_ADCSR_ADBUSY		BIT(5)	/* r      1=A/D busy */
>   #define DT2811_ADCSR_CLRERROR		BIT(4)
>   #define DT2811_ADCSR_DMAENB		BIT(3)	/* r/w    1=dma ena */
> -#define DT2811_ADCSR_INTENB		BIT(2)	/* r/w    1=interupts ena */
> +#define DT2811_ADCSR_INTENB		BIT(2)	/* r/w    1=interrupts ena */
>   #define DT2811_ADCSR_ADMODE(x)		(((x) & 0x3) << 0)
>   
>   #define DT2811_ADGCR_REG		0x01	/* r/w  A/D Gain/Channel */
