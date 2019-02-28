Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19F6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876402184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbfB1JVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:21:17 -0500
Received: from ozlabs.org ([203.11.71.1]:41657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfB1JVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:21:16 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4496Vf0vRHz9s9T; Thu, 28 Feb 2019 20:21:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 27da80719ef132cf8c80eb406d5aeb37dddf78cc
X-Patchwork-Hint: ignore
In-Reply-To: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Diana Craciun <diana.craciun@nxp.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/fsl: Fix the flush of branch predictor.
Message-Id: <4496Vf0vRHz9s9T@ozlabs.org>
Date:   Thu, 28 Feb 2019 20:21:13 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 18:18:48 UTC, Christophe Leroy wrote:
> The commit identified below adds MC_BTB_FLUSH macro only when
> CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error
> on some configs (seen several times with kisskb randconfig_defconfig)
> 
> arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc_btb_flush'
> make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-64e.o] Error 1
> make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2
> make[1]: *** [Makefile:1043: arch/powerpc] Error 2
> make: *** [Makefile:152: sub-make] Error 2
> 
> This patch adds a blank definition of MC_BTB_FLUSH for other cases.
> 
> Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)")
> Cc: Diana Craciun <diana.craciun@nxp.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/27da80719ef132cf8c80eb406d5aeb37

cheers
