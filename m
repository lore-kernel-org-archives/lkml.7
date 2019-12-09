Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3243C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ACD2465A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLIPth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:49:37 -0500
Received: from foss.arm.com ([217.140.110.172]:36482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfLIPth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:49:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F2DB1FB;
        Mon,  9 Dec 2019 07:49:36 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D143F718;
        Mon,  9 Dec 2019 07:49:34 -0800 (PST)
Date:   Mon, 9 Dec 2019 15:49:32 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, tglx@linutronix.de,
        chenxiang66@hisilicon.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, hare@suse.com, hch@lst.de,
        axboe@kernel.dk, bvanassche@acm.org, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
  for managed interrupt
Message-ID: <20191209154932.dyysdktbosi3vlbx@e107158-lin.cambridge.arm.com>
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <305198e5-f76f-ded4-946b-9cfade18f08c@suse.de>
 <c06752c858229854b37af3b47779b126@www.loen.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c06752c858229854b37af3b47779b126@www.loen.fr>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/19 15:17, Marc Zyngier wrote:
> On 2019-12-09 15:09, Hannes Reinecke wrote:
> 
> [slight digression]
> 
> > My idea here is slightly different: can't we leverage SMT?
> > Most modern CPUs do SMT (I guess even ARM does it nowadays)
> > (Yes, I know about spectre and things. We're talking performance here
> > :-)
> 
> I only know two of those: Cavium TX2 and ARM Neoverse-E1.

There's the Cortex-A65 too.

--
Qais Yousef

> ARM SMT CPUs are the absolute minority (and I can't say I'm displeased).
> 
>         M,
> -- 
> Jazz is not dead. It just smells funny...
