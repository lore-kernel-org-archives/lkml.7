Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCCBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D7B20700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfC0Lj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:39:26 -0400
Received: from ozlabs.org ([203.11.71.1]:59651 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfC0Lj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:39:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44TmHZ63c9z9sP1;
        Wed, 27 Mar 2019 22:39:22 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org
Subject: Re: Bad file pattern in MAINTAINERS section 'IBM Power Virtual Accelerator Switchboard'
In-Reply-To: <20190325233521.31094-1-joe@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com> <20190325233521.31094-1-joe@perches.com>
Date:   Wed, 27 Mar 2019 22:39:11 +1100
Message-ID: <87k1gko8bk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:
> A file pattern line in this section of the MAINTAINERS file in linux-next
> does not have a match in the linux source files.
>
> This could occur because a matching filename was never added, was deleted
> or renamed in some other commit.

I think it was removed before the final submission.

> The commits that added and if found renamed or removed the file pattern
> are shown below.
>
> Please fix this defect appropriately.

Sukadev can you send me a patch to fix it please?

cheers

> 1: ---------------------------------------------------------------------------
>
> linux-next MAINTAINERS section:
>
> 	7396	IBM Power Virtual Accelerator Switchboard
> 	7397	M:	Sukadev Bhattiprolu
> 	7398	L:	linuxppc-dev@lists.ozlabs.org
> 	7399	S:	Supported
> 	7400	F:	arch/powerpc/platforms/powernv/vas*
> 	7401	F:	arch/powerpc/platforms/powernv/copy-paste.h
> 	7402	F:	arch/powerpc/include/asm/vas.h
> -->	7403	F:	arch/powerpc/include/uapi/asm/vas.h
>
> 2: ---------------------------------------------------------------------------
>
> The most recent commit that added or modified file pattern 'arch/powerpc/include/uapi/asm/vas.h':
>
> commit 4dea2d1a927c61114a168d4509b56329ea6effb7
> Author: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date:   Mon Aug 28 23:23:33 2017 -0700
>
>     powerpc/powernv/vas: Define vas_init() and vas_exit()
>     
>     Implement vas_init() and vas_exit() functions for a new VAS module.
>     This VAS module is essentially a library for other device drivers
>     and kernel users of the NX coprocessors like NX-842 and NX-GZIP.
>     In the future this will be extended to add support for user space
>     to access the NX coprocessors.
>     
>     VAS is currently only supported with 64K page size.
>     
>     Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
>  .../devicetree/bindings/powerpc/ibm,vas.txt        |  22 +++
>  MAINTAINERS                                        |   8 ++
>  arch/powerpc/platforms/powernv/Kconfig             |  14 ++
>  arch/powerpc/platforms/powernv/Makefile            |   1 +
>  arch/powerpc/platforms/powernv/vas-window.c        |  19 +++
>  arch/powerpc/platforms/powernv/vas.c               | 151 +++++++++++++++++++++
>  arch/powerpc/platforms/powernv/vas.h               |   2 +
>  7 files changed, 217 insertions(+)
>
> 3: ---------------------------------------------------------------------------
>
> No commit with file pattern 'arch/powerpc/include/uapi/asm/vas.h' was found
