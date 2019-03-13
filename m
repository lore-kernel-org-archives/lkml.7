Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD707C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA472173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfCMEFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:05:10 -0400
Received: from ozlabs.org ([203.11.71.1]:33667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfCMEFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:05:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Jysv14rJz9s4V;
        Wed, 13 Mar 2019 15:05:07 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Mathieu Malaterre <malat@debian.org>
Cc:     linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: Mark 'dummy_copy_buffer' as used
In-Reply-To: <38359442-e219-18ad-926b-42a6e5ab4e7d@c-s.fr>
References: <20190312202921.31331-1-malat@debian.org> <38359442-e219-18ad-926b-42a6e5ab4e7d@c-s.fr>
Date:   Wed, 13 Mar 2019 15:05:04 +1100
Message-ID: <8736nr5si7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> On 03/12/2019 08:29 PM, Mathieu Malaterre wrote:
>> In commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
>> when possible") a buffer 'dummy_copy_buffer' was introduced. gcc does
>> not see this buffer being used in the inline assembly within function
>> '__switch_to', explicitly marked this variable as being used.
>> 
>> Prefer using '__aligned' to get passed line over 80 characters warning
>> in checkpatch.
>
> Powerpc accepts 90 characters, use arch/powerpc/tools/checkpatch.sh
>
>> 
>> This remove the following warning:
>> 
>>    arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]
>
> commit 2bf1071a8d50 ("powerpc/64s: Remove POWER9 DD1 support") has 
> removed the fonction using 'dummy_copy_buffer' so you should remove it 
> completely.

Yes that would be better, thanks.

cheers
