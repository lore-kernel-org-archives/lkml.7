Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B3EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB1C206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfGHBUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:20:17 -0400
Received: from ozlabs.org ([203.11.71.1]:49559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfGHBTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfq75mmz9sNF; Mon,  8 Jul 2019 11:19:31 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1cfb725fb1899dc6fdc88f8b5354a65e8ad260c6
In-Reply-To: <239d1c8f15b8bedc161a234f9f1a22a07160dbdf.1557824379.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] powerpc/64: flush_inval_dcache_range() becomes flush_dcache_range()
Message-Id: <45hnfq75mmz9sNF@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:31 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-14 at 09:05:13 UTC, Christophe Leroy wrote:
> On most arches having function flush_dcache_range(), including PPC32,
> this function does a writeback and invalidation of the cache bloc.
> 
> On PPC64, flush_dcache_range() only does a writeback while
> flush_inval_dcache_range() does the invalidation in addition.
> 
> In addition it looks like within arch/powerpc/, there are no PPC64
> platforms using flush_dcache_range()
> 
> This patch drops the existing 64 bits version of flush_dcache_range()
> and renames flush_inval_dcache_range() into flush_dcache_range().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1cfb725fb1899dc6fdc88f8b5354a65e8ad260c6

cheers
