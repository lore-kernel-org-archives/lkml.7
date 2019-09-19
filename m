Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF482C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B6521927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfISK0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:26:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389338AbfISK0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:26:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46YtKk2RyPz9sPf; Thu, 19 Sep 2019 20:26:02 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1fdfa4c6af0cc1854b017f308af6bece94568bb6
In-Reply-To: <20190912074037.13813-1-yamada.masahiro@socionext.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: improve prom_init_check rule
Message-Id: <46YtKk2RyPz9sPf@ozlabs.org>
Date:   Thu, 19 Sep 2019 20:26:02 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 07:40:37 UTC, Masahiro Yamada wrote:
> This slightly improves the prom_init_check rule.
> 
> [1] Avoid needless check
> 
> Currently, prom_init_check.sh is invoked every time you run 'make'
> even if you have changed nothing in prom_init.c. With this commit,
> the script is re-run only when prom_init.o is recompiled.
> 
> [2] Beautify the build log
> 
> Currently, the O= build shows the absolute path to the script:
> 
>   CALL    /abs/path/to/source/of/linux/arch/powerpc/kernel/prom_init_check.sh
> 
> With this commit, it is always a relative path to the timestamp file:
> 
>   PROMCHK arch/powerpc/kernel/prom_init_check
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1fdfa4c6af0cc1854b017f308af6bece94568bb6

cheers
