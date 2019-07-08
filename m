Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F778C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CB9216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbfGHP4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:56:55 -0400
Received: from foss.arm.com ([217.140.110.172]:52786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731329AbfGHP4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:56:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CED82360;
        Mon,  8 Jul 2019 08:56:54 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AE913F59C;
        Mon,  8 Jul 2019 08:56:53 -0700 (PDT)
Subject: Re: kprobes sanity test fails on next-20190708
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190708141136.GA3239@localhost.localdomain>
From:   James Morse <james.morse@arm.com>
Message-ID: <a19faa89-d318-fe21-9952-b0f842240ba5@arm.com>
Date:   Mon, 8 Jul 2019 16:56:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708141136.GA3239@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/07/2019 15:11, Anders Roxell wrote:
> argh... resending, with plaintext... Sorry =/
> 
> I tried to build a next-201908 defconfig + CONFIG_KPROBES=y and
> CONFIG_KPROBES_SANITY_TEST=y
> 
> I get the following Call trace, any ideas?
> I've tried tags back to next-20190525 and they also failes... I haven't
> found a commit that works yet.
> 
> [    0.098694] Kprobe smoke test: started
> [    0.102001] audit: type=2000 audit(0.088:1): state=initialized
> audit_enabled=0 res=1
> [    0.104753] Internal error: aarch64 BRK: f2000004 [#1] PREEMPT SMP

This sounds like the issue Mark reported:
https://lore.kernel.org/r/20190702165008.GC34718@lakrids.cambridge.arm.com

It doesn't look like Steve's patch has percolated into next yet:
https://lore.kernel.org/lkml/20190703103715.32579c25@gandalf.local.home/

Could you give that a try to see if this is a new issue?


Thanks,

James
