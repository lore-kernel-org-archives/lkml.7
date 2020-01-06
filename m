Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B44C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268A92080A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 23:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgAFXdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:33:21 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53753 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgAFXdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 18:33:20 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47sBdq0f5Dz9sRh; Tue,  7 Jan 2020 10:33:18 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fb185a4052b18c97ebc98f6a8db30a60abca35e0
In-Reply-To: <20191217073730.21249-1-peter.ujfalusi@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <agust@denx.de>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     vkoul@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/512x: Use dma_request_chan() instead dma_request_slave_channel()
Message-Id: <47sBdq0f5Dz9sRh@ozlabs.org>
Date:   Tue,  7 Jan 2020 10:33:18 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-17 at 07:37:30 UTC, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fb185a4052b18c97ebc98f6a8db30a60abca35e0

cheers
