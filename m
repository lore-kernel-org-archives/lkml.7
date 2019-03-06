Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1A7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D298B2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfCFTLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:11:06 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:47545 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfCFTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:11:06 -0500
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7693C100006;
        Wed,  6 Mar 2019 19:10:55 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     David Miller <davem@davemloft.net>
Cc:     vbabka@suse.cz, catalin.marinas@arm.com, will.deacon@arm.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mike.kravetz@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 2/4] sparc: Advertise gigantic page support
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-3-alex@ghiti.fr>
 <20190306.110436.1714716608828903522.davem@davemloft.net>
Message-ID: <ac0c5166-f1f6-5339-58e3-a33f085c1220@ghiti.fr>
Date:   Wed, 6 Mar 2019 14:10:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190306.110436.1714716608828903522.davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 2:04 PM, David Miller wrote:
> From: Alexandre Ghiti <alex@ghiti.fr>
> Date: Wed,  6 Mar 2019 14:00:03 -0500
>
>> sparc actually supports gigantic pages and selecting
>> ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
>> gigantic pages at runtime.
>>
>> sparc allows configuration such as huge pages of 16GB,
>> pages of 8KB and MAX_ORDER = 13 (default):
>> HPAGE_SHIFT (34) - PAGE_SHIFT (13) = 21 >= MAX_ORDER (13)
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Much better.
>
> Acked-by: David S. Miller <davem@davemloft.net>
Thanks !

Alex
