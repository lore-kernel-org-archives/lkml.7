Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD012083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfCSOvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:51:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfCSOvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:51:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 516421650;
        Tue, 19 Mar 2019 07:51:15 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC8513F71A;
        Tue, 19 Mar 2019 07:51:13 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:51:11 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm64-fixes
 tree
Message-ID: <20190319145111.GH59586@arrakis.emea.arm.com>
References: <20190320014312.562c8f6d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320014312.562c8f6d@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Mar 20, 2019 at 01:43:12AM +1100, Stephen Rothwell wrote:
> Commit
> 
>   a4d17a19c493 ("arm64: apply workaround on A64FX v1r0")
> 
> is missing a Signed-off-by from its author.

Thanks for this. The patch is indeed confusing, sent by Takayuki with a
signed-off-by from Zhang and re-written by Mark while keeping the
original text.

I'm going to make Mark the author while keeping Takayuki as reported-by.

-- 
Catalin
