Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228BCC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3EB21670
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfE2KDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:03:43 -0400
Received: from foss.arm.com ([217.140.101.70]:42472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfE2KDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:03:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9374A341;
        Wed, 29 May 2019 03:03:42 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6034F3F5AF;
        Wed, 29 May 2019 03:03:41 -0700 (PDT)
Date:   Wed, 29 May 2019 11:03:38 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>, akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3.1 4/4] arm64: mm: Implement pte_devmap support
Message-ID: <20190529100338.GB4485@fuggles.cambridge.arm.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <817d92886fc3b33bcbf6e105ee83a74babb3a5aa.1558547956.git.robin.murphy@arm.com>
 <13026c4e64abc17133bbfa07d7731ec6691c0bcd.1559050949.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13026c4e64abc17133bbfa07d7731ec6691c0bcd.1559050949.git.robin.murphy@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:46:59PM +0100, Robin Murphy wrote:
> In order for things like get_user_pages() to work on ZONE_DEVICE memory,
> we need a software PTE bit to identify device-backed PFNs. Hook this up
> along with the relevant helpers to join in with ARCH_HAS_PTE_DEVMAP.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Fix to build correctly under all combinations of
> CONFIG_PGTABLE_LEVELS and CONFIG_TRANSPARENT_HUGEPAGE.
> 
>  arch/arm64/Kconfig                    |  1 +
>  arch/arm64/include/asm/pgtable-prot.h |  1 +
>  arch/arm64/include/asm/pgtable.h      | 21 +++++++++++++++++++++
>  3 files changed, 23 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

Andrew -- please can you update the previous version of this patch, which
I think you picked up?

Thanks,

Will
