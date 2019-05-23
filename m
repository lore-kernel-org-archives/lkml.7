Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5690C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BB22075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbfEWQ5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:57:21 -0400
Received: from foss.arm.com ([217.140.101.70]:50896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfEWQ5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:57:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C6A374;
        Thu, 23 May 2019 09:51:55 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 669CC3F5AF;
        Thu, 23 May 2019 09:51:53 -0700 (PDT)
Date:   Thu, 23 May 2019 17:51:51 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com, liwei391@huawei.com
Subject: Re: [PATCH v2 0/5] arm64: IRQ priority masking and Pseudo-NMI fixes
Message-ID: <20190523165151.GB1716@fuggles.cambridge.arm.com>
References: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On Mon, Apr 29, 2019 at 05:00:02PM +0100, Julien Thierry wrote:
> [Changing the title to make it reflex more the status of the series.]
> 
> Version one[1] of this series attempted to fix the issue reported by
> Zenghui[2] when using the function_graph tracer with IRQ priority
> masking.
> 
> Since then, I realized that priority masking and the use of Pseudo-NMIs
> was more broken than I thought.

Do you plan to respin this in light of Marc's comments?

Will
