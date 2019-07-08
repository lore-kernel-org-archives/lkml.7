Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A15C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856CB2070D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfGHBTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:19:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34353 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfGHBTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:33 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hnfp6SlLz9sP0; Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6c5875843b87c3adea2beade9d1b8b3d4523900a
In-Reply-To: <c6ff2faba7fbb56a7f5b5f08cd3453f89fc0aaf4.1557480165.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: slightly improve cache helpers
Message-Id: <45hnfp6SlLz9sP0@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 09:24:48 UTC, Christophe Leroy wrote:
> Cache instructions (dcbz, dcbi, dcbf and dcbst) take two registers
> that are summed to obtain the target address. Using 'Z' constraint
> and '%y0' argument gives GCC the opportunity to use both registers
> instead of only one with the second being forced to 0.
> 
> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6c5875843b87c3adea2beade9d1b8b3d4523900a

cheers
