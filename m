Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6AEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4692245B
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 20:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfIZU2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 16:28:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbfIZU2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 16:28:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3709F142F;
        Thu, 26 Sep 2019 13:28:20 -0700 (PDT)
Received: from [172.23.27.158] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0CCE3F67D;
        Thu, 26 Sep 2019 13:28:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] arm64: vdso32: Address various issues
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190926133805.52348-1-vincenzo.frascino@arm.com>
 <20190926153123.GK9689@arrakis.emea.arm.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fbc2efbd-b354-7f05-7d4e-600b21fcfff6@arm.com>
Date:   Thu, 26 Sep 2019 21:29:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926153123.GK9689@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 4:31 PM, Catalin Marinas wrote:
> On Thu, Sep 26, 2019 at 02:38:01PM +0100, Vincenzo Frascino wrote:
>> this patch series is meant to address the various compilation issues you
>> reported about arm64 vdso32. (This time for real I hope ;))
>>
>> Please let me know if there is still something missing.
> 
> Apart from the diff I posted and some nitpicks, the series looks fine to
> me. If you post an update, I'll ack it (and a tested-by).
> 
> In addition to this series I'd still prefer to have my Kconfig option to
> disable the compat vDSO if something else fails in the future (at least
> until we complete the headers clean-up). But I'm fine with a default y
> and removing EXPERT.
>

It is fine by me, but may I ask to state in the commit message that the patch
can be reverted once the we fix the headers issue? I would like to have symmetry
in enabling vDSOs in between arm64 and compat once everything is fixed.

> Thanks for the quick turnaround.
> 

No problem, it is my responsibility to fix the vDSOs on arm64 and compat if
something breaks ;)

-- 
Regards,
Vincenzo
