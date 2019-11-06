Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF09CC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CE02077C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfKFLRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:17:51 -0500
Received: from foss.arm.com ([217.140.110.172]:38072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfKFLRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:17:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9152A7A7;
        Wed,  6 Nov 2019 03:17:48 -0800 (PST)
Received: from arrakis.emea.arm.com (unknown [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C55D43F6C4;
        Wed,  6 Nov 2019 03:17:46 -0800 (PST)
Date:   Wed, 6 Nov 2019 11:17:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        David Hildenbrand <david@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Zhao <yuzhao@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: simplify the page end calculation in
 __create_pgd_mapping()
Message-ID: <20191106111743.GF21133@arrakis.emea.arm.com>
References: <20191103123559.8866-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103123559.8866-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 09:35:58PM +0900, Masahiro Yamada wrote:
> Calculate the page-aligned end address more simply.
> 
> The local variable, "length" is unneeded.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Queued for 5.5. Thanks.

-- 
Catalin
