Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7888CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5C02063F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfFXPHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:07:09 -0400
Received: from foss.arm.com ([217.140.110.172]:53040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbfFXPHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:07:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDAD3344;
        Mon, 24 Jun 2019 08:07:07 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B07D13F71E;
        Mon, 24 Jun 2019 08:07:04 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:06:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 4/7] arm: Use common cpu_topology structure and
 functions.
Message-ID: <20190624150658.GA1623@e107155-lin>
References: <20190617185920.29581-1-atish.patra@wdc.com>
 <20190617185920.29581-5-atish.patra@wdc.com>
 <20190619121057.GE1360@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619121057.GE1360@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 01:10:57PM +0100, Sudeep Holla wrote:
> Hi Russell,
>
> On Mon, Jun 17, 2019 at 11:59:17AM -0700, Atish Patra wrote:
> > Currently, ARM32 and ARM64 uses different data structures to represent
> > their cpu topologies. Since, we are moving the ARM64 topology to common
> > code to be used by other architectures, we can reuse that for ARM32 as
> > well.
> >
> > Take this opprtunity to remove the redundant functions from ARM32 and
> > reuse the common code instead.
> >
> > To: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Tested-by: Sudeep Holla <sudeep.holla@arm.com> (on TC2)
> > Reviewed-by : Sudeep Holla <sudeep.holla@arm.com>
> >
> > ---
> > Hi Russell,
> > Can we get a ACK for this patch ? We are hoping that the entire
> > series can be merged at one go.
>
> It would be nice to get this in for v5.3 as it's almost there.
> Are you fine with these changes ?
>

Do you have any objections with this patch ? We plan to merge through
RISC-V tree, please let us know. It has been acked-by all the other
maintainers.

--
Regards,
Sudeep
