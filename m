Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68105C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442BE205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfECHAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:00:03 -0400
Received: from ozlabs.org ([203.11.71.1]:34865 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfECG7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:25 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKS2Df9z9sPR; Fri,  3 May 2019 16:59:24 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 447def3b06adab60b999417b316bd2352d7e643e
X-Patchwork-Hint: ignore
In-Reply-To: <e727e0a19c059566903745ee71a7bc5c46458dcb.1556293738.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] powerpc/mm: drop __bad_pte()
Message-Id: <44wNKS2Df9z9sPR@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:24 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 15:57:59 UTC, Christophe Leroy wrote:
> This has never been called (since Kernel has been in git at least),
> drop it.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/447def3b06adab60b999417b316bd235

cheers
