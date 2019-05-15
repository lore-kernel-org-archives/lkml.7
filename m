Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD88C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D471C206BF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXOSew52";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXOSew52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfEOMfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:35:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48316 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEOMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:35:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9CDD360ACE; Wed, 15 May 2019 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557923736;
        bh=RPwOPoT9uzbHUfPdrm1EKq6ZA6S73yRB5cU5ZE4vTFQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hXOSew52hkHFmro4K45EZX8n2Xm075JUoCkLjcaAKoLLcASa4BpoTgbgjiP1ZYkC+
         TtOzCbicrRfkNNC2KK/akgmlr+WlsSeGet0Zy3mEWGJk4imwFsAaClDpKury5EZm5v
         JjA8STUgQvrKLGczmgwgPYK9mhvLimVRVrZLipDc=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 89E8660850;
        Wed, 15 May 2019 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557923736;
        bh=RPwOPoT9uzbHUfPdrm1EKq6ZA6S73yRB5cU5ZE4vTFQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hXOSew52hkHFmro4K45EZX8n2Xm075JUoCkLjcaAKoLLcASa4BpoTgbgjiP1ZYkC+
         TtOzCbicrRfkNNC2KK/akgmlr+WlsSeGet0Zy3mEWGJk4imwFsAaClDpKury5EZm5v
         JjA8STUgQvrKLGczmgwgPYK9mhvLimVRVrZLipDc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89E8660850
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] objtool: Allow AR to be overridden with HOSTAR
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <20190514224047.28505-1-natechancellor@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <2bdc6dfa-bbe8-208f-fab5-30d67573345c@codeaurora.org>
Date:   Wed, 15 May 2019 18:05:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514224047.28505-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/15/2019 4:10 AM, Nathan Chancellor wrote:
> Currently, this Makefile hardcodes GNU ar, meaning that if it is not
> available, there is no way to supply a different one and the build will
> fail.
>
> $ make AR=llvm-ar CC=clang LD=ld.lld HOSTAR=llvm-ar HOSTCC=clang \
>         HOSTLD=ld.lld HOSTLDFLAGS=-fuse-ld=lld defconfig modules_prepare
> ...
>    AR       /out/tools/objtool/libsubcmd.a
> /bin/sh: 1: ar: not found
> ...
>
> Follow the logic of HOST{CC,LD} and allow the user to specify a
> different ar tool via HOSTAR (which is used elsewhere in other
> tools/ Makefiles).
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/481
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>


Nice catch.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   tools/objtool/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 53f8be0f4a1f..88158239622b 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -7,11 +7,12 @@ ARCH := x86
>   endif
>   
>   # always use the host compiler
> +HOSTAR	?= ar
>   HOSTCC	?= gcc
>   HOSTLD	?= ld
> +AR	 = $(HOSTAR)
>   CC	 = $(HOSTCC)
>   LD	 = $(HOSTLD)
> -AR	 = ar
>   
>   ifeq ($(srctree),)
>   srctree := $(patsubst %/,%,$(dir $(CURDIR)))
