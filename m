Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4259C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1D820675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfCGMOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:14:07 -0500
Received: from foss.arm.com ([217.140.101.70]:44590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfCGMOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:14:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E68980D;
        Thu,  7 Mar 2019 04:14:06 -0800 (PST)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF183F703;
        Thu,  7 Mar 2019 04:14:04 -0800 (PST)
Date:   Thu, 7 Mar 2019 12:14:03 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Juri Lelli <juri.lelli@gmail.com>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190307121400.cmgymfbphguvlaoo@queper01-lin>
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
 <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
 <20190307072856.GC29753@localhost.localdomain>
 <20190307093116.slvugyeos46kl3et@queper01-lin>
 <20190307095750.GD29753@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307095750.GD29753@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Mar 2019 at 10:57:50 (+0100), Juri Lelli wrote:
> If people think it's best to simply make this RO, I won't be against it.
> Just pointed out a conversation we recently had. Guess we could also
> make it RW again (properly) in the future if somebody complains.

Right, now is probably the time to give it a go before folks start
depending on it. And if I am wrong (and that happens more often than I'd
like unfortunately :-)) and there are users of that thing, then the
revert should be trivial.

Thanks,
Quentin
