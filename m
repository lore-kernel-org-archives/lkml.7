Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B89C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57F620663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbfCFTU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:20:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfCFTU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:20:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 029451454DBAD;
        Wed,  6 Mar 2019 11:20:23 -0800 (PST)
Date:   Wed, 06 Mar 2019 11:20:23 -0800 (PST)
Message-Id: <20190306.112023.204648705168304981.davem@davemloft.net>
To:     alex@ghiti.fr
Cc:     vbabka@suse.cz, catalin.marinas@arm.com, will.deacon@arm.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mike.kravetz@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 4/4] hugetlb: allow to free gigantic pages
 regardless of the configuration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306190005.7036-5-alex@ghiti.fr>
References: <20190306190005.7036-1-alex@ghiti.fr>
        <20190306190005.7036-5-alex@ghiti.fr>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Mar 2019 11:20:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Ghiti <alex@ghiti.fr>
Date: Wed,  6 Mar 2019 14:00:05 -0500

> On systems without CONTIG_ALLOC activated but that support gigantic pages,
> boottime reserved gigantic pages can not be freed at all. This patch
> simply enables the possibility to hand back those pages to memory
> allocator.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

For sparc:

Acked-by: David S. Miller <davem@davemloft.net>
