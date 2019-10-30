Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A2CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3773A20862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 12:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJ3MOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 08:14:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43871 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfJ3MOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 08:14:20 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4736nk4Wzwz9sPj; Wed, 30 Oct 2019 23:14:18 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 29674a1c71be710f8418468aa6a8addd6d1aba1c
In-Reply-To: <1568733750-14580-1-git-send-email-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pkeys: remove unused pkey_allows_readwrite
Message-Id: <4736nk4Wzwz9sPj@ozlabs.org>
Date:   Wed, 30 Oct 2019 23:14:18 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-17 at 15:22:30 UTC, Qian Cai wrote:
> pkey_allows_readwrite() was first introduced in the commit 5586cf61e108
> ("powerpc: introduce execute-only pkey"), but the usage was removed
> entirely in the commit a4fcc877d4e1 ("powerpc/pkeys: Preallocate
> execute-only key").
> 
> Found by the "-Wunused-function" compiler warning flag.
> 
> Fixes: a4fcc877d4e1 ("powerpc/pkeys: Preallocate execute-only key")
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/29674a1c71be710f8418468aa6a8addd6d1aba1c

cheers
