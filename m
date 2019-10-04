Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AF1222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfJDQ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:29:40 -0400
Received: from foss.arm.com ([217.140.110.172]:49732 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731517AbfJDQ3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:29:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D5B81597;
        Fri,  4 Oct 2019 09:29:31 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3F63F68E;
        Fri,  4 Oct 2019 09:29:30 -0700 (PDT)
Date:   Fri, 4 Oct 2019 17:29:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Julien Grall <julien.grall@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64/cpufeature: Fix + doc update
Message-ID: <20191004162928.GK638@arrakis.emea.arm.com>
References: <20191003111211.483-1-julien.grall@arm.com>
 <20191004103721.tnjii772ts72pnm5@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004103721.tnjii772ts72pnm5@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:37:22AM +0100, Will Deacon wrote:
> On Thu, Oct 03, 2019 at 12:12:07PM +0100, Julien Grall wrote:
> > This patch fix an issue related to exposing the FRINT capability to
> > userspace (see patch #1). The rest is documentation update.
> >
> For patches 2-4:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Catalin can take them for 5.5, since I don't think they're urgent.

Queued. Thanks.

-- 
Catalin
