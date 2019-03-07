Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC0C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1372620449
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfCGPEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:04:15 -0500
Received: from foss.arm.com ([217.140.101.70]:46674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfCGPEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:04:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C26FEBD;
        Thu,  7 Mar 2019 07:04:14 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C6783F71D;
        Thu,  7 Mar 2019 07:04:12 -0800 (PST)
Date:   Thu, 7 Mar 2019 15:04:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Juri Lelli <juri.lelli@gmail.com>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        dietmar.eggemann@arm.com, gregkh@linuxfoundation.org,
        will.deacon@arm.com, catalin.marinas@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190307150151.GA5778@e107155-lin>
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
 <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
 <20190307072856.GC29753@localhost.localdomain>
 <20190307093116.slvugyeos46kl3et@queper01-lin>
 <20190307095750.GD29753@localhost.localdomain>
 <20190307121400.cmgymfbphguvlaoo@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307121400.cmgymfbphguvlaoo@queper01-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 12:14:03PM +0000, Quentin Perret wrote:
> On Thursday 07 Mar 2019 at 10:57:50 (+0100), Juri Lelli wrote:
> > If people think it's best to simply make this RO, I won't be against it.
> > Just pointed out a conversation we recently had. Guess we could also
> > make it RW again (properly) in the future if somebody complains.
>
> Right, now is probably the time to give it a go before folks start
> depending on it. And if I am wrong (and that happens more often than I'd
> like unfortunately :-)) and there are users of that thing, then the
> revert should be trivial.
>

+1 on all the points above ;)(I may also be getting things wrong here
but I am not convinced that we can resolve the issue for all the ARM
vendor possible combinations we may have to address)

We should come up with some *magical* cpumask that we can use if we
want to retain this write capability. And only way I see we can do that
is using DT which in turn eliminates the need to have write capability
for this sysfs.

So I am going to ack the $subject patch for now.

--
Regards,
Sudeep
