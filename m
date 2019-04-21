Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC934C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C582B2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfDUOTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:19:12 -0400
Received: from ozlabs.org ([203.11.71.1]:34257 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbfDUOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:19:10 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBfN2lTMz9sB3; Mon, 22 Apr 2019 00:19:08 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 679d03f26a686dd609afd94fd7caad7d406eb36e
X-Patchwork-Hint: ignore
In-Reply-To: <20190411013846.GA5628@us.ibm.com>
To:     Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: MAINTAINERS: Remove non-existent VAS file
Message-Id: <44nBfN2lTMz9sB3@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:19:08 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-11 at 01:38:46 UTC, Sukadev Bhattiprolu wrote:
> The file arch/powerpc/include/uapi/asm/vas.h was considered but
> never merged and should be removed from the MAINTAINERS file.
> 
> While here, add missing email address.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/679d03f26a686dd609afd94fd7caad7d

cheers
