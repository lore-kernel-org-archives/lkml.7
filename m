Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36996C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22CB2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SO10mZ6d";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GzAwg1Z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfC0Nps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:45:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48376 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfC0Npr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:45:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06E5E61515; Wed, 27 Mar 2019 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694347;
        bh=Ri8sATTHHY1ipbEGSGdC1GIw+13UiVLSRf7KhukWh00=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SO10mZ6dbuZ3uSLJzUgj8UFaE+IUlAWpi02iSvjX5u8WWlVU0AeddstRpD5pxOww+
         TP6L3F6aCz5dK+PxuaVLNEdsNEiQlG6G40e7AtlQBySPjqtRo90zXXxhilpHP3TZlo
         Vc1VqK3Hfnjc37ZAOhpdiWjRxyFw9VEsmJbFR74g=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DBB760FE9;
        Wed, 27 Mar 2019 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553694339;
        bh=Ri8sATTHHY1ipbEGSGdC1GIw+13UiVLSRf7KhukWh00=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GzAwg1Z8uAxzL4lX/r1r8jd+5MiDNoh3lRxw1vNu7PfddH2tGLGleeWus/u1MlQlO
         4v2N/DKsfm5him4LNcske9eQ6ojIenyPTmr4iRLivmV+KhS7jvHj3mRLMlNgJFJpm/
         /NFQc20yD9/t2DC04nK7AsOva9t1u9TN09bw+vqQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DBB760FE9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v1 1/1] MAINTAINERS: fix typo in file name
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, joe@perches.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
References: <20190325212450.25865-1-joe@perches.com>
 <8ea01476a26ce5eb059b667181262f91873b87c5.1553577179.git.amit.kucheria@linaro.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <d30002f8-d32d-3672-b0af-7890a2244697@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:15:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <8ea01476a26ce5eb059b667181262f91873b87c5.1553577179.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/26/2019 10:48 AM, Amit Kucheria wrote:
> Replace underscore with dash.
>
> Fixes: e31f941cf977 ("MAINTAINERS: update list of qcom drivers")
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>


Please write appropriate commit text as why are you doing this .

Otherwise looks  good.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..d2c5852a3c8d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2007,7 +2007,7 @@ F:	drivers/i2c/busses/i2c-qup.c
>   F:	drivers/i2c/busses/i2c-qcom-geni.c
>   F:	drivers/mfd/ssbi.c
>   F:	drivers/mmc/host/mmci_qcom*
> -F:	drivers/mmc/host/sdhci_msm.c
> +F:	drivers/mmc/host/sdhci-msm.c
>   F:	drivers/pci/controller/dwc/pcie-qcom.c
>   F:	drivers/phy/qualcomm/
>   F:	drivers/power/*/msm*
