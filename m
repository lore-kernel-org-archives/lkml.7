Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465942064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfDBQWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:22:07 -0400
Received: from muru.com ([72.249.23.125]:44014 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbfDBQWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:22:07 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9459F805F;
        Tue,  2 Apr 2019 16:22:21 +0000 (UTC)
Date:   Tue, 2 Apr 2019 09:22:04 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     nsekhar@ti.com, s-anna@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] ARM: dts: dra7: Keep usb_otg_ss3 and usb_otg_ss4
 disabled
Message-ID: <20190402162203.GL49658@atomide.com>
References: <20190402133752.6912-1-rogerq@ti.com>
 <20190402133752.6912-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402133752.6912-2-rogerq@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190402 13:38]:
> These 2 modules are not present on all families (e.g. AM57).
> Keep them disabled.

Can you please add comments to the dtsi file for why "disabled"
is set? Otherwise we may end up removing them at some point as
the default should be just enabled with no status property.

If these devices are really there for some SoCs, we should
have a separate dtsi for them.

Regards,

Tony
