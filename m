Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D0C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED322075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfKYKrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:47:08 -0500
Received: from ozlabs.org ([203.11.71.1]:34861 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfKYKrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3d30tHfz9sR1; Mon, 25 Nov 2019 21:47:02 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: eafd687e689acd99d780e468d6a0622f4694d0bc
In-Reply-To: <f816ccdbd15b97cf43c5a8c7cc8dfa8db58ff036.1568294935.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/8xx: use the fixmapped IMMR in cpm_reset()
Message-Id: <47M3d30tHfz9sR1@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:47:02 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 13:29:07 UTC, Christophe Leroy wrote:
> Since commit f86ef74ed919 ("powerpc/8xx: Fix vaddr for IMMR early
> remap"), the IMMR area has been mapped at startup with fixmap.
> 
> Use that fixmap directly instead of calling ioremap(), this
> avoids calling ioremap() early before the slab is available.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eafd687e689acd99d780e468d6a0622f4694d0bc

cheers
