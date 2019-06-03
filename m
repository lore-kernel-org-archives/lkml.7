Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA28C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3619A2804C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFCKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:22:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48304 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCKWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:22:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B37D374;
        Mon,  3 Jun 2019 03:22:42 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4923F5AF;
        Mon,  3 Jun 2019 03:22:41 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Cleanup definition of NOHZ blocked load
 functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, Qian Cai <cai@lca.pw>
References: <090C3AE4-55E4-45F3-AEAB-3E7F26FB7D6D@lca.pw>
 <20190602164110.23231-1-valentin.schneider@arm.com>
 <20190603093835.GF3436@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <17c51655-19a0-e15d-5e14-611171f3cc8d@arm.com>
Date:   Mon, 3 Jun 2019 11:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603093835.GF3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2019 10:38, Peter Zijlstra wrote:
[...]
> 
> I'm thinking the below can go on top to further clean up?
> 

Yep, that's even better indeed! Want me to resend with that extra diff?

[...]
