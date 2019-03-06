Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80A1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53992064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfCFTm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:42:27 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47123 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfCFTm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:42:26 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 7973DFF802;
        Wed,  6 Mar 2019 19:42:18 +0000 (UTC)
Subject: Re: [PATCH v5 3/4] mm: Simplify MEMORY_ISOLATION && COMPACTION || CMA
 into CONTIG_ALLOC
To:     Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-4-alex@ghiti.fr>
 <6a50153b-c68b-f96c-1840-df6b7dd2cc61@suse.cz>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <bf448a35-47e0-53f2-59d7-384c45514b9c@ghiti.fr>
Date:   Wed, 6 Mar 2019 14:42:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <6a50153b-c68b-f96c-1840-df6b7dd2cc61@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 2:30 PM, Vlastimil Babka wrote:
> On 3/6/19 8:00 PM, Alexandre Ghiti wrote:
>> This condition allows to define alloc_contig_range, so simplify
>> it into a more accurate naming.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> (you could have sent this with my ack from v4 as there wasn't
> significant change, just the one I suggested :)

Thanks, that's good to know.

Alex

