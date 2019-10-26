Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFACA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A8A205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 00:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfJZAgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 20:36:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbfJZAgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 20:36:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 489D4AC4D;
        Sat, 26 Oct 2019 00:36:38 +0000 (UTC)
Subject: Re: [PATCH v2 05/11] arm64: realtek: Select reset controller
To:     linux-realtek-soc@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20191023101317.26656-1-afaerber@suse.de>
 <20191023101317.26656-6-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <3a510c7a-d91c-524a-ad20-6572b88c31fe@suse.de>
Date:   Sat, 26 Oct 2019 02:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191023101317.26656-6-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.10.19 um 12:13 schrieb Andreas Färber:
> Select RESET_CONTROLLER for ARCH_REALTEK.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v2: New
>  
>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 63b463b88040..90d3c04ebff0 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -189,6 +189,7 @@ config ARCH_QCOM
>  
>  config ARCH_REALTEK
>  	bool "Realtek Platforms"
> +	select RESET_CONTROLLER
>  	help
>  	  This enables support for the ARMv8 based Realtek chipsets,
>  	  like the RTD1295.

Applied to linux-realtek.git v5.5/arm64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/arm64

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
