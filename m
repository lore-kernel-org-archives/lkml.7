Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD9C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8A120675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfLDNa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:30:57 -0500
Received: from ozlabs.org ([203.11.71.1]:55827 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfLDNa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:30:56 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47Sfqy1cy5z9sR7; Thu,  5 Dec 2019 00:30:53 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 71eb40fc53371bc247c8066ae76ad9e22ae1e18d
In-Reply-To: <b58426f1664a4b344ff696d18cacf3b3e8962111.1575036985.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, shaolexi@huawei.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kasan: fix boot failure with RELOCATABLE && FSL_BOOKE
Message-Id: <47Sfqy1cy5z9sR7@ozlabs.org>
Date:   Thu,  5 Dec 2019 00:30:53 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-29 at 14:26:41 UTC, Christophe Leroy wrote:
> When enabling CONFIG_RELOCATABLE and CONFIG_KASAN on FSL_BOOKE,
> the kernel doesn't boot.
> 
> relocate_init() requires KASAN early shadow area to be set up because
> it needs access to the device tree through generic functions.
> 
> Call kasan_early_init() before calling relocate_init()
> 
> Reported-by: Lexi Shao <shaolexi@huawei.com>
> Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/71eb40fc53371bc247c8066ae76ad9e22ae1e18d

cheers
