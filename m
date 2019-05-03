Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E16C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC6E2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfECG7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:59:23 -0400
Received: from ozlabs.org ([203.11.71.1]:50095 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfECG7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:22 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44wNKN5qYbz9sPT; Fri,  3 May 2019 16:59:20 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5266e58d6cd90ac85c187d673093ad9cb649e16d
X-Patchwork-Hint: ignore
In-Reply-To: <20190415115211.16374-1-laurentiu.tudor@nxp.com>
To:     laurentiu.tudor@nxp.com, linuxppc-dev@lists.ozlabs.org,
        oss@buserror.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2] powerpc/booke64: set RI in default MSR
Message-Id: <44wNKN5qYbz9sPT@ozlabs.org>
Date:   Fri,  3 May 2019 16:59:20 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-15 at 11:52:11 UTC, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Set RI in the default kernel's MSR so that the architected way of
> detecting unrecoverable machine check interrupts has a chance to work.
> This is inline with the MSR setup of the rest of booke powerpc
> architectures configured here.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: stable@vger.kernel.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5266e58d6cd90ac85c187d673093ad9c

cheers
