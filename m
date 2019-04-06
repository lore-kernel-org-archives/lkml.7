Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91541C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B8321855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mGf2V3MI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NnPui2XG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDFIU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:20:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfDFIU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:20:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57A5D609EF; Sat,  6 Apr 2019 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554538857;
        bh=F61dPknUYEq10SfECyXYJPq1M9nkxft4tIEluXIi9DA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mGf2V3MI7VK/vIGGPh/b5l27YzVEcD4hGAeVZUXriSe5e2h8fas/fRZvNCrtVj81k
         UXs4dBv/ngBnssd/pQY4d6PhOlJrg69LBgA4mjIaIoxpYCrJjkIQjBfCg9rr+7/UFV
         miLzhjMHcMbJAB7a2jT5fPqg6jhhp7zMppUOIa+k=
Received: from [10.79.167.84] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AA7376083E;
        Sat,  6 Apr 2019 08:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554538856;
        bh=F61dPknUYEq10SfECyXYJPq1M9nkxft4tIEluXIi9DA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NnPui2XGECtNa73Vi/udAZuyTOM67qtf+XSts6zXdy7ONrD6MVwPcYHbJQywlB7c7
         XrM5ie9xyiJuWgiFDYxpy/cgmBNyQHJTx/8AH8GyN5xP9yZ2bVwJzMq4OHdO0W5Ktn
         EQOwgRHkmnvoYlfCeskD7DsUatSUkqk6pvPW6fH0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AA7376083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] staging: comedi: dyna_pci10xx: remove set but not
 used variables 'chan' and range'
To:     YueHaibing <yuehaibing@huawei.com>, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190406030749.56659-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <364f1d1b-c32f-3066-6e8e-686c7acc7ac9@codeaurora.org>
Date:   Sat, 6 Apr 2019 13:50:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406030749.56659-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 8:37 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/staging/comedi/drivers/dyna_pci10xx.c: In function 'dyna_pci10xx_insn_write_ao':
> drivers/staging/comedi/drivers/dyna_pci10xx.c:109:21: warning:
>   variable 'range' set but not used [-Wunused-but-set-variable]
>    unsigned int chan, range;
>
> drivers/staging/comedi/drivers/dyna_pci10xx.c:109:15: warning:
>   variable 'chan' set but not used [-Wunused-but-set-variable]
>    unsigned int chan, range;
>
> They are never used since introduction in commit 16a7373a8e14 ("Staging:
> comedi: add dyna_pci10xx driver")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/comedi/drivers/dyna_pci10xx.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/staging/comedi/drivers/dyna_pci10xx.c b/drivers/staging/comedi/drivers/dyna_pci10xx.c
> index 9bdd5bf2eb99..d38bfc6113e8 100644
> --- a/drivers/staging/comedi/drivers/dyna_pci10xx.c
> +++ b/drivers/staging/comedi/drivers/dyna_pci10xx.c
> @@ -106,10 +106,6 @@ static int dyna_pci10xx_insn_write_ao(struct comedi_device *dev,
>   {
>   	struct dyna_pci10xx_private *devpriv = dev->private;
>   	int n;
> -	unsigned int chan, range;
> -
> -	chan = CR_CHAN(insn->chanspec);
> -	range = range_codes_pci1050_ai[CR_RANGE((insn->chanspec))];
>   
>   	mutex_lock(&devpriv->mutex);
>   	for (n = 0; n < insn->n; n++) {
>
>
>
>
>
