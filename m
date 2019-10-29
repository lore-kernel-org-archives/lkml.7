Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A7CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B952320874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbfJ2Plk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:41:40 -0400
Received: from foss.arm.com ([217.140.110.172]:53556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390107AbfJ2Plk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:41:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD2A01F1;
        Tue, 29 Oct 2019 08:41:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49683F71F;
        Tue, 29 Oct 2019 08:41:38 -0700 (PDT)
Date:   Tue, 29 Oct 2019 15:41:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2] arm64: print additional fault message when executing
 non-exec memory
Message-ID: <20191029154135.GD11440@arrakis.emea.arm.com>
References: <20191029124131.32028-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029124131.32028-1-zhengxiang9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 08:41:31PM +0800, Xiang Zheng wrote:
> When attempting to executing non-executable memory, the fault message
> shows:
> 
>   Unable to handle kernel read from unreadable memory at virtual address
>   ffff802dac469000
> 
> This may confuse someone, so add a new fault message for instruction
> abort.
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

Queued for 5.5. Thanks.

-- 
Catalin
