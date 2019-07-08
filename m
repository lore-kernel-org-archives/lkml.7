Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF525C48BE3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24C9206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfGHBTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:19:36 -0400
Received: from ozlabs.org ([203.11.71.1]:57457 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfGHBTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfr1rqRz9sNC; Mon,  8 Jul 2019 11:19:32 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d98fc70fc139b72ae098d24fde42ad70c8ff2f81
In-Reply-To: <139368cc27b054f6fe155011dad63ef753db036e.1557824379.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] powerpc/32: define helpers to get L1 cache sizes.
Message-Id: <45hnfr1rqRz9sNC@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:32 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-14 at 09:05:15 UTC, Christophe Leroy wrote:
> This patch defines C helpers to retrieve the size of
> cache blocks and uses them in the cacheflush functions.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d98fc70fc139b72ae098d24fde42ad70c8ff2f81

cheers
