Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EE821726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389009AbfHVNJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:09:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388918AbfHVNJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGl5D8rz9sPW; Thu, 22 Aug 2019 23:09:03 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7c7a532ba3fc51bf9527d191fb410786c1fdc73c
In-Reply-To: <eb4d626514e22f85814830012642329018ef6af9.1565786091.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] powerpc/ptdump: fix addresses display on PPC32
Message-Id: <46DlGl5D8rz9sPW@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-14 at 12:36:09 UTC, Christophe Leroy wrote:
> Commit 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
> wrongly changed KERN_VIRT_START from 0 to PAGE_OFFSET, leading to a
> shift in the displayed addresses.
> 
> Lets revert that change to resync walk_pagetables()'s addr val and
> pgd_t pointer for PPC32.
> 
> Fixes: 453d87f6a8ae ("powerpc/mm: Warn if W+X pages found on boot")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7c7a532ba3fc51bf9527d191fb410786c1fdc73c

cheers
