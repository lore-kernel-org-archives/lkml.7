Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B8DC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88302070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfF1EEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:04:40 -0400
Received: from ozlabs.org ([203.11.71.1]:37067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfF1EEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:04:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Zjnx6mG3z9s7h;
        Fri, 28 Jun 2019 14:04:37 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Denis Efremov <efremov@linux.com>,
        Simon Guo <wei.guo.simon@gmail.com>
Cc:     Denis Efremov <efremov@linux.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/powerpc: ppc_asm.h: typo in the header guard
In-Reply-To: <20190623155200.2147-1-efremov@linux.com>
References: <20190623155200.2147-1-efremov@linux.com>
Date:   Fri, 28 Jun 2019 14:04:37 +1000
Message-ID: <87ef3es6cq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Efremov <efremov@linux.com> writes:
> The guard macro __PPC_ASM_H in the header ppc_asm.h
> doesn't match the #ifndef macro _PPC_ASM_H. The patch
> makes them the same.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'll merge this.

Please include linuxppc-dev on powerpc selftest patches.

cheers

> diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> index d2c0a911f55e..2b488b78c4f2 100644
> --- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> +++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _PPC_ASM_H
> -#define __PPC_ASM_H
> +#define _PPC_ASM_H
>  #include <ppc-asm.h>
>  
>  #ifndef r1
> -- 
> 2.21.0
