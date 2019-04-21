Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC83FC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4173218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfDUOTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:19:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58253 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfDUOTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:19:06 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBfJ3wrsz9sMx; Mon, 22 Apr 2019 00:19:04 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e663e1e06089773cdab03023563aead65cfed042
X-Patchwork-Hint: ignore
In-Reply-To: <20190407015447.39292-1-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
        oohall@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: powerpc/pseries/pmem: fix a set but not used value
Message-Id: <44nBfJ3wrsz9sMx@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:19:04 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-04-07 at 01:54:47 UTC, Qian Cai wrote:
> The commit 4c5d87db4978 ("powerpc/pseries: PAPR persistent memory
> support") set a local variable "count" in dlpar_hp_pmem() but never
> use it.
> 
> arch/powerpc/platforms/pseries/pmem.c: In function 'dlpar_hp_pmem':
> arch/powerpc/platforms/pseries/pmem.c:109:6: warning: variable 'count'
> set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e663e1e06089773cdab03023563aead6

cheers
