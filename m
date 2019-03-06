Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA37C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62120657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbfCFTC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:02:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39344 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730344AbfCFTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:02:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 610A7105D26D5;
        Wed,  6 Mar 2019 11:02:24 -0800 (PST)
Date:   Wed, 06 Mar 2019 11:02:23 -0800 (PST)
Message-Id: <20190306.110223.879768694292631517.davem@davemloft.net>
To:     steven.price@arm.com
Cc:     linux-mm@kvack.org, luto@kernel.org, ard.biesheuvel@linaro.org,
        arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, mingo@redhat.com, james.morse@arm.com,
        jglisse@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will.deacon@arm.com, x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark.Rutland@arm.com, kan.liang@linux.intel.com,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 07/19] sparc: mm: Add p?d_large() definitions
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306155031.4291-8-steven.price@arm.com>
References: <20190306155031.4291-1-steven.price@arm.com>
        <20190306155031.4291-8-steven.price@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Mar 2019 11:02:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Price <steven.price@arm.com>
Date: Wed,  6 Mar 2019 15:50:19 +0000

> walk_page_range() is going to be allowed to walk page tables other than
> those of user space. For this it needs to know when it has reached a
> 'leaf' entry in the page tables. This information is provided by the
> p?d_large() functions/macros.
> 
> For sparc 64 bit, pmd_large() and pud_large() are already provided, so
> add #defines to prevent the generic versions (added in a later patch)
> from being used.
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> Signed-off-by: Steven Price <steven.price@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
