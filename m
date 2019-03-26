Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DCCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73C220828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553578216;
	bh=NFrxkNPGFBsEEQPv7oeZr5uMcnQX3wnIMF2eToZeqBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MyGmc/2f3Rw28h7vHnHYlIq9rljEd1PoUd9GwsbfQCXi7e0VVkxE+UnvKF3WjA7v3
	 7r7qWC7chRs5xkWyxBF1tpzHQAEDZ0AqPSNOau5Bdj1tBBSvVSSwxW9rzy6rzesAoz
	 xzPmKXMfNPNVYqVJddVrh2o6cwGgA1FVwfBYbpcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfCZFaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfCZFaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:30:15 -0400
Received: from localhost (unknown [171.61.95.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD07620828;
        Tue, 26 Mar 2019 05:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553578214;
        bh=NFrxkNPGFBsEEQPv7oeZr5uMcnQX3wnIMF2eToZeqBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GnYXVCZ/ztGIJOvLPZhZVabj97ynwKOJ2eG42n5wmXDzaHyccWH56yrxtDldDd6r4
         bJvbjLgRo4Bl3At6Actw5hUYZwo4MipiYwR6fQ342ufcSVSlyboMK+V+ZHwsHAJkPV
         I/Z7hF90uSjXS8l01cZWveiL4hUunGg2iTtY1IDo=
Date:   Tue, 26 Mar 2019 11:00:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 1/1] MAINTAINERS: fix typo in file name
Message-ID: <20190326053009.GW5348@vkoul-mobl>
References: <cover.1553577179.git.amit.kucheria@linaro.org>
 <8ea01476a26ce5eb059b667181262f91873b87c5.1553577179.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ea01476a26ce5eb059b667181262f91873b87c5.1553577179.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-03-19, 10:48, Amit Kucheria wrote:
> Replace underscore with dash.
> 
> Fixes: e31f941cf977 ("MAINTAINERS: update list of qcom drivers")
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Vinod Koul <vkoul@kernel.org>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..d2c5852a3c8d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2007,7 +2007,7 @@ F:	drivers/i2c/busses/i2c-qup.c
>  F:	drivers/i2c/busses/i2c-qcom-geni.c
>  F:	drivers/mfd/ssbi.c
>  F:	drivers/mmc/host/mmci_qcom*
> -F:	drivers/mmc/host/sdhci_msm.c
> +F:	drivers/mmc/host/sdhci-msm.c
>  F:	drivers/pci/controller/dwc/pcie-qcom.c
>  F:	drivers/phy/qualcomm/
>  F:	drivers/power/*/msm*
> -- 
> 2.17.1

-- 
~Vinod
