Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E60C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585752428A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfFCMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:33:00 -0400
Received: from ozlabs.org ([203.11.71.1]:47467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfFCMc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45HZG14vJpz9sP6; Mon,  3 Jun 2019 22:32:57 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: efa9ace68e487ddd29c2b4d6dd23242158f1f607
X-Patchwork-Hint: ignore
Content-Type: text/plain; charset="utf-8";
In-Reply-To: <20190526024240.GA14546@zhanggen-UX430UQ>
To:     Gen Zhang <blackgod016574@gmail.com>, benh@kernel.crashing.org,
        paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dlpar: Fix a missing-check bug in dlpar_parse_cc_property()
Message-Id: <45HZG14vJpz9sP6@ozlabs.org>
Date:   Mon,  3 Jun 2019 22:32:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-05-26 at 02:42:40 UTC, Gen Zhang wrote:
> In dlpar_parse_cc_property(), 'prop->name' is allocated by kstrdup().
> kstrdup() may return NULL, so it should be checked and handle error.
> And prop should be freed if 'prop->name' is NULL.
> 
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Acked-by: Nathan Lynch <nathanl@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/efa9ace68e487ddd29c2b4d6dd232421

cheers
