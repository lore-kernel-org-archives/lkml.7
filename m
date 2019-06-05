Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D5BC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A14206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfFEQHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:07:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfFEQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:07:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3CFD374;
        Wed,  5 Jun 2019 09:07:08 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C99B93F246;
        Wed,  5 Jun 2019 09:07:06 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:07:04 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        catalin.marinas@arm.com, mark.rutland@arm.com, liwei391@huawei.com
Subject: Re: [PATCH v2 0/5] arm64: IRQ priority masking and Pseudo-NMI fixes
Message-ID: <20190605160704.GP15030@fuggles.cambridge.arm.com>
References: <1556553607-46531-1-git-send-email-julien.thierry@arm.com>
 <20190523165151.GB1716@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523165151.GB1716@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Julien,

On Thu, May 23, 2019 at 05:51:55PM +0100, Will Deacon wrote:
> On Mon, Apr 29, 2019 at 05:00:02PM +0100, Julien Thierry wrote:
> > [Changing the title to make it reflex more the status of the series.]
> > 
> > Version one[1] of this series attempted to fix the issue reported by
> > Zenghui[2] when using the function_graph tracer with IRQ priority
> > masking.
> > 
> > Since then, I realized that priority masking and the use of Pseudo-NMIs
> > was more broken than I thought.
> 
> Do you plan to respin this in light of Marc's comments?

For now, I marked this as depending on BROKEN in mainline, but please can
you look at respinning these fixes so that we can get things fixed properly
for 5.3?

Thanks,

Will
