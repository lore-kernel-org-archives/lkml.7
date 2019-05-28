Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81868C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61646206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 14:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfE1OMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 10:12:40 -0400
Received: from foss.arm.com ([217.140.101.70]:58252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbfE1OMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 10:12:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D36780D;
        Tue, 28 May 2019 07:12:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10193F5AF;
        Tue, 28 May 2019 07:12:35 -0700 (PDT)
Date:   Tue, 28 May 2019 15:12:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Richard Henderson <rth@twiddle.net>,
        Matt Turner <mattst88@gmail.com>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-kernel@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>,
        linux-alpha@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 4/5] kconfig: make arch/*/configs/defconfig the default
 of KBUILD_DEFCONFIG
Message-ID: <20190528141232.GC32006@arrakis.emea.arm.com>
References: <20190527143725.12542-1-yamada.masahiro@socionext.com>
 <20190527143725.12542-4-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527143725.12542-4-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 11:37:24PM +0900, Masahiro Yamada wrote:
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b025304bde46..970c41a30ed3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -30,8 +30,6 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
>    endif
>  endif
>  
> -KBUILD_DEFCONFIG := defconfig
> -
>  # Check for binutils support for specific extensions
>  lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
