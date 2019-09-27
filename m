Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF35AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B961D21850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfI0PGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:06:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbfI0PGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:06:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCE5028;
        Fri, 27 Sep 2019 08:06:03 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D91B03F534;
        Fri, 27 Sep 2019 08:06:02 -0700 (PDT)
Date:   Fri, 27 Sep 2019 16:06:00 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64/sve: Fix wrong free for task->thread.sve_state
Message-ID: <20190927150600.GR27757@arm.com>
References: <20190926190846.3072-1-msys.mizuma@gmail.com>
 <20190926190846.3072-2-msys.mizuma@gmail.com>
 <20190927125228.GQ27757@arm.com>
 <20190927143801.tpaohgbuzdheiwp3@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927143801.tpaohgbuzdheiwp3@gabell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 10:38:02AM -0400, Masayoshi Mizuma wrote:
> Hi Julien and Dave,
> 
> Thank you for your comments!
> Dave's suggestion looks good for me, many thanks!
> I'll post it as v2.

Please add Fixes and Cc: stable tags as appropriate.

(I'm happy not to push this patch myself, but I would expect to see a
Suggested-by tag...)

See Documentation/process/submitting-patches.rst,
Documentation/process/stable-kernel-rules.txt if unsure.

[...]

Cheers
---Dave
