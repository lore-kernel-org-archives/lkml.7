Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D888C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0E820663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFZKVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:21:33 -0400
Received: from foss.arm.com ([217.140.110.172]:58022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfFZKVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:21:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 891B8C0A;
        Wed, 26 Jun 2019 03:21:32 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8AA33F718;
        Wed, 26 Jun 2019 03:21:31 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:21:29 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH] arm64/mm: Drop [PTE|PMD]_TYPE_FAULT
Message-ID: <20190626102129.GB1161@arrakis.emea.arm.com>
References: <1561538170-26594-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561538170-26594-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 02:06:10PM +0530, Anshuman Khandual wrote:
> This was added part of the original commit which added MMU definitions.
> 
> commit 4f04d8f00545 ("arm64: MMU definitions").
> 
> These symbols never got used as confirmed from a git log search.
> 
> git log -p arch/arm64/ | grep PTE_TYPE_FAULT
> git log -p arch/arm64/ | grep PMD_TYPE_FAULT
> 
> These probably meant to identify non present entries which can now be
> achieved with PMD_SECT_VALID or PTE_VALID bits. Hence just drop these
> unused symbols which are not required anymore.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks. Queued for 5.3.

-- 
Catalin
