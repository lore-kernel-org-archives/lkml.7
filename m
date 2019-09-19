Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185AAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D9D21920
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 21:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G2TUP4Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732915AbfISVGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 17:06:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbfISVGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g/acomoy8bQ166UWIwc95dw3bF0HNGAj/f+0MJXauXQ=; b=G2TUP4ZgB45ZMgR14amJD/Nvm
        s9C0zKAGlFawV8v12KARqVlZlKYqM73K6gyvvDM7u9lmHrhblKC5rHs8FMfiGOSXRxc0wEJhngpoB
        iBmBUG7UrGlHxCdsDcYC6Gu5QDsByefgJ5oeo0YvDFKDgn1yiUXGuEgRltlr/kZbBm3SZt5hHqqmO
        bqyJ3xLfWSxKE+fuIPgEmeIpC3vaKTCPi5BkCvz9a3xiI7iHtM3ZGLYtDIGNcrHT6o48VhwXhVs1W
        Ao5QxgxApdhQK4JAdBqKsFGklSRgErmRqQIgs9nT9E+OAYVmqSQTOlTYzk5bl9TxFM2urVcWl0hlT
        uxzcfJXsg==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iB3dG-0001XL-8f; Thu, 19 Sep 2019 21:06:30 +0000
Subject: Re: [PATCH] trivial: lib/Kconfig: typo modertion -> moderation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org
References: <20190919210314.22110-1-uwe@kleine-koenig.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a50d6b2-d420-1c32-7a23-29a2601d4da9@infradead.org>
Date:   Thu, 19 Sep 2019 14:06:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919210314.22110-1-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/19 2:03 PM, Uwe Kleine-König wrote:
> Fixes: 4f75da3666c0 ("linux/dim: Move implementation to .c files")
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 4e6b1c3e4c98..cc04124ed8f7 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -559,7 +559,7 @@ config DIMLIB
>  	default y
>  	help
>  	  Dynamic Interrupt Moderation library.
> -	  Implements an algorithm for dynamically change CQ modertion values
> +	  Implements an algorithm for dynamically change CQ moderation values

	                          to dynamically change
or
	                          for dynamically changing

>  	  according to run time performance.
>  
>  #
> 


-- 
~Randy
