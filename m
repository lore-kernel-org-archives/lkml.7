Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92313C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433EF2173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GoshSJat";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GoshSJat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFIcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:32:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57824 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:32:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A19D6083E; Sat,  6 Apr 2019 08:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554539521;
        bh=WI1CnWQDO2eaNXpmKxEgS//ftQz8Mifl9wpsvTxarhE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GoshSJatK4iw6dUwVf8jIEKFNc/hp1iHmnVdL4lsXF+M4G1vGrePn8IXv0qWoSfxt
         dW58JPfa9RDB4FWpVmArv1xN907c6dMd2aIs7hqcaSBNQzgB/hrobPAqStYoXPZYYr
         WfCUxg51rj1D2xFEBuSbi7Xv8fVdSe9QGvpqSdsY=
Received: from [10.79.167.84] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80B5E6083E;
        Sat,  6 Apr 2019 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554539521;
        bh=WI1CnWQDO2eaNXpmKxEgS//ftQz8Mifl9wpsvTxarhE=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GoshSJatK4iw6dUwVf8jIEKFNc/hp1iHmnVdL4lsXF+M4G1vGrePn8IXv0qWoSfxt
         dW58JPfa9RDB4FWpVmArv1xN907c6dMd2aIs7hqcaSBNQzgB/hrobPAqStYoXPZYYr
         WfCUxg51rj1D2xFEBuSbi7Xv8fVdSe9QGvpqSdsY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80B5E6083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH V2] staging: comedi: dt2811: Fix spelling mistake
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190406082319.GA4231@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <04d71813-2226-b30d-07d2-f0296d6aa900@codeaurora.org>
Date:   Sat, 6 Apr 2019 14:01:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406082319.GA4231@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 1:53 PM, Hariprasad Kelam wrote:
> changes interupts --> interrupts to fix warning reported by checkpatch
> tool
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
> Changes in v2:
>    - Make the Subject more clear by including changed file path.
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
