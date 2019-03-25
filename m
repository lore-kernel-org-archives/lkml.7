Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB49220854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbfCYMWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:22:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46566 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbfCYMWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:22:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 938CE80D;
        Mon, 25 Mar 2019 05:22:52 -0700 (PDT)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54BBA3F575;
        Mon, 25 Mar 2019 05:22:50 -0700 (PDT)
Date:   Mon, 25 Mar 2019 12:22:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        marc.zyngier@arm.com, suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com, Andre.Przywara@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/10] arm64: add system vulnerability sysfs entries
Message-ID: <20190325122247.5zyinkqmixmqg425@mbp>
References: <20190321230557.45107-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321230557.45107-1-jeremy.linton@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 06:05:47PM -0500, Jeremy Linton wrote:
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities 
> 
> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated.
> 
> v5->v6:
> 	Invert meltdown logic to display that a core is safe rather
> 	       than mitigated if the mitigation has been enabled on
> 	       machines that are safe. This can happen when the
> 	       mitigation was forced on via command line or KASLR.
> 	       This means that in order to detect if kpti is enabled
> 	       other methods must be used (look at dmesg) when the
> 	       machine isn't itself susceptible to meltdown.
> 	Trivial whitespace tweaks.

The v6 logic looks fine to me. For the whole series:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
