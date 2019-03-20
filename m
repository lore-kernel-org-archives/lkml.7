Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDC2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F152184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfCTRlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:41:14 -0400
Received: from foss.arm.com ([217.140.101.70]:43930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfCTRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:41:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BBDDA78;
        Wed, 20 Mar 2019 10:41:13 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F0113F614;
        Wed, 20 Mar 2019 10:41:12 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:41:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove obsolete selection of MULTI_IRQ_HANDLER
Message-ID: <20190320174109.GA38229@arrakis.emea.arm.com>
References: <CAG5bF+TKCJp8Pvmf888GPrJ58ZAOoZpH7Yo94pLgpqWmPt4nvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG5bF+TKCJp8Pvmf888GPrJ58ZAOoZpH7Yo94pLgpqWmPt4nvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:20:56AM -0700, Matthias Kaehlcke wrote:
> The arm64 config selects MULTI_IRQ_HANDLER, which was renamed to
> GENERIC_IRQ_MULTI_HANDLER by commit 4c301f9b6a94 ("ARM: Convert
> to GENERIC_IRQ_MULTI_HANDLER"). The 'new' option is already
> selected, so just remove the obsolete entry.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Queued for 5.1-rc2. Thanks.

-- 
Catalin
