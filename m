Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF212C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE99E20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfEONtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:49:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfEONtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:49:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97A5F374;
        Wed, 15 May 2019 06:49:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C96903F5AF;
        Wed, 15 May 2019 06:49:04 -0700 (PDT)
Date:   Wed, 15 May 2019 14:49:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arun KS <arunks@codeaurora.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        James Morse <james.morse@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Steve Capper <steve.capper@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: Fix size of __early_cpu_boot_status
Message-ID: <20190515134902.GI24357@fuggles.cambridge.arm.com>
References: <1557927822-21111-1-git-send-email-arunks@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557927822-21111-1-git-send-email-arunks@codeaurora.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:13:19PM +0530, Arun KS wrote:
> __early_cpu_boot_status is of type int. Fix up the calls to
> update_early_cpu_boot_status, to use a w register.
> 
> Signed-off-by: Arun KS <arunks@codeaurora.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/include/asm/smp.h | 2 +-
>  arch/arm64/kernel/head.S     | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

Your original patch is now in mainline:

https://git.kernel.org/linus/61cf61d81e32

Is this still needed?

Will
