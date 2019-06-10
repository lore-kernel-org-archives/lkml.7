Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D19C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A07206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbfFJMIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:08:43 -0400
Received: from foss.arm.com ([217.140.110.172]:41406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389229AbfFJMIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:08:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3FFB337;
        Mon, 10 Jun 2019 05:08:42 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85613F557;
        Mon, 10 Jun 2019 05:10:23 -0700 (PDT)
Date:   Mon, 10 Jun 2019 13:08:39 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/arm_arch_timer: extract elf_hwcap use to
 arch-helper
Message-ID: <20190610120839.GH15979@fuggles.cambridge.arm.com>
References: <20190430131413.10017-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430131413.10017-1-andrew.murray@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:14:13PM +0100, Andrew Murray wrote:
> Different mechanisms are used to test and set elf_hwcaps between ARM
> and ARM64, this results in the use of #ifdef's in this file when
> setting/testing for the EVTSTRM hwcap.
> 
> Let's improve readability by extracting this to an arch helper.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  arch/arm/include/asm/arch_timer.h    | 13 +++++++++++++
>  arch/arm64/include/asm/arch_timer.h  | 13 +++++++++++++
>  drivers/clocksource/arm_arch_timer.c | 15 ++-------------
>  3 files changed, 28 insertions(+), 13 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

I assume this is going via Marc Z.

Will
