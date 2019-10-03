Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF94EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 23:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B174222CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 23:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfJCXFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 19:05:48 -0400
Received: from ozlabs.org ([203.11.71.1]:34411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbfJCXFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 19:05:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46kpWs0pdbz9sPq; Fri,  4 Oct 2019 09:05:45 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9123b7914823a7d81dd0e5d8ae40bc6f1ee869c8
In-Reply-To: <20191001132928.72555-1-ldufour@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, sfr@linux.ibm.com,
        benh@kernel.crashing.org, paulus@samba.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Remove confusing warning message.
Message-Id: <46kpWs0pdbz9sPq@ozlabs.org>
Date:   Fri,  4 Oct 2019 09:05:45 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 13:29:28 UTC, Laurent Dufour wrote:
> Since the commit 1211ee61b4a8 ("powerpc/pseries: Read TLB Block Invalidate
> Characteristics"), a warning message is displayed when booting a guest on
> top of KVM:
> 
> lpar: arch/powerpc/platforms/pseries/lpar.c pseries_lpar_read_hblkrm_characteristics Error calling get-system-parameter (0xfffffffd)
> 
> This message is displayed because this hypervisor is not supporting the
> H_BLOCK_REMOVE hcall and thus is not exposing the corresponding feature.
> 
> Reading the TLB Block Invalidate Characteristics should not be done if the
> feature is not exposed.
> 
> Fixes: 1211ee61b4a8 ("powerpc/pseries: Read TLB Block Invalidate Characteristics")
> Reported-by: Stephen Rothwell <sfr@linux.ibm.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/9123b7914823a7d81dd0e5d8ae40bc6f1ee869c8

cheers
