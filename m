Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D78BC352A1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC14C246D0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfLMPDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:03:50 -0500
Received: from muru.com ([72.249.23.125]:47090 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLMPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 10:03:49 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 670AE8161;
        Fri, 13 Dec 2019 15:04:26 +0000 (UTC)
Date:   Fri, 13 Dec 2019 07:03:44 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] ARM: OMAP2+: Introduce cpuidle for am335x/am437x
Message-ID: <20191213150344.GJ35479@atomide.com>
References: <20191213030755.16096-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213030755.16096-1-d-gerlach@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [191212 19:07]:
> Hi,
> This series adds support for cpuidle on am335x and am437x using the
> cpuidle_arm driver. When testing on am335x-evm and am437x-gp-evm the
> follow power consumption reductions are seen on v5.5-rc1 baseline:
> 
> 
> Idling at command line, CPUFreq userspace governor to 300MHz:
>   am335x-evm:
>     VDD_MPU: 48 mW -> 5 mW
> 
>   am437x-gp-evm:
>     VDD_MPU: 32 mW -> 3 mW
> 
> 
> Idling at command line, CPUFreq userspace governor to 1GHz:
>   am335x-evm:
>     VDD_MPU: 313 mW -> 18 mW
> 
>   am437x-gp-evm:
>     VDD_MPU: 208 mW -> 10 mW

Hey this is great! A beverage on me when we get a chance :)

For merging, looks like I should take the series after folks are happy
with it. Santosh, care to review and ack if it looks OK?

Regards,

Tony
