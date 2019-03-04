Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8708E20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfCDAsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:48:22 -0500
Received: from ozlabs.org ([203.11.71.1]:45517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfCDAsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:48:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44CLwl5G0Yz9sN6; Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8132cf115efc3b3684bb5fd3bfdf6860886f0e47
X-Patchwork-Hint: ignore
In-Reply-To: <20190228023505.80092-1-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: powerpc: fix "sz" set but not used
Message-Id: <44CLwl5G0Yz9sN6@ozlabs.org>
Date:   Mon,  4 Mar 2019 11:48:07 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 02:35:05 UTC, Qian Cai wrote:
> arch/powerpc/mm/hugetlbpage-hash64.c: In function '__hash_page_huge':
> arch/powerpc/mm/hugetlbpage-hash64.c:29:28: warning: variable 'sz' set
> but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8132cf115efc3b3684bb5fd3bfdf6860

cheers
