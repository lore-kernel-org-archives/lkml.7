Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86441C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600EA21473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDHNDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:03:43 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHNDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:03:41 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44d9bG6lLhz9sQr; Mon,  8 Apr 2019 23:03:38 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: dd9a994fc68d196a052b73747e3366c57d14a09e
X-Patchwork-Hint: ignore
In-Reply-To: <0d8c9cb7fb43bde8663333bb6a69d16380a219a5.1554380255.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christian Zigotzky <chzigotzky@xenosoft.de>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/vdso32: fix CLOCK_MONOTONIC on PPC64
Message-Id: <44d9bG6lLhz9sQr@ozlabs.org>
Date:   Mon,  8 Apr 2019 23:03:38 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-04 at 12:20:05 UTC, Christophe Leroy wrote:
> Commit b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC
> inconsistencies across Y2038") changed the type of wtom_clock_sec
> to s64 on PPC64. Therefore, VDSO32 needs to read it with a 4 bytes
> shift in order to retrieve the lower part of it.
> 
> Fixes: b5b4453e7912 ("powerpc/vdso64: Fix CLOCK_MONOTONIC inconsistencies across Y2038")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/dd9a994fc68d196a052b73747e3366c5

cheers
