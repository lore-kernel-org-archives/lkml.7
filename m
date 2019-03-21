Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A5BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95AE218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfCUP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:59:28 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:43423 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:59:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 6A78D18613;
        Thu, 21 Mar 2019 16:59:25 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id nV0K6f8iwt5J; Thu, 21 Mar 2019 16:59:24 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id EBC2C18407;
        Thu, 21 Mar 2019 16:59:23 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBB761A098;
        Thu, 21 Mar 2019 16:59:23 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D08901A097;
        Thu, 21 Mar 2019 16:59:23 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu, 21 Mar 2019 16:59:23 +0100 (CET)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by thoth.se.axis.com (Postfix) with ESMTP id C36D91C49;
        Thu, 21 Mar 2019 16:59:23 +0100 (CET)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id BEC70800E1; Thu, 21 Mar 2019 16:59:23 +0100 (CET)
Date:   Thu, 21 Mar 2019 16:59:23 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jespern@axis.com, larper@axis.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@axis.com
Subject: Re: [PATCH -next] pinctrl: artpec6: Make two functions static
Message-ID: <20190321155923.z4jbelggbqp2vjio@axis.com>
References: <20190321150909.3576-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321150909.3576-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:09:09PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> drivers/pinctrl/pinctrl-artpec6.c:691:5: warning:
>  symbol 'artpec6_pmx_enable' was not declared. Should it be static?
> drivers/pinctrl/pinctrl-artpec6.c:705:6: warning:
>  symbol 'artpec6_pmx_disable' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  drivers/pinctrl/pinctrl-artpec6.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-artpec6.c b/drivers/pinctrl/pinctrl-artpec6.c
> index d89dc43..e836850 100644
> --- a/drivers/pinctrl/pinctrl-artpec6.c
> +++ b/drivers/pinctrl/pinctrl-artpec6.c
> @@ -688,8 +688,9 @@ static void artpec6_pmx_select_func(struct pinctrl_dev *pctldev,
>  	}
>  }
>  
> -int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
> -		       unsigned int group)
> +static int artpec6_pmx_enable(struct pinctrl_dev *pctldev,
> +			      unsigned int function,
> +			      unsigned int group)
>  {
>  	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
>  
> @@ -702,8 +703,9 @@ int artpec6_pmx_enable(struct pinctrl_dev *pctldev, unsigned int function,
>  	return 0;
>  }
>  
> -void artpec6_pmx_disable(struct pinctrl_dev *pctldev, unsigned int function,
> -			 unsigned int group)
> +static void artpec6_pmx_disable(struct pinctrl_dev *pctldev,
> +				unsigned int function,
> +				unsigned int group)
>  {
>  	struct artpec6_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
>  
> -- 
> 2.7.0

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
