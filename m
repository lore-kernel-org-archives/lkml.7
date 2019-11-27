Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F84C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B289A206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfK0Obm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:31:42 -0500
Received: from foss.arm.com ([217.140.110.172]:48410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbfK0Obl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:31:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 065A831B;
        Wed, 27 Nov 2019 06:31:41 -0800 (PST)
Received: from [192.168.0.9] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF94F3F68E;
        Wed, 27 Nov 2019 06:31:39 -0800 (PST)
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
 <50dfafee-55c3-767c-55f4-7d263feafe87@arm.com>
 <20191126214557.53afmorihwqimq2n@core.my.home>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9119c1db-b98d-67d4-ce4c-d9a9b298937a@arm.com>
Date:   Wed, 27 Nov 2019 15:31:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126214557.53afmorihwqimq2n@core.my.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/2019 22:45, Ondřej Jirman wrote:
> On Tue, Nov 26, 2019 at 11:42:02AM +0100, Dietmar Eggemann wrote:
>> On 24/11/2019 22:47, Ondřej Jirman wrote:
>>> Hello,
>>>
>>> On Wed, Nov 20, 2019 at 10:42:12AM +0000, Dietmar Eggemann wrote:

[...]

>> Thanks for testing! Which Cpufreq driver is your system using?
> 
> Hello,
> 
> it's using cpufreq-dt.

Thanks for the info! It's dt-based so this one is safe in regards to
retrieving the correct topology core mask during CPU hp stress (i.e.
from multiple CPUs at the same time).

[...]
