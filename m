Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCA7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88C214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 10:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfGVKnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 06:43:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfGVKnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:43:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FDC328;
        Mon, 22 Jul 2019 03:43:15 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73D33F71A;
        Mon, 22 Jul 2019 03:43:14 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:43:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <Steve.Capper@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64/mm: Drop pte_huge()
Message-ID: <20190722104312.GD60625@arrakis.emea.arm.com>
References: <1562045575-8742-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562045575-8742-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 11:02:55AM +0530, Anshuman Khandual wrote:
> This helper is required from generic huge_pte_alloc() which is available
> when arch subscribes ARCH_WANT_GENERAL_HUGETLB. arm64 implements it's own
> huge_pte_alloc() and does not depend on the generic definition. Drop this
> helper which is redundant on arm64.

I had this on my list for 5.3 but the arm64 for-next/core was already
frozen. Will can queue this whenever he sees fit.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
