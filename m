Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B932AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989C3218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfGCO1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:27:16 -0400
Received: from ozlabs.org ([203.11.71.1]:52117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfGCO1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:27:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45f3Mt388Xz9sPD; Thu,  4 Jul 2019 00:27:06 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 63982618662e2a05e5c5c3e4247456d1d3467f32
In-Reply-To: <20190625145239.2759-2-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] powerpc/powernv: remove the unused pnv_pci_set_p2p function
Message-Id: <45f3Mt388Xz9sPD@ozlabs.org>
Date:   Thu,  4 Jul 2019 00:27:06 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 14:52:36 UTC, Christoph Hellwig wrote:
> This function has never been used anywhere in the kernel tree since it
> was added to the tree.  We also now have proper PCIe P2P APIs in the core
> kernel, and any new P2P support should be using those.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/63982618662e2a05e5c5c3e4247456d1d3467f32

cheers
