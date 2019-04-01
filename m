Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC50C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0049F20857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MfoGtNdy";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BOe6ujs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfDAHxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:53:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47818 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732014AbfDAHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:53:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E10D61194; Mon,  1 Apr 2019 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105200;
        bh=b87ivs75IOvID4vpUXQhNrwRj99DNwwCUAO00xq4JdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MfoGtNdyNmWY+58Fu4yxQjvykoIX1JPmHjJiULFYNvXVPGSwk5uKHFEgjJHmXHsgU
         nWrsbpsVnL9ZGZ1eA8JJMy9Albttryz+jweoL7r3trAlzzzAp9mqrXDp8DPnyNeTfH
         4iuEDOc7a1cCQ6xxUJqiYTvMk6TT3OcmJ5A1tgWA=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32669609D4;
        Mon,  1 Apr 2019 07:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554105193;
        bh=b87ivs75IOvID4vpUXQhNrwRj99DNwwCUAO00xq4JdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BOe6ujs8H3/AK/Yj2q+sHylorkRF35/zN54p13jyB+Lf4vHWx9yG/7tMX/uVSHwIE
         13TR7YE8P2cCLWnpTK4l29uEjG6ClamMH6QGpY8vPFhkPbiyYCO9Kf0ImnqHjUUXl6
         wuAm2gs636sWxMcWP91KPEMCErhHjMrTQzg9s1tk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32669609D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] Staging: comedi: drivers: pcl818: Fixed a coding style
 error.
To:     Will Cunningham <wjcunningham7@gmail.com>, abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190331225336.GA26547@titus.pi.local>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <f45381e1-3509-af6b-b694-05788e6fa05f@codeaurora.org>
Date:   Mon, 1 Apr 2019 13:23:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331225336.GA26547@titus.pi.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 4:23 AM, Will Cunningham wrote:
> Removed unnecessary parentheses.`
Remove the extra character at the end.

Fix the above thing then you can take.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

>
> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
> ---
>   drivers/staging/comedi/drivers/pcl818.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/comedi/drivers/pcl818.c b/drivers/staging/comedi/drivers/pcl818.c
> index 0af5315d4357..da5d53a288f7 100644
> --- a/drivers/staging/comedi/drivers/pcl818.c
> +++ b/drivers/staging/comedi/drivers/pcl818.c
> @@ -1012,7 +1012,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>   		pcl818_alloc_dma(dev, it->options[2]);
>   
>   	/* use 1MHz or 10MHz oscilator */
> -	if ((it->options[3] == 0) || (it->options[3] == 10))
> +	if (it->options[3] == 0 || it->options[3] == 10)
>   		osc_base = I8254_OSC_BASE_10MHZ;
>   	else
>   		osc_base = I8254_OSC_BASE_1MHZ;
> @@ -1026,7 +1026,7 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>   	devpriv->ns_min = board->ns_min;
>   	if (!board->is_818) {
>   		/* extended PCL718 to 100kHz DAC */
> -		if ((it->options[6] == 1) || (it->options[6] == 100))
> +		if (it->options[6] == 1 || it->options[6] == 100)
>   			devpriv->ns_min = 10000;
>   	}
>   
> @@ -1067,12 +1067,12 @@ static int pcl818_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>   		s->maxdata	= 0x0fff;
>   		s->range_table	= &range_unipolar5;
>   		if (board->is_818) {
> -			if ((it->options[4] == 1) || (it->options[4] == 10))
> +			if (it->options[4] == 1 || it->options[4] == 10)
>   				s->range_table = &range_unipolar10;
>   			if (it->options[4] == 2)
>   				s->range_table = &range_unknown;
>   		} else {
> -			if ((it->options[5] == 1) || (it->options[5] == 10))
> +			if (it->options[5] == 1 || it->options[5] == 10)
>   				s->range_table = &range_unipolar10;
>   			if (it->options[5] == 2)
>   				s->range_table = &range_unknown;
