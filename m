Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47213C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D30D2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560865670;
	bh=ex6B0eU+nOg754XhdmfknhC2aHUm3CdLH/WdTm5Ma1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mZM83gQyrHO8R1VoOkPv3aQtf72VMJsLX+HozQ1dXuBRD1qYix/4dug4sugNQnZ0X
	 A41pW/YkaW+VuHyvVqmDmU9atvDkbhJRmkTSSiHXji2wEiypWA90o4b3tAgCMDFEiw
	 Bz8WPcSZFEk/Vb9VXIlMup/PNrjk9mP7YiEwNhZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfFRNrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFRNrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:47:48 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D462820873;
        Tue, 18 Jun 2019 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560865667;
        bh=ex6B0eU+nOg754XhdmfknhC2aHUm3CdLH/WdTm5Ma1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2p4RIl0h+y7vm1MTexI6/8VCUL8s+z3hoP+M2WhA14d+oxlLLuYYTFCiAUaKm0yMQ
         erii8rrepu5XirKNOuoS8JIJ7Zi4y6oSoV1b0DwHxlQFdKGqUGu+ELCjCyf4qOR/Gk
         +E7MsKxLfOpYQFLG0XdEGwS/7MpZvor8R0QnhiPo=
Date:   Tue, 18 Jun 2019 21:46:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     jun.nie@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Arm: zx: remove redundant dev_err message
Message-ID: <20190618134634.GL1959@dragon>
References: <1560843541-11611-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560843541-11611-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 03:39:01PM +0800, Ding Xiang wrote:
> devm_ioremap_resource already contains error message, so remove
> the redundant dev_err message
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Arnd, Olof,

Can you please apply it to arm-soc tree?  Thanks.

Shawn

> ---
>  arch/arm/mach-zx/zx296702-pm-domain.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-zx/zx296702-pm-domain.c b/arch/arm/mach-zx/zx296702-pm-domain.c
> index 7a08bf9d..ac44ea8 100644
> --- a/arch/arm/mach-zx/zx296702-pm-domain.c
> +++ b/arch/arm/mach-zx/zx296702-pm-domain.c
> @@ -169,10 +169,8 @@ static int zx296702_pd_probe(struct platform_device *pdev)
>  	}
>  
>  	pcubase = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(pcubase)) {
> -		dev_err(&pdev->dev, "ioremap fail.\n");
> +	if (IS_ERR(pcubase))
>  		return -EIO;
> -	}
>  
>  	for (i = 0; i < ARRAY_SIZE(zx296702_pm_domains); ++i)
>  		pm_genpd_init(zx296702_pm_domains[i], NULL, false);
> -- 
> 1.9.1
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
