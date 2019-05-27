Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494ABC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FC520717
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfE0GoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:44:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56630 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfE0GoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:44:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759C0374;
        Sun, 26 May 2019 23:44:03 -0700 (PDT)
Received: from [10.162.40.17] (p8cg001049571a15.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F483F59C;
        Sun, 26 May 2019 23:44:01 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Drop BUG_ON() from [pmd|pud]_set_huge()
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <1558929734-20051-1-git-send-email-anshuman.khandual@arm.com>
 <CAKv+Gu-OSkPWUACCt=hzQJbbNArjYzt_nyYXit-oMOZy8t3fTQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <35b83daa-f092-fe77-0c1f-d32e2d573be5@arm.com>
Date:   Mon, 27 May 2019 12:14:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-OSkPWUACCt=hzQJbbNArjYzt_nyYXit-oMOZy8t3fTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/27/2019 12:07 PM, Ard Biesheuvel wrote:
> On Mon, 27 May 2019 at 06:02, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> There are no callers for the functions which will pass unaligned physical
>> addresses. Hence just drop these BUG_ON() checks which are not required.
>>
> This might change in the future, right? Should we perhaps switch to
> VM_BUG_ON() instead so they get compiled out unless CONFIG_VM_DEBUG is
> enabled?

Sure we can do that. Will re-send.
