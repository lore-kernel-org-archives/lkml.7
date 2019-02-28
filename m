Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45BA2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HQbw4FJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbfB1Nxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:53:36 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9540 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfB1Nxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:53:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c77e7e90000>; Thu, 28 Feb 2019 05:53:45 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Feb 2019 05:53:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Feb 2019 05:53:36 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Feb
 2019 13:53:33 +0000
Subject: Re: [PATCH] sched/cputime: Remove unnecessary assignment statement
To:     Peter Zijlstra <peterz@infradead.org>,
        Sachin Nikam <Snikam@nvidia.com>
CC:     Ketan Patil <ketanp@nvidia.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Bharat Nihalani <bnihalani@nvidia.com>,
        Bo Yan <byan@nvidia.com>,
        Sai Gurrappadi <sgurrappadi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Timo Alho <talho@nvidia.com>
References: <1551248002-27303-1-git-send-email-ketanp@nvidia.com>
 <20190227103230.GM32494@hirez.programming.kicks-ass.net>
 <9bce6378-2221-f358-dc97-f15ee7ab546b@nvidia.com>
 <20190228094733.GY32494@hirez.programming.kicks-ass.net>
 <MN2PR12MB3278E52D04119DC55597A293BB750@MN2PR12MB3278.namprd12.prod.outlook.com>
 <20190228123120.GA32494@hirez.programming.kicks-ass.net>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <397917cc-3656-e26c-7715-d4feec97bb4b@nvidia.com>
Date:   Thu, 28 Feb 2019 13:53:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228123120.GA32494@hirez.programming.kicks-ass.net>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551362025; bh=I2R8OVm72R100YHiJB2dEZ6K1N+tPCl6D0NuJX3x4YE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=HQbw4FJonKbaLYZ0ab6wfJ6PiKX96bvenLznhG8sq3iUpBh1aRw6oI7Y5fJwcGBf3
         qAkmagANTqKQLxTDRiHPzXDFMc2VCxvXCuiOFLl76MC3FDI2qgedlHigiggvaWEuz5
         3e6tZNOdjZyi4xLyYwfZCZTlw+M22lVh+FSOKbTmKiXK5Eqo0+P1ZQQMFlZ10jwjBb
         YKgS+EUim1XlSgCXz8xW/Jnxs1l2TeX5/OHwkOpvaVdQUYfzfISln7nALtDUeoBtdo
         qQjuhkwtfkOmvnZpkFkeGFL/f4rmfDujxitlDO8GUiuYwRSTW4pHub4MG3HDbM80L/
         TdUveObmPF2TQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/02/2019 12:31, Peter Zijlstra wrote:
> 
> Clearly, because reading comprehension isn't your strong point:
> 
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?

Sorry we have a few people helping out cleaning up our kernel branches
and we need to do a better job here indeed!

> On Thu, Feb 28, 2019 at 12:14:09PM +0000, Sachin Nikam wrote:
> 
>> This isn't a security fix.
>> However, I see this is kind of code cleanup.
> 
> As I've explained previously, it makes conceptual sense to have it in
> the code, and any halfway sane compiler will observe the same double
> store and eliminate it in its DCE pass.

OK. Thanks for the feedback. We can agree to drop this and we will try
to do a better job reviewing this type of thing before hand in future.

Cheers
Jon

-- 
nvpublic
