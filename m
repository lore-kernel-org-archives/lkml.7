Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C21C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477652804D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFCMcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:32:55 -0400
Received: from ozlabs.org ([203.11.71.1]:44639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfFCMcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:32:50 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45HZFq6dddz9sN6; Mon,  3 Jun 2019 22:32:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: d667edc01bedcd23988ef69f851e7cc26cc3c67f
X-Patchwork-Hint: ignore
Content-Type: text/plain; charset="utf-8";
In-Reply-To: <20190504102427.12332-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <christophe.leroy@c-s.fr>,
        <aneesh.kumar@linux.vnet.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] powerpc/book3s64: Make some symbols static
Message-Id: <45HZFq6dddz9sN6@ozlabs.org>
Date:   Mon,  3 Jun 2019 22:32:47 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-05-04 at 10:24:27 UTC, YueHaibing wrote:
> Fix sparse warnings:
> 
> arch/powerpc/mm/book3s64/radix_pgtable.c:326:13: warning: symbol 'radix_init_pgtable' was not declared. Should it be static?
> arch/powerpc/mm/book3s64/hash_native.c:48:1: warning: symbol 'native_tlbie_lock' was not declared. Should it be static?
> arch/powerpc/mm/book3s64/hash_utils.c:988:24: warning: symbol 'init_hash_mm_context' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d667edc01bedcd23988ef69f851e7cc2

cheers
