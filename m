Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A7221726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbfHVNJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:09:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388957AbfHVNJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGs1HPYz9sNk; Thu, 22 Aug 2019 23:09:07 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d9642117914c9d3f800b3bacc19d7e388b04edb4
In-Reply-To: <668aba4db6b9af6d8a151174e11a4289f1a6bbcd.1565933217.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] powerpc/mm: define empty update_mmu_cache() as static inline
Message-Id: <46DlGs1HPYz9sNk@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:07 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-16 at 05:41:40 UTC, Christophe Leroy wrote:
> Only BOOK3S and FSL_BOOK3E have a usefull update_mmu_cache().
> 
> For the others, just define it static inline.
> 
> In the meantime, simplify the FSL_BOOK3E related ifdef as
> book3e_hugetlb_preload() only exists when CONFIG_PPC_FSL_BOOK3E
> is selected.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d9642117914c9d3f800b3bacc19d7e388b04edb4

cheers
