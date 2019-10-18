Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8785FCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F7621852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505101AbfJRO56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:57:58 -0400
Received: from muru.com ([72.249.23.125]:38060 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410340AbfJRO55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:57:57 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 39607809F;
        Fri, 18 Oct 2019 14:58:31 +0000 (UTC)
Date:   Fri, 18 Oct 2019 07:57:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     khilman@kernel.org, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ARM: OMAP2+: Make some functions static
Message-ID: <20191018145753.GO5610@atomide.com>
References: <20191018120701.29364-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018120701.29364-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* YueHaibing <yuehaibing@huawei.com> [191018 12:08]:
> Fix sparse warnings:
> 
> arch/arm/mach-omap2/pmic-cpcap.c:29:15: warning: symbol 'omap_cpcap_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:43:15: warning: symbol 'omap_cpcap_uv_to_vsel' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:93:15: warning: symbol 'omap_max8952_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:107:15: warning: symbol 'omap_max8952_uv_to_vsel' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:140:15: warning: symbol 'omap_fan535503_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:155:15: warning: symbol 'omap_fan535508_vsel_to_uv' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:173:15: warning: symbol 'omap_fan535503_uv_to_vsel' was not declared. Should it be static?
> arch/arm/mach-omap2/pmic-cpcap.c:192:15: warning: symbol 'omap_fan535508_uv_to_vsel' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks applying into omap-for-v5.5/pm.

Regards,

Tony
