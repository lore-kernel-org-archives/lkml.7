Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE62C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5918F2054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfEFNyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:54:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49731 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEFNyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:54:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44yPNZ30mBz9s9N; Mon,  6 May 2019 23:54:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 471e475c69a1689e059b5e57e893a7da75d2831a
X-Patchwork-Hint: ignore
In-Reply-To: <502da34ded576b9869b0f49146d465207fbd98ac.1557123466.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: Fix makefile for KASAN
Message-Id: <44yPNZ30mBz9s9N@ozlabs.org>
Date:   Mon,  6 May 2019 23:54:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-06 at 06:21:01 UTC, Christophe Leroy wrote:
> In commit 17312f258cf6 ("powerpc/mm: Move book3s32 specifics in
> subdirectory mm/book3s64"), ppc_mmu_32.c was moved and renamed.
> 
> This patch fixes Makefiles to disable KASAN instrumentation on
> the new name and location.
> 
> Fixes: f072015c7b74 ("powerpc: disable KASAN instrumentation on early/critical files.")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/471e475c69a1689e059b5e57e893a7da

cheers
