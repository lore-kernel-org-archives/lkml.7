Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF12C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFA2205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfECHA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:00:26 -0400
Received: from ozlabs.org ([203.11.71.1]:36331 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfECG7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKF2n5tz9sBr; Fri,  3 May 2019 16:59:12 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9d9f2cccde952126185e3336af0d4dc62eb254ad
X-Patchwork-Hint: ignore
In-Reply-To: <1c8eb7526ed327c3317053d57ac34e8c652b5449.1553853405.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] powerpc/mm: change #include "mmu_decl.h" to <mm/mmu_decl.h>
Message-Id: <44wNKF2n5tz9sBr@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:13 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-29 at 09:59:59 UTC, Christophe Leroy wrote:
> This patch make inclusion of mmu_decl.h independant of the location
> of the file including it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9d9f2cccde952126185e3336af0d4dc6

cheers
