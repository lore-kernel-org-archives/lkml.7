Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B791DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A25120650
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfJORak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:30:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfJORak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:30:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91900337;
        Tue, 15 Oct 2019 10:30:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D9DB3F68E;
        Tue, 15 Oct 2019 10:30:38 -0700 (PDT)
Date:   Tue, 15 Oct 2019 18:30:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] arm64: Relax ICC_PMR_EL1 synchronisation when
 possible
Message-ID: <20191015173035.GN13874@arrakis.emea.arm.com>
References: <20191002090613.14236-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002090613.14236-1-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 10:06:11AM +0100, Marc Zyngier wrote:
> This is a very late update on [1], fixing the 32bit compilation issue that
> was present in v2, and adding an extra message in the kernel log to find out
> what is going on.
> 
> [1] http://lore.kernel.org/r/20190802125208.73162-1-maz@kernel.org
> 
> Marc Zyngier (2):
>   arm64: Relax ICC_PMR_EL1 accesses when ICC_CTLR_EL1.PMHE is clear
>   arm64: Document ICC_CTLR_EL3.PMHE setting requirements

Queued for 5.5. Thanks.

-- 
Catalin
