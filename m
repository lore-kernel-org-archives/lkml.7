Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEFEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1FF21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EFFuR6XJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z4D/gObW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCTT6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:58:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:58:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5980F609EF; Wed, 20 Mar 2019 19:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553111920;
        bh=ugm8ZNWOBPIYuLvO4AjDptBU5b5201T/buUPTTOlkTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EFFuR6XJ4Un4tIrMDtL/7aOftOfgBkdwEKh8hnFc6qCWkvm0o5Y5xFbsw9a1gHPYA
         B8BXVyf8pwjWK9PSvTDQshi22giMh74FUqULl+3yPixR0FFMD1IUl/aajdq0dOAw0L
         o/upaNIXAWwu7myUCcn2a6IiCzursaC0cZ3r2d1Y=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D02960237;
        Wed, 20 Mar 2019 19:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553111918;
        bh=ugm8ZNWOBPIYuLvO4AjDptBU5b5201T/buUPTTOlkTQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Z4D/gObWJ8mT+sO1qGziodtLANz/q9OoFtJ9BQBfBMHwmiTA4lS0kIUwEGEeKwF76
         vUj0ZN7PVxs1p7ExG2sBwbWBXiI/b1tUGVcPOJcSp7aRD4kV4yjQ7YedXjntaLakew
         d3T6usXB2ygfE2J3jH08MaJlqUcllF144bn0ZZAg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D02960237
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] pinctrl: fsl: Make pinctrl_ipc_handle static
To:     Yue Haibing <yuehaibing@huawei.com>, aisheng.dong@nxp.com,
        festevam@gmail.com, shawnguo@kernel.org, stefan@agner.ch,
        kernel@pengutronix.de, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20190320141425.20920-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <38d8265b-52b9-f7fd-d665-46b66848118a@codeaurora.org>
Date:   Thu, 21 Mar 2019 01:28:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320141425.20920-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 7:44 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/pinctrl/freescale/pinctrl-scu.c:38:19: warning:
>   symbol 'pinctrl_ipc_handle' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/pinctrl/freescale/pinctrl-scu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
> index 83e69c0..73bf1d9 100644
> --- a/drivers/pinctrl/freescale/pinctrl-scu.c
> +++ b/drivers/pinctrl/freescale/pinctrl-scu.c
> @@ -35,7 +35,7 @@ struct imx_sc_msg_resp_pad_get {
>   	u32 val;
>   } __packed;
>   
> -struct imx_sc_ipc *pinctrl_ipc_handle;
> +static struct imx_sc_ipc *pinctrl_ipc_handle;
>   
>   int imx_pinctrl_sc_ipc_init(struct platform_device *pdev)
>   {


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>



