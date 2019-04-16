Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584E6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176D220857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IdqMuvmz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JhzNqlCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfDPHgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:36:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38690 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfDPHgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:36:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2657B61154; Tue, 16 Apr 2019 07:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555400182;
        bh=KJvPNGMIkVmBT+twJxK71P/zDBZLCBOg1IxHBnVJHhU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IdqMuvmz2H+cIDOVYkiN85QSkuu6jLTgf8JRwsdJNUMfdFwrP1aE1ymEMV3dgwr77
         n5j/QvsqCqomF2qhzx1kkR5LfV3GVqENSWgOT5DpQrZdvOGvR89PMM449gqJUEIFK0
         mbPvKVP90FkWW7MQTXX7F7cVirKu3t8fcSKDZ6To=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43C7361197;
        Tue, 16 Apr 2019 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555400180;
        bh=KJvPNGMIkVmBT+twJxK71P/zDBZLCBOg1IxHBnVJHhU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JhzNqlCXES4uHLPuT5/5cVIdwGfAJr7eV4n8PgHHfcTa335rOAHVSvJeSo6ApN88L
         yYP61tMWbcO87UDVqa3H6Sl14K/MF1304LKvPbvw24yIbN6vDcHZ8bRyWB2ujCyRA6
         pNA6E/cGTOBdrdBcP4Xlfss3kO5xqDc1xlsuZD8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 43C7361197
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] staging: comedi: adv_pci1710: fix spelling mistake:
 "droput" -> "dropout"
To:     Colin King <colin.king@canonical.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190415174945.32712-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a993b7c3-29c0-ea34-0b16-1e5f7607e004@codeaurora.org>
Date:   Tue, 16 Apr 2019 13:06:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190415174945.32712-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/15/2019 11:19 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a dev_error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/comedi/drivers/adv_pci1710.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/comedi/drivers/adv_pci1710.c b/drivers/staging/comedi/drivers/adv_pci1710.c
> index 6a93b04f1fdf..dbff0f7e7cf5 100644
> --- a/drivers/staging/comedi/drivers/adv_pci1710.c
> +++ b/drivers/staging/comedi/drivers/adv_pci1710.c
> @@ -317,7 +317,7 @@ static int pci1710_ai_read_sample(struct comedi_device *dev,
>   		chan = sample >> 12;
>   		if (chan != devpriv->act_chanlist[cur_chan]) {
>   			dev_err(dev->class_dev,
> -				"A/D data droput: received from channel %d, expected %d\n",
> +				"A/D data dropout: received from channel %d, expected %d\n",
>   				chan, devpriv->act_chanlist[cur_chan]);
>   			return -ENODATA;
>   		}
