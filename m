Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D70C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E5124278
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfFCMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:32:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCMcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:52 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45HZFt61Ynz9sNl; Mon,  3 Jun 2019 22:32:49 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f8e0d0fddf87f26aed576983f752329de4c0900f
X-Patchwork-Hint: ignore
Content-Type: text/plain; charset="utf-8";
In-Reply-To: <7496da89e027e563cb8e62dc89548525cf53b57e.1557741292.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/lib: fix redundant inclusion of quad.o
Message-Id: <45HZFt61Ynz9sNl@ozlabs.org>
Date:   Mon,  3 Jun 2019 22:32:49 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 10:00:14 UTC, Christophe Leroy wrote:
> quad.o is only for PPC64, and already included in obj64-y,
> so it doesn't have to be in obj-y
> 
> Fixes: 31bfdb036f12 ("powerpc: Use instruction emulation infrastructure to handle alignment faults")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f8e0d0fddf87f26aed576983f752329d

cheers
