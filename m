Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB968C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5A3206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 16:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKNQvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 11:51:02 -0500
Received: from muru.com ([72.249.23.125]:42230 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfKNQvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:51:02 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5654080E7;
        Thu, 14 Nov 2019 16:51:38 +0000 (UTC)
Date:   Thu, 14 Nov 2019 08:50:58 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: dra7-atl: Remove pm_runtime_irq_safe()
Message-ID: <20191114165058.GQ5610@atomide.com>
References: <20191114101718.20619-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114101718.20619-1-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191114 10:16]:
> This is not needed for anything, and prevents proper PM transitions for
> parent devices which is bad in case of ti-sysc; this effectively kills
> PM completely. Thus, remove the flag.

Good to hear and thanks for clearing this one:

Reviewed-by: Tony Lindgren <tony@atomide.com>
