Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702D3C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA53214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405473AbfFKPzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:55:49 -0400
Received: from foss.arm.com ([217.140.110.172]:36618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388492AbfFKPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:55:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4541337;
        Tue, 11 Jun 2019 08:55:48 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 963093F246;
        Tue, 11 Jun 2019 08:55:45 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:55:43 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/7] cpu-topology: Move cpu topology code to common
 code.
Message-ID: <20190611155543.GJ4324@fuggles.cambridge.arm.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529211340.17087-4-atish.patra@wdc.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 02:13:36PM -0700, Atish Patra wrote:
> Both RISC-V & ARM64 are using cpu-map device tree to describe
> their cpu topology. It's better to move the relevant code to
> a common place instead of duplicate code.
> 
> To: Will Deacon <will.deacon@arm.com>
> To: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> [Tested on QDF2400]
> Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> [Tested on Juno and other embedded platforms.]
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> ---
> Hi Will/Catalin,
> Can we get ack for this patch ? We are hoping to get the entire series
> merged at one go.

If Sudeep is happy with it then that's good enough for me.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
