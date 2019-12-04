Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6924C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8825E20640
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfLDN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:56:02 -0500
Received: from foss.arm.com ([217.140.110.172]:56176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:56:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3C9A328;
        Wed,  4 Dec 2019 05:56:00 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48CB3F68E;
        Wed,  4 Dec 2019 05:55:59 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:55:57 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <Patrick.Bellasi@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Null pointer crash at find_idlest_group on db845c w/ linus/master
Message-ID: <20191204135556.w7xsog6oywrfkaqj@e107158-lin.cambridge.arm.com>
References: <CALAqxLXrWWnWi32BR1F8JOtrGt1y2Kzj__zWopLx1ZfRy3EZKA@mail.gmail.com>
 <CAKfTPtAvnLY3brp9iy_aHNu0rMM8nLfgeLc3CXEkMk3bwU1weA@mail.gmail.com>
 <20191204094216.u7yld5r3zelp22lf@e107158-lin.cambridge.arm.com>
 <20191204100925.GA15727@linaro.org>
 <629cca09-dde7-5d77-42e1-c68f2c1820d2@arm.com>
 <CAKfTPtDZLFn7msw88pTE_wr-BJo2ErqxpOW+ah0Jjcg6vE3SLw@mail.gmail.com>
 <20191204133224.uiqbkbpseree7xou@e107158-lin.cambridge.arm.com>
 <CAKfTPtBP1wm706ZjZhW+BV5XUcONfJcGteeyoJQUhQsYPsY4tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtBP1wm706ZjZhW+BV5XUcONfJcGteeyoJQUhQsYPsY4tg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/19 14:48, Vincent Guittot wrote:
> if we want to initialize local_sgs, it should be something like
> local_sgs =  {
> .avg_load = UINT_MAX,
> .group_type = group_overloaded,
> };

+1

> 
> to make sure that we will not select local. This doesn't reflect any
> kind of reality whereas local=NULL is more meaningful and more robust
> IMO

It's just defensive programming from my side :) I don't feel strongly about it
though.

Thanks

--
Qais Yousef
