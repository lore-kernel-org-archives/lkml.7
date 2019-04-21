Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E3C282E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C11218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 14:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfDUOSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 10:18:51 -0400
Received: from ozlabs.org ([203.11.71.1]:41077 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfDUOSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 10:18:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44nBdy3VY4z9sB3; Mon, 22 Apr 2019 00:18:45 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f172acbfae1a78b1a3c775f78e8d0dcd15b9d768
X-Patchwork-Hint: ignore
In-Reply-To: <20190313102528.4632-1-lvivier@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, Laurent Vivier <lvivier@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [v3] powerpc/mm: move warning from resize_hpt_for_hotplug()
Message-Id: <44nBdy3VY4z9sB3@ozlabs.org>
Date:   Mon, 22 Apr 2019 00:18:45 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 10:25:28 UTC, Laurent Vivier wrote:
> resize_hpt_for_hotplug() reports a warning when it cannot
> resize the hash page table ("Unable to resize hash page
> table to target order") but in some cases it's not a problem
> and can make user thinks something has not worked properly.
> 
> This patch moves the warning to arch_remove_memory() to
> only report the problem when it is needed.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f172acbfae1a78b1a3c775f78e8d0dcd

cheers
