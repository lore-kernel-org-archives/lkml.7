Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B8BC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB3121479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389798AbfIJOcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:32:14 -0400
Received: from muru.com ([72.249.23.125]:60488 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388484AbfIJOcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:32:08 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 824BA8027;
        Tue, 10 Sep 2019 14:32:38 +0000 (UTC)
Date:   Tue, 10 Sep 2019 07:32:04 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the omap-fixes tree
Message-ID: <20190910143204.GR52127@atomide.com>
References: <20190911000818.6539fd35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911000818.6539fd35@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Stephen Rothwell <sfr@canb.auug.org.au> [190910 14:25]:
> Hi all,
> 
> In commit
> 
>   a932b77b4d19 ("ARM: dts: logicpd-som-lv: Fix i2c2 and i2c3 Pin mux")
> 
> Fixes tag
> 
>   Fixes: 5fe3c0fa0d54 ("ARM: dts: Add pinmuxing for i2c2 and i2c3
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line (and also just
> keep them with all the other tags).

Oops sorry I missed that again, will try to be more careful
the next time. I really should have some automated checks
in place for that..

Regards,

Tony
