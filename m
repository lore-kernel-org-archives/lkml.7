Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA857C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803E020830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RiGlvGV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfDJPum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:50:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:34320 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbfDJPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:50:42 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 889F21D6919;
        Wed, 10 Apr 2019 11:50:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ExFflYqKYuLA; Wed, 10 Apr 2019 11:50:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 276F81D6912;
        Wed, 10 Apr 2019 11:50:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 276F81D6912
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554911440;
        bh=CQEMTrph+vc+6/uLW4RTHKKGiQmbTxgD+HaG6AAW1iw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RiGlvGV1Zv2vX6ZK7JYxAynBspIsn5k54/h4VomFRM0HHqJtYqWblniI1U1ssPfMi
         DF1FBxE5asazppNoe4jGZmb2CU43Smr9TrfYZmUysL5A2N4ZZ4puB36NXW1P6RFeyi
         pXqUVZgfdJ4y20B71gQDVc03SH1EAW4Kzlc0JV4yNjLvDzfwpu/aJgz7cEmb7vCJSD
         4flRDEaIw11jYd8Thc+XA5AH9kxpeyEuwimNgZw3Ef2MJROQo+f4+1UW1/g6XGXYYY
         e9fSoSd11M+CHSPgnlLYjk+AzJqySglHyCZdbk1sdAIwWpa0VxUVOyX+z6y7e0Ktv6
         P8+ZxMik3kTyA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 5OtPiLW2r9Jh; Wed, 10 Apr 2019 11:50:40 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 07DE31D690B;
        Wed, 10 Apr 2019 11:50:40 -0400 (EDT)
Date:   Wed, 10 Apr 2019 11:50:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     schwidefsky <schwidefsky@de.ibm.com>
Cc:     heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>
Message-ID: <514609006.3159.1554911439933.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190410123258.37f182cf@mschwideX1>
References: <1779981820.2626.1554838342731.JavaMail.zimbra@efficios.com> <20190410123258.37f182cf@mschwideX1>
Subject: Re: rseq/s390: choosing code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/s390: choosing code signature
Thread-Index: I0ikTLoE0n9yf7c3EJtl2fBgiPZZOw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 10, 2019, at 6:32 AM, schwidefsky schwidefsky@de.ibm.com wrote:

> On Tue, 9 Apr 2019 15:32:22 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> Hi,
>> 
>> We are about to include the code signature required prior to restartable
>> sequences abort handlers into glibc, which will make this ABI choice final.
>> We need architecture maintainer input on that signature value.
>> 
>> That code signature is placed before each abort handler, so the kernel can
>> validate that it is indeed jumping to an abort handler (and not some
>> arbitrary attacker-chosen code). The signature is never executed.
>> 
>> The current discussion thread on the glibc mailing list leads us towards
>> using a trap with uncommon immediate operand, which simplifies integration
>> with disassemblers, emulators, makes it easier to debug if the control
>> flow gets redirected there by mistake, and is nicer for some architecture's
>> speculative execution.
>> 
>> We can have different signatures for each sub-architecture, as long as they
>> don't have to co-exist within the same process. We can special-case with
>> #ifdef for each sub-architecture and endianness if need be. If the architecture
>> has instruction set extensions that can co-exist with the architecture
>> instruction set within the same process, we need to take into account to which
>> instruction the chosen signature value would map (and possibly decide if we
>> need to extend rseq to support many signatures).
>> 
>> Here is an example of rseq signature definition template:
>> 
>> /*
>>  * TODO: document trap instruction objdump output on each sub-architecture
>>  * instruction sets, as well as instruction set extensions.
>>  */
>> #define RSEQ_SIG 0x########
>> 
>> Ideally we'd need a patch on top of the Linux kernel
>> tools/testing/selftests/rseq/rseq-s390.h file that updates
>> the signature value, so I can then pick it up for the glibc
>> patchset.
> 
> The trap4 instruction is a suitable one. The patch would look like this

Great! I'm picking it up into my rseq tree if that's OK with you.

Thanks,

Mathieu


> --
> commit 2ee28f6d1de968a71f074ab150384b90b4121216
> Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Date:   Wed Apr 10 12:28:41 2019 +0200
> 
>    s390/rseq: use trap4 for RSEQ_SIG
>    
>    Use trap4 as the guard instruction for the restartable sequence abort
>    handler.
>    
>    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> diff --git a/tools/testing/selftests/rseq/rseq-s390.h
> b/tools/testing/selftests/rseq/rseq-s390.h
> index 1069e85258ce..d4c8e1147d86 100644
> --- a/tools/testing/selftests/rseq/rseq-s390.h
> +++ b/tools/testing/selftests/rseq/rseq-s390.h
> @@ -1,6 +1,13 @@
> /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> 
> -#define RSEQ_SIG	0x53053053
> +/*
> + * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
> + * access-register mode nor the linkage stack this instruction will always
> + * cause a special-operation exception (the trap-enabled bit in the DUCT
> + * is and will stay 0). The instruction pattern is
> + *	b2 ff 0f ff	trap4   4095(%r0)
> + */
> +#define RSEQ_SIG	0xB2FF0FFF
> 
> #define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
> #define rseq_smp_rmb()	rseq_smp_mb()
> --
> blue skies,
>   Martin.
> 
> "Reality continues to ruin my life." - Calvin.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
