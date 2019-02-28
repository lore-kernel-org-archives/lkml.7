Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF18C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039ED2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfB1Ltl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:49:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfB1Ltl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:49:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B29A880D;
        Thu, 28 Feb 2019 03:49:40 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EDAB3F738;
        Thu, 28 Feb 2019 03:49:37 -0800 (PST)
Subject: Re: [PATCH v3 20/34] sparc: mm: Add p?d_large() definitions
To:     David Miller <davem@davemloft.net>
Cc:     Mark.Rutland@arm.com, x86@kernel.org, arnd@arndb.de,
        ard.biesheuvel@linaro.org, peterz@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jglisse@redhat.com, mingo@redhat.com,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        sparclinux@vger.kernel.org, james.morse@arm.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        kan.liang@linux.intel.com
References: <20190227170608.27963-1-steven.price@arm.com>
 <20190227170608.27963-21-steven.price@arm.com>
 <20190227.103837.668255833945043179.davem@davemloft.net>
From:   Steven Price <steven.price@arm.com>
Message-ID: <eee95a89-ed4a-dab9-1349-a50eee4f5b77@arm.com>
Date:   Thu, 28 Feb 2019 11:49:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190227.103837.668255833945043179.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2019 18:38, David Miller wrote:
> From: Steven Price <steven.price@arm.com>
> Date: Wed, 27 Feb 2019 17:05:54 +0000
> 
>> walk_page_range() is going to be allowed to walk page tables other than
>> those of user space. For this it needs to know when it has reached a
>> 'leaf' entry in the page tables. This information is provided by the
>> p?d_large() functions/macros.
>>
>> For sparc, we don't support large pages, so add stubs returning 0.
>>
>> CC: "David S. Miller" <davem@davemloft.net>
>> CC: sparclinux@vger.kernel.org
>> Signed-off-by: Steven Price <steven.price@arm.com>
> 
> Sparc does support large pages on 64-bit, just not at this level.  It
> would be nice if the commit message was made more accurate.  

Yes you are right, I fear I only looked at the 32 bit changes when I
wrote the commit message. I'll clarify the difference between 32/64 bit.

> Other than that:
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks,

Steve
