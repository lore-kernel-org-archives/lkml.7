Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3D420830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 00:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfCDAsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 19:48:13 -0500
Received: from ozlabs.org ([203.11.71.1]:59199 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfCDAsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 19:48:09 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44CLwm3ckwz9s47; Mon,  4 Mar 2019 11:48:08 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c38ca265525a00d635219450e8fcc858082ff630
X-Patchwork-Hint: ignore
In-Reply-To: <20190301142040.94204-1-cai@lca.pw>
To:     Qian Cai <cai@lca.pw>, benh@kernel.crashing.org, paulus@samba.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc/mm: fix "section_base" set but not used
Message-Id: <44CLwm3ckwz9s47@ozlabs.org>
Date:   Mon,  4 Mar 2019 11:48:08 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-01 at 14:20:40 UTC, Qian Cai wrote:
> The commit 24b6d4164348 ("mm: pass the vmem_altmap to vmemmap_free")
> removed a line in vmemmap_free(),
> 
> altmap = to_vmem_altmap((unsigned long) section_base);
> 
> but left a variable no longer used.
> 
> arch/powerpc/mm/init_64.c: In function 'vmemmap_free':
> arch/powerpc/mm/init_64.c:277:16: error: variable 'section_base' set but
> not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c38ca265525a00d635219450e8fcc858

cheers
