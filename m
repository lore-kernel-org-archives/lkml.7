Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6418FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4560D2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKYKrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:47:02 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42503 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfKYKrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:47:00 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47M3cy2crzz9sR1; Mon, 25 Nov 2019 21:46:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a2227a27774328507a5c2335a6dd600c079d1ff5
In-Reply-To: <c8610942203e0d93fcb02ad20c57edd3adb4c9d3.1566554029.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Don't populate page tables for block mapped pages except on the 8xx.
Message-Id: <47M3cy2crzz9sR1@ozlabs.org>
Date:   Mon, 25 Nov 2019 21:46:58 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-23 at 09:56:21 UTC, Christophe Leroy wrote:
> Commit d2f15e0979ee ("powerpc/32: always populate page tables for
> Abatron BDI.") wrongly sets page tables for any PPC32 for using BDI,
> and does't update them after init (remove RX on init section, set
> text and rodata read-only)
> 
> Only the 8xx requires page tables to be populated for using the BDI.
> They also need to be populated in order to see the mappings in
> /sys/kernel/debug/kernel_page_tables
> 
> On BOOK3S_32, pages that are not mapped by page tables are mapped
> by BATs. The BDI knows BATs and they can be viewed in
> /sys/kernel/debug/powerpc/block_address_translation
> 
> Only set pagetables for RAM and IMMR on the 8xx and properly update
> them at the end of init.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a2227a27774328507a5c2335a6dd600c079d1ff5

cheers
