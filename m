Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D7C3C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EBD21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 09:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEAJuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 05:50:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57378 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfEAJuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 05:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BDAFA78;
        Wed,  1 May 2019 02:50:01 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE70D3F719;
        Wed,  1 May 2019 02:49:59 -0700 (PDT)
Date:   Wed, 1 May 2019 10:49:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     julien.thierry@arm.com, will.deacon@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: PSCI version 1.1 and SYSTEM_RESET2
Message-ID: <20190501094953.GA21851@e107155-lin>
References: <24970f7101952f347bd4046c9a980473@codeaurora.org>
 <efee74624f986a358b8986ae3085fba2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efee74624f986a358b8986ae3085fba2@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 05:07:31PM -0700, Sodagudi Prasad wrote:
> On 2019-04-30 14:44, Sodagudi Prasad wrote:
> +Sudeep
>
> > Hi Mark/Will,
> >
> > I would like to understand whether ARM linux community have plans to
> > support PSCI version 1.1 or not.
> > PSCI_1_1 specification introduced support for SYSTEM_RESET2 command
> > and this new command helps mobile devices to SYSTEM_WARM_RESET
> > support. Rebooting devices with warm reboot helps to capture the
> > snapshot of the ram contents for post-mortem analysis.
>
> I think, there is a recent discussion from Sudeep for the SYSTEM_RESET2
> support.
> https://patchwork.kernel.org/patch/10884345/
>

This has landed in -next, and hopefully must appear in v5.2

>
> Hi Sudeep,
>
> I was going through your discussion in the below list -
> https://lore.kernel.org/lkml/d73d3580-4ec1-a281-4585-5c776fc08c79@xilinx.com/
>
> There is no provision to set up reboot mode dynamically instead kernel
> command line parameter.
> Looking for options to reboot device with warm reboot option when kernel
> crashed.
>
> panic() --> emergency_restart() --> machine_emergency_restart() -->
> machine_restart(NULL);
>
> It would nice if there is a config option to reboot the device either in
> warm or cold in the case of kernel panic.

I presume you prefer to do warm boot in case of panic to get a dump of
the memory to inspect ? If so, is kexec/kdump not the mechanism to
achieve that ?

I am just trying to understand the use case. Xilinx asked for the same
but never got to understand their use case.

--
Regards,
Sudeep
