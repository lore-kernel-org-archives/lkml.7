Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24267C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B0C2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 11:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfERLPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 07:15:06 -0400
Received: from ozlabs.org ([203.11.71.1]:41647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERLPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 07:15:05 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 455jHW4zv1z9s9y; Sat, 18 May 2019 21:15:03 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 672eaf37db9f99fd794eed2c68a8b3b05d484081
X-Patchwork-Hint: ignore
In-Reply-To: <20190515090750.30647-1-tobin@kernel.org>
To:     "Tobin C. Harding" <tobin@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Tobin C. Harding" <tobin@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Remove double free
Message-Id: <455jHW4zv1z9s9y@ozlabs.org>
Date:   Sat, 18 May 2019 21:15:03 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 09:07:50 UTC, "Tobin C. Harding" wrote:
> kfree() after kobject_put().  Who ever wrote this was on crack.
> 
> Fixes: 7e8039795a80 ("powerpc/cacheinfo: Fix kobject memleak")
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/672eaf37db9f99fd794eed2c68a8b3b0

cheers
