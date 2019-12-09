Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF12BC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AB7207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 15:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfLIPZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:25:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:35788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfLIPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 10:25:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A07EB03E;
        Mon,  9 Dec 2019 15:25:03 +0000 (UTC)
Subject: Re: [PATCH RFC 1/1] genirq: Make threaded handler use irq affinity
 for managed interrupt
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        tglx@linutronix.de, chenxiang66@hisilicon.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org, hare@suse.com,
        hch@lst.de, axboe@kernel.dk, bvanassche@acm.org,
        peterz@infradead.org, mingo@redhat.com
References: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
 <1575642904-58295-2-git-send-email-john.garry@huawei.com>
 <20191207080335.GA6077@ming.t460p>
 <78a10958-fdc9-0576-0c39-6079b9749d39@huawei.com>
 <305198e5-f76f-ded4-946b-9cfade18f08c@suse.de>
 <c06752c858229854b37af3b47779b126@www.loen.fr>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <fd4192c6-351a-144f-9c31-d5a89c6fdedf@suse.de>
Date:   Mon, 9 Dec 2019 16:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c06752c858229854b37af3b47779b126@www.loen.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 4:17 PM, Marc Zyngier wrote:
> On 2019-12-09 15:09, Hannes Reinecke wrote:
> 
> [slight digression]
> 
>> My idea here is slightly different: can't we leverage SMT?
>> Most modern CPUs do SMT (I guess even ARM does it nowadays)
>> (Yes, I know about spectre and things. We're talking performance here :-)
> 
> I only know two of those: Cavium TX2 and ARM Neoverse-E1.
> ARM SMT CPUs are the absolute minority (and I can't say I'm displeased).
> 
Ach, too bad.

Still a nice idea, putting SMT finally to some use ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
