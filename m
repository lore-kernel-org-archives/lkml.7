Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA81C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC86D20640
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389202AbfIIQT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:19:27 -0400
Received: from muru.com ([72.249.23.125]:60362 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfIIQT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:19:26 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7338D80BF;
        Mon,  9 Sep 2019 16:19:55 +0000 (UTC)
Date:   Mon, 9 Sep 2019 09:19:21 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     linux-omap@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Remove unpaired sysc_clkdm_deny_idle()
Message-ID: <20190909161921.GN52127@atomide.com>
References: <20190906200154.6510-1-tony@atomide.com>
 <40e5c2a1-3682-584a-4eb9-4d96901bbfda@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40e5c2a1-3682-584a-4eb9-4d96901bbfda@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Keerthy <j-keerthy@ti.com> [190909 01:57]:
> I believe still the previous fix [1] for nfs boot is still not on
> linux-next. Are you planning on more testing or it will be queued as fixes?

I pushed out the pending fixes on Saturday so they should be in
the next version of Linux next.

Regards,

Tony
