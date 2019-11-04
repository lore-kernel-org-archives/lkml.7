Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6217ACA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3453521D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfKDAiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 19:38:10 -0500
Received: from foss.arm.com ([217.140.110.172]:33406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfKDAiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 19:38:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CD351FB;
        Sun,  3 Nov 2019 16:38:09 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686943F67D;
        Sun,  3 Nov 2019 16:38:07 -0800 (PST)
Subject: Re: [PATCH] sched/topology, cpuset: Account for housekeeping CPUs to
 avoid empty cpumasks
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20191102001406.10208-1-valentin.schneider@arm.com>
 <20191103190957.GA39453@gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <845e4aba-eee2-efd0-2902-1d956057059d@arm.com>
Date:   Mon, 4 Nov 2019 00:37:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191103190957.GA39453@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2019 19:09, Ingo Molnar wrote:
> This patch doesn't apply cleanly to Linus's latest tree - which tree is 
> this against?
> 

This was against Linus' tree at the time (31408fbe33d1), but my local .patch
doesn't apply either. I regenerated a fresh one and there's an off-by-one in
original chunk size - I suspect my editor trying to be smart when I edited
the changelog.

I'll look into preventing this from happening again, in the meantime I'll
send an apply-able version. Apologies for that mess.

> Thanks,
> 
> 	Ingo
> 
