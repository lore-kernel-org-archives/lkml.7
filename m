Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD3AC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB70E20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbfFJMSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:18:48 -0400
Received: from muru.com ([72.249.23.125]:52548 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388833AbfFJMSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:18:47 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id DB2EB80CD;
        Mon, 10 Jun 2019 12:19:07 +0000 (UTC)
Date:   Mon, 10 Jun 2019 05:18:43 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     paul@pwsan.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH -next] ARM: OMAP2+: Make some variables static
Message-ID: <20190610121843.GY5447@atomide.com>
References: <20190413141744.34488-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413141744.34488-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Yue Haibing <yuehaibing@huawei.com> [190413 07:18]:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:532:25: warning: symbol 'am33xx_gpio_hwmod_class' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:542:19: warning: symbol 'am33xx_gpio1_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:562:19: warning: symbol 'am33xx_gpio2_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c:582:19: warning: symbol 'am33xx_gpio3_hwmod' was not declared. Should it be static?

I just noticed this is still pending, sorry for the delay. Applying into
omap-for-v5.3/soc.

Regards,

Tony
