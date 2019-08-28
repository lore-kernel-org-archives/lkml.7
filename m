Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F0FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0051D2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 04:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfH1EY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:24:58 -0400
Received: from ozlabs.org ([203.11.71.1]:52953 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfH1EYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 00:24:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46JCM65tstz9sP9; Wed, 28 Aug 2019 14:24:50 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b4645ffc49cfe34f67feda20c34bd7a859c78312
In-Reply-To: <a8b567c569aa521a7cf1beb061d43d79070e850c.1566492229.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64: don't select ARCH_HAS_SCALED_CPUTIME on book3E
Message-Id: <46JCM65tstz9sP9@ozlabs.org>
Date:   Wed, 28 Aug 2019 14:24:50 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-22 at 16:44:05 UTC, Christophe Leroy wrote:
> Book3E doesn't have SPRN_SPURR/SPRN_PURR.
> 
> Activating ARCH_HAS_SCALED_CPUTIME is just wasting CPU time.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Link: https://github.com/linuxppc/issues/issues/171

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b4645ffc49cfe34f67feda20c34bd7a859c78312

cheers
