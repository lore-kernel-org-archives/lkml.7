Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C54C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A358D2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfDUOSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:18:46 -0400
Received: from ozlabs.org ([203.11.71.1]:47237 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUOSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:18:46 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBdw2Yk0z9sB8; Mon, 22 Apr 2019 00:18:44 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e291b6d575bc6e4d1d36961b081be521a6c800d6
X-Patchwork-Hint: ignore
In-Reply-To: <17f151878f35fd449b9375308dd096f0d922746b.1552292207.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2, 03/10] powerpc/32: Remove MSR_PR test when returning from syscall
Message-Id: <44nBdw2Yk0z9sB8@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:18:44 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 08:30:30 UTC, Christophe Leroy wrote:
> syscalls are from user only, so we can account time without checking
> whether returning to kernel or user as it will only be user.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patches 3-10 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e291b6d575bc6e4d1d36961b081be521

cheers
