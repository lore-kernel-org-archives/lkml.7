Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8C720989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfEJVkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:40:06 -0400
Received: from muru.com ([72.249.23.125]:48374 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfEJVkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:40:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6A0A7808C;
        Fri, 10 May 2019 21:40:23 +0000 (UTC)
Date:   Fri, 10 May 2019 14:40:02 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Marc Zyngier <marc.zyngier@arm.com>, Tero Kristo <t-kristo@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        YueHaibing <yuehaibing@huawei.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: arch_k3: Fix kconfig dependency warning
Message-ID: <20190510214002.GV8007@atomide.com>
References: <20190510035255.27568-1-yuehaibing@huawei.com>
 <f7c420ec-ee4e-c17e-7650-353002bb81b9@ti.com>
 <86o94acgdg.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o94acgdg.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Marc Zyngier <marc.zyngier@arm.com> [190510 18:30]:
> On Fri, 10 May 2019 06:16:38 +0100,
> Lokesh Vutla <lokeshvutla@ti.com> wrote:
> > 
> > 
> > 
> > On 10/05/19 9:22 AM, YueHaibing wrote:
> > > Fix Kbuild warning when SOC_TI is not set
> > > 
> > > WARNING: unmet direct dependencies detected for TI_SCI_INTA_IRQCHIP
> > >   Depends on [n]: TI_SCI_PROTOCOL [=y] && SOC_TI [=n]
> > >   Selected by [y]:
> > >   - ARCH_K3 [=y]
> > > 
> > > Fixes: 009669e74813 ("arm64: arch_k3: Enable interrupt controller drivers")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > Thanks for catching it.
> > 
> > Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Tony, can you please route this patch via armsoc?

Thanks adding Tero to loop so he can queue it.

Regards,

Tony
