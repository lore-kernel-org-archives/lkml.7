Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E10C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BB020857
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfDUOSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:18:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUOSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:18:43 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBdt1tHHz9s8m; Mon, 22 Apr 2019 00:18:42 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6c84f8c5cbfb4bf728f88296bc035c4a401c3423
X-Patchwork-Hint: ignore
In-Reply-To: <0365f99ce2b9273e269a241394957cba924f995e.1551951985.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/highmem: change BUG_ON() to WARN_ON()
Message-Id: <44nBdt1tHHz9s8m@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:18:42 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 09:47:50 UTC, Christophe Leroy wrote:
> In arch/powerpc/mm/highmem.c, BUG_ON() is called only when
> CONFIG_DEBUG_HIGHMEM is selected, this means the BUG_ON() is
> not vital and can be replaced by a a WARN_ON
> 
> At the sametime, use IS_ENABLED() instead of #ifdef to clean a bit.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6c84f8c5cbfb4bf728f88296bc035c4a

cheers
