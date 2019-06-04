Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC4CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC4524C08
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfFDMpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:45:20 -0400
Received: from foss.arm.com ([217.140.101.70]:42550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfFDMpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:45:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7B8A78;
        Tue,  4 Jun 2019 05:45:19 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 520933F690;
        Tue,  4 Jun 2019 05:45:18 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:45:15 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4 1/2] drivers: base: cacheinfo: Add variable to record
 max cache line size
Message-ID: <20190604124515.GB6610@arrakis.emea.arm.com>
References: <1559009814-17004-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559009814-17004-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:16:53AM +0800, Shaokun Zhang wrote:
> Add coherency_max_size variable to record the maximum cache line size
> for different cache levels. If it is available, we will synchronize
> it as cache line size, otherwise we will use CTR_EL0.CWG reporting
> in cache_line_size() for arm64.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Both patches queued for 5.3. Thanks.

-- 
Catalin
