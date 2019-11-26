Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCCBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFFC20748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfKZKmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:42:05 -0500
Received: from foss.arm.com ([217.140.110.172]:60936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfKZKmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:42:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE9A230E;
        Tue, 26 Nov 2019 02:42:04 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F5FC3F52E;
        Tue, 26 Nov 2019 02:42:03 -0800 (PST)
Subject: Re: [PATCH] arm: Fix topology setup in case of CPU hotplug for
 CONFIG_SCHED_MC
To:     Atish Patra <atish.patra@wdc.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20191120104212.14791-1-dietmar.eggemann@arm.com>
 <20191124214753.m6lwcdemnddltctw@core.my.home>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <50dfafee-55c3-767c-55f4-7d263feafe87@arm.com>
Date:   Tue, 26 Nov 2019 11:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191124214753.m6lwcdemnddltctw@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2019 22:47, Ondřej Jirman wrote:
> Hello,
> 
> On Wed, Nov 20, 2019 at 10:42:12AM +0000, Dietmar Eggemann wrote:

[...]

>> Fixes: ca74b316df96 ("arm: Use common cpu_topology structure and functions")
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> This fixes CPU hotplug and correspondent suspend to ram/resume failures (that
> disables and re-enables non-boot CPUs) on A83T SoC, that I've seen since
> 5.4-rc1.
> 
> Tested-by: Ondrej Jirman <megous@megous.com>

Thanks for testing! Which Cpufreq driver is your system using?

[...]
