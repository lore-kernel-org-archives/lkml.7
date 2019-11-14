Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9583FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A13B206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 09:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfKNJJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 04:09:05 -0500
Received: from ozlabs.org ([203.11.71.1]:35501 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfKNJId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:33 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFyR2yKrz9sRK; Thu, 14 Nov 2019 20:08:30 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3775026a654c15c92c8ac2d53f3fd14fdd1980df
In-Reply-To: <20181102211707.10229-1-linux@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh: ans-lcd: make anslcd_logo static and __initconst
Message-Id: <47DFyR2yKrz9sRK@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:30 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-02 at 21:17:06 UTC, Rasmus Villemoes wrote:
> This variable has no reason to have external linkage, and since it is
> only used in an __init function, it might as well be made __initconst
> also.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3775026a654c15c92c8ac2d53f3fd14fdd1980df

cheers
