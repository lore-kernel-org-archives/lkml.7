Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B06C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8732147A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 12:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfFPMXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 08:23:55 -0400
Received: from ozlabs.org ([203.11.71.1]:35427 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfFPMXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 08:23:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45RYRY2N0zz9sNT; Sun, 16 Jun 2019 22:23:52 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b7f8b440f3001cc1775c028f0a783786113c2ae3
X-Patchwork-Hint: ignore
In-Reply-To: <be07403806abc56ec027f6d47468411876e18bb5.1560267983.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, erhard_f@mailbox.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix initial setup of segment registers on secondary CPU
Message-Id: <45RYRY2N0zz9sNT@ozlabs.org>
Date:   Sun, 16 Jun 2019 22:23:52 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-11 at 15:47:20 UTC, Christophe Leroy wrote:
> The patch referenced below moved the loading of segment registers
> out of load_up_mmu() in order to do it earlier in the boot sequence.
> However, the secondary CPU still needs it to be done when loading up
> the MMU.
> 
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Fixes: 215b823707ce ("powerpc/32s: set up an early static hash table for KASAN")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b7f8b440f3001cc1775c028f0a783786113c2ae3

cheers
