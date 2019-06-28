Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684B4C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FD620645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfF1Q7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:59:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfF1Q7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:59:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2390A28;
        Fri, 28 Jun 2019 09:59:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6DB73F706;
        Fri, 28 Jun 2019 09:59:17 -0700 (PDT)
Date:   Fri, 28 Jun 2019 17:59:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Perf framework : Cluster based counter support
Message-ID: <20190628165915.GB5143@lakrids.cambridge.arm.com>
References: <7ce0c077-06ef-676f-1f7b-61f3ba8589d1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce0c077-06ef-676f-1f7b-61f3ba8589d1@codeaurora.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:23:10PM +0530, Mukesh Ojha wrote:
> Hi All,

Hi Mukesh,

> Is it looks considerable to add cluster based event support to add in
> current perf event framework and later in userspace perf to support
> such events ?

Could you elaborate on what you mean by "cluster based event"?

I assume you mean something like events for a cluster-affine shared
resource like some level of cache?

If so, there's a standard pattern for supporting such system/uncore
PMUs, see drivers/perf/qcom_l2_pmu.c and friends for examples.

Thanks,
Mark.
