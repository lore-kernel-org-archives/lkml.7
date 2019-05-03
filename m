Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE2C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97DD2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfECG7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:59:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfECG7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:11 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNK95Yvzz9sNf; Fri,  3 May 2019 16:59:09 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9c1d38b34e944cace44e0d2bea0beb5601a4d36d
X-Patchwork-Hint: ignore
In-Reply-To: <a2ac33258063682558fe0cac8eedcbd28aa4a141.1553242059.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] powerpc/fadump: define an empty fadump_cleanup()
Message-Id: <44wNK95Yvzz9sNf@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:09 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-22 at 08:08:39 UTC, Christophe Leroy wrote:
> To avoid #ifdefs, define an static inline fadump_cleanup() function
> when CONFIG_FADUMP is not selected
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c1d38b34e944cace44e0d2bea0beb56

cheers
