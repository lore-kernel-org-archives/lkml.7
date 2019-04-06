Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA72C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2BA21855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 08:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A017AdHO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F9pfo1yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDFIWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 04:22:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54584 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDFIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 04:22:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D6F6607EB; Sat,  6 Apr 2019 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554538966;
        bh=fAEqmq4SZPRH29/8KkzFtOgoTobimx4vGoZbXYxD3i8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A017AdHO0g5a5iI4J2bmVbLm4HLsXGn9HIKr/i7Tfzp7Cq0tGAKhySsrZ1rdMY+07
         1KUGklua5pdQ6ci4bG4WQi4R2Q7tgx+yI5RzbaBVm52fbOW8p39aMqqo9csYoSxSWf
         ufRRx9TLC2MkR2Bz2PLGKir8j1tyC0alysCyLq64=
Received: from [10.79.167.84] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B83DD6083E;
        Sat,  6 Apr 2019 08:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554538965;
        bh=fAEqmq4SZPRH29/8KkzFtOgoTobimx4vGoZbXYxD3i8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F9pfo1yd/x+wcrtlUazYgk1lKXgxbJQdk71bHONz1eP5VHySqiUR4I3qp+wepHBO+
         jKe9lLkZfqDn4a40jrDg0U/PNEY+yO6ihfvDDABJRZlPGvtbUxmK+ISXaDGCE6juCW
         ah/IMtVZdYGkpqUM87CD+2sZBG71xzd0J6SPSHmU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B83DD6083E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] staging: rtl8192e: Remove set but not used variable
 'VenderID'
To:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190406031134.59419-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1a4f101a-6bb1-821b-2130-6590b8048948@codeaurora.org>
Date:   Sat, 6 Apr 2019 13:52:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406031134.59419-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 8:41 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/staging/rtl8192e/rtl8192e/rtl_pci.c: In function 'rtl92e_check_adapter':
> drivers/staging/rtl8192e/rtl8192e/rtl_pci.c:36:6: warning:
>   variable 'VenderID' set but not used [-Wunused-but-set-variable]
>    u16 VenderID;
>        ^
>
> It's never used and can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> index bab41ab7c0a5..1d992d5c4e17 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
> @@ -33,12 +33,10 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
>   bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
>   {
>   	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
> -	u16 VenderID;
>   	u16 DeviceID;
>   	u8  RevisionID;
>   	u16 IrqLine;
>   
> -	VenderID = pdev->vendor;
>   	DeviceID = pdev->device;
>   	RevisionID = pdev->revision;
>   	pci_read_config_word(pdev, 0x3C, &IrqLine);
>
>
>
