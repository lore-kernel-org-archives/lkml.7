Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A282C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3F42067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfFEMKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:10:02 -0400
Received: from foss.arm.com ([217.140.101.70]:58748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFEMKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:10:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E52680D;
        Wed,  5 Jun 2019 05:10:01 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69E483F5AF;
        Wed,  5 Jun 2019 05:10:00 -0700 (PDT)
Date:   Wed, 5 Jun 2019 13:09:57 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, rmk+kernel@armlinux.org.uk,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: smp: Moved cpu_logical_map[] to smp.h
Message-ID: <20190605120957.GH15030@fuggles.cambridge.arm.com>
References: <20190603231830.24129-1-f.fainelli@gmail.com>
 <20190603231830.24129-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603231830.24129-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 04:18:29PM -0700, Florian Fainelli wrote:
> asm/smp.h is included by linux/smp.h and some drivers, in particular
> irqchip drivers can access cpu_logical_map[] in order to perform SMP
> affinity tasks. Make arm64 consistent with other architectures here.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/include/asm/smp.h      | 6 ++++++
>  arch/arm64/include/asm/smp_plat.h | 5 -----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Thanks. I'll grab this as a fix in an attempt to save you having to wait an
extra cycle before you can rely on it.

Will
