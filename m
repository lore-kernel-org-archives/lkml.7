Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2252070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Vp0eDDlr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NLOH6mrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfC2KwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:52:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33868 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfC2KwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:52:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 25BA7609EF; Fri, 29 Mar 2019 10:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553856722;
        bh=essToEIcCTNvLPu5mt/t0Elx3d7fe7Lc+kjJfRRdkcE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vp0eDDlrDjejJ+R+GCPWGiDnTPiLwgUhVaBbxk+pBW5CupaIGTA4YjewnJ5lPyhnS
         NRBlkAbOsTEI2GXAfS/I0FbQHygRQd6ikYqipR9RbqlsUR3m59wX0xEKb+s4xFQJRY
         9dzOdyTbyDrlBe0tS1PsfryumfT1eziE1ManacuE=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 17FB8608CC;
        Fri, 29 Mar 2019 10:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553856721;
        bh=essToEIcCTNvLPu5mt/t0Elx3d7fe7Lc+kjJfRRdkcE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NLOH6mrfNdkVaFORiB7V13l6fP5xhm6S9LdM4IlnPgPJQAY2yvYWhFDVqjDlyH1kO
         mT3ybOLmi9y2hZeuGh+6Phgz56OWu4r+bdDJYtAykv+vHEvVOfyobLTg2vdtfTC6wM
         tHGaN/fj/62Rawcu7eCybAXqNpKPSK28nx0UjaHk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 17FB8608CC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] regulator: vctrl: Remove unneeded continue statement
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20190329014631.17999-1-axel.lin@ingics.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <50d35378-9cb4-8b56-9190-0470bf2648f2@codeaurora.org>
Date:   Fri, 29 Mar 2019 16:21:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329014631.17999-1-axel.lin@ingics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 7:16 AM, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@ingics.com>


Yeah indeed! but where is commit text atleast a one-liner.

Otherwise looks good to me.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


> ---
>   drivers/regulator/vctrl-regulator.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
> index 78de002037c7..259864520a06 100644
> --- a/drivers/regulator/vctrl-regulator.c
> +++ b/drivers/regulator/vctrl-regulator.c
> @@ -334,10 +334,8 @@ static int vctrl_init_vtable(struct platform_device *pdev)
>   		ctrl_uV = regulator_list_voltage(ctrl_reg, i);
>   
>   		if (ctrl_uV < vrange_ctrl->min_uV ||
> -		    ctrl_uV > vrange_ctrl->max_uV) {
> +		    ctrl_uV > vrange_ctrl->max_uV)
>   			rdesc->n_voltages--;
> -			continue;
> -		}
>   	}
>   
>   	if (rdesc->n_voltages == 0) {
