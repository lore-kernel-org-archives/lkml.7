Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE30C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C5F206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKUPPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:15:18 -0500
Received: from muru.com ([72.249.23.125]:43130 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfKUPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:15:18 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B1C4980DB;
        Thu, 21 Nov 2019 15:15:54 +0000 (UTC)
Date:   Thu, 21 Nov 2019 07:15:14 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: linux-next: Fixes tag needs some work in the omap tree
Message-ID: <20191121151514.GV35479@atomide.com>
References: <20191121072254.79e13f56@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121072254.79e13f56@canb.auug.org.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [191120 21:01]:
> Hi all,
> 
> In commit
> 
>   e130d53f2599 ("ARM: dts: dra7: fix cpsw mdio fck clock")
> 
> Fixes tag
> 
>   Fixes: commit 1faa415c9c6e ("ARM: dts: Add fck for cpsw mdio for omap variants")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Thanks I'll fix this in omap-for-v5.5/dt-v2 branch.

Regards,

Tony

