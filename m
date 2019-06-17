Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEEBC31E49
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718A82089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 01:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfFQBbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 21:31:44 -0400
Received: from foss.arm.com ([217.140.110.172]:32866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbfFQBbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 21:31:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73BDD28;
        Sun, 16 Jun 2019 18:31:43 -0700 (PDT)
Received: from [10.162.42.123] (p8cg001049571a15.blr.arm.com [10.162.42.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CA773F246;
        Sun, 16 Jun 2019 18:31:41 -0700 (PDT)
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
To:     Qian Cai <cai@lca.pw>, Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1560461641.5154.19.camel@lca.pw>
 <20190614102017.GC10659@fuggles.cambridge.arm.com>
 <1560514539.5154.20.camel@lca.pw>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
Date:   Mon, 17 Jun 2019 07:02:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1560514539.5154.20.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Qian,

On 06/14/2019 05:45 PM, Qian Cai wrote:
> On Fri, 2019-06-14 at 11:20 +0100, Will Deacon wrote:
>> Hi Qian,
>>
>> On Thu, Jun 13, 2019 at 05:34:01PM -0400, Qian Cai wrote:
>>> LTP hugemmap05 test case [1] could not exit itself properly and then degrade
>>> the
>>> system performance on arm64 with linux-next (next-20190613). The bisection
>>> so
>>> far indicates,
>>>
>>> BAD:  30bafbc357f1 Merge remote-tracking branch 'arm64/for-next/core'
>>> GOOD: 0c3d124a3043 Merge remote-tracking branch 'arm64-fixes/for-next/fixes'
>>
>> Did you finish the bisection in the end? Also, what config are you using
>> (you usually have something fairly esoteric ;)?
> 
> No, it is still running.
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
> 

Were you able to bisect the problem till a particular commit ?

- Anshuman
