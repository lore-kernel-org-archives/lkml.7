Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E492C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4780A20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDDOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:15:17 -0400
Received: from muru.com ([72.249.23.125]:44356 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDOPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:15:16 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 137E180D4;
        Thu,  4 Apr 2019 14:15:30 +0000 (UTC)
Date:   Thu, 4 Apr 2019 07:15:13 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, t-kristo@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: timer-ti-dm: Remove unused
 omap_dm_timer_set_load_start
Message-ID: <20190404141513.GD49658@atomide.com>
References: <20190404063536.23958-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190404063536.23958-1-j-keerthy@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [190404 06:35]:
> omap_dm_timer_set_load_start is no longer used hence delete the
> function and remove the below warning.
> 
> drivers/clocksource/timer-ti-dm.c:589:12:
> warning: ‘omap_dm_timer_set_load_start’ defined but not used

Hmm see earlier "[PATCH] clocksource/drivers/timer-ti-dm: Remove
omap_dm_timer_set_load_start", I think this is a duplicate.

Regards,

Tony
