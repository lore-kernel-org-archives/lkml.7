Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C09C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DF6205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfCSMgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:36:07 -0400
Received: from foss.arm.com ([217.140.101.70]:50868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfCSMgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:36:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B60A1596;
        Tue, 19 Mar 2019 05:36:06 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EFAB3F59C;
        Tue, 19 Mar 2019 05:36:05 -0700 (PDT)
Subject: Re: [PATCH] sched: Do not re-read h_load_next during hierarchical
 load calculation
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20190319091709.lqrtbn76sjx73hnv@techsingularity.net>
 <7de2aa1d-ab22-e7ab-ed9d-06acdbfbde7a@arm.com>
 <20190319123047.3qlpejilrms5ckad@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <cea29ed4-5ad0-7799-f421-9bd2a4a3fba3@arm.com>
Date:   Tue, 19 Mar 2019 12:36:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190319123047.3qlpejilrms5ckad@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 12:30, Mel Gorman wrote:
[...]
>>
>> Does that also want a
>>
>> Fixes: 685207963be9 ("sched: Move h_load calculation to task_h_load()")
>> Cc: stable@vger.kernel.org
>>
>> ?
>>
>> Other than that, the change looks sane to me.
>>
>> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>>
> 
> Thanks. I'll add the Fixes because it does look like the old code would
> have been ok. Thanks for the review!
> 

Well it's not worth much because I completely skipped that we *didn't*
already have a WRITE_ONCE(), which you do need as Peter mentioned. But I
do think stable will be happy to get this one :)
 
