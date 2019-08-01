Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B160C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C24206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbfHAWSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:18:55 -0400
Received: from foss.arm.com ([217.140.110.172]:41662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbfHAWSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:18:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBB5B337;
        Thu,  1 Aug 2019 15:18:54 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 333BD3F694;
        Thu,  1 Aug 2019 15:18:54 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Cleanup task->numa_work initialization
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <alpine.DEB.2.21.1908012246530.1789@nanos.tec.linutronix.de>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2bd050d5-0e03-a858-305f-46039261a422@arm.com>
Date:   Thu, 1 Aug 2019 23:18:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908012246530.1789@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/08/2019 21:51, Thomas Gleixner wrote:
> - Resolve the ancient TODO by setting the numa_work function in
>   init_numa_balancing() which is called on fork().
> 
> - Make task_numa_work() static as it's not used outside of the fair
>   scheduler and lacks a prototype as well.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Looks like I beat you to it...

https://lore.kernel.org/lkml/20190715102508.32434-1-valentin.schneider@arm.com/

Do I win anything? :D
 
