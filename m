Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02229C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8843B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="czIi1vdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfDONWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:22:40 -0400
Received: from mail.efficios.com ([167.114.142.138]:40864 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfDONWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:22:40 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 79869B7C4A;
        Mon, 15 Apr 2019 09:22:38 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZSrCnVQznHYP; Mon, 15 Apr 2019 09:22:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E4EABB7C43;
        Mon, 15 Apr 2019 09:22:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E4EABB7C43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555334557;
        bh=bYKkERI1SwG+4Ei/g+V6d5eNPDTPu1ET8bVIr4ZqnNM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=czIi1vdxuYcWyi7/5gQqMluofUUbkUt2ivk9eXtOxy9zfr60Chog8/6bWQ18+LDgE
         Hbewnd/IARIi/z1Y3nSidFFQuCYsXWcVwaQdsk2ohQhpU58linawk5H/Q6G5ILezSc
         GpFnS23HOxov1/9bFusQDvGnfLxU7yyqTH18MxbhiIOgdEiJKNSGljmDw7sIPgtBYo
         KMwCEzrM5KT2dEQ4qZD15rsoX99b5Dj4dU8D7uYyMfE7mYVAbX8Vv7DVz51q5Tjgqn
         z/EZurFoBzlt5cIEupFTkBjICs9A3uOQa8ME/69e9NRYb11lH1US/oU57TzS96uZu2
         qYmjhgslZo6xA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 2P_aT5QrQHns; Mon, 15 Apr 2019 09:22:37 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C5B7AB7C3C;
        Mon, 15 Apr 2019 09:22:37 -0400 (EDT)
Date:   Mon, 15 Apr 2019 09:22:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>
Message-ID: <1341767794.285.1555334557497.JavaMail.zimbra@efficios.com>
In-Reply-To: <87pnpsd91x.fsf@oldenburg2.str.redhat.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com> <87pnpsd91x.fsf@oldenburg2.str.redhat.com>
Subject: Re: rseq/arm32: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/arm32: choosing rseq code signature
Thread-Index: fsYjoZseDMCAVxBdA8tCwrEOc3OPKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 11, 2019, at 8:24 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> /*
>>  * TODO: document trap instruction objdump output on each sub-architecture
>>  * instruction sets, as well as instruction set extensions.
>>  */
>> #define RSEQ_SIG 0x########
> 
> Will RSEQ_SIG actually be needed at run time outside the rseq
> implementation library (whether it's glibc or something else)?

Here is how I plan to use it:

- rseq registration performed by glibc,
- rseq critical section abort handlers:
  - inlined into applications,
  - inlined into libraries.

I plan that it will be mostly used through librseq headers, but inlined
into applications/libraries, which really makes this a fixed ABI once it's
published through public headers.

> 
> Actually rseq users will emit the signature directly into the text
> section, right?  They never have to load it into a register, I assume.

The user-space libraries defining rseq critical sections only emit this
signature into their text section. However, the kernel will load that
signature and compare its value before moving the instruction pointer to
the abort handler. So it gets eventually loaded into a register and
compared by the kernel, not by user-space.

> My concern is that on some architectures, the very act of referencing
> RSEQ_SIG will put it into the text section, as a non-instruction, which
> is not what we want.

The kernel knows at which address the RSEQ_SIG sits based on the abort_ip
of the current rseq_cs struct. Getting the address of the abort_ip is performed
through an assembler label.

Note that on arm32, I had to use ".arm\n\t.inst 0xNNNNNNNN" rather than ".long 0xNNNNNNNN"
to ensure the assembler emits the signature as an actual instruction rather than
non-instruction "data". This modifies the content of the symbol table .symtab elf section.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
