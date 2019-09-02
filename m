Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8520FC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A352184D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfIBD3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:29:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729286AbfIBD3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:29:38 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46MFv41xF7z9sN1; Mon,  2 Sep 2019 13:29:36 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 63ce271b5e377deaddace4bac6dafb6e79d2bee4
In-Reply-To: <cdaf4bbbb64c288a077845846f04b12683f8875a.1566817807.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom: convert PROM_BUG() to standard trap
Message-Id: <46MFv41xF7z9sN1@ozlabs.org>
Date:   Mon,  2 Sep 2019 13:29:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-26 at 11:10:23 UTC, Christophe Leroy wrote:
> Prior to commit 1bd98d7fbaf5 ("ppc64: Update BUG handling based on
> ppc32"), BUG() family was using BUG_ILLEGAL_INSTRUCTION which
> was an invalid instruction opcode to trap into program check
> exception.
> 
> That commit converted them to using standard trap instructions,
> but prom/prom_init and their PROM_BUG() macro were left over.
> head_64.S and exception-64s.S were left aside as well.
> 
> Convert them to using the standard BUG infrastructure.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63ce271b5e377deaddace4bac6dafb6e79d2bee4

cheers
