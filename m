Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D59C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3098220679
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKLP3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:29:53 -0500
Received: from muru.com ([72.249.23.125]:41820 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbfKLP3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:29:52 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D223080F3;
        Tue, 12 Nov 2019 15:30:28 +0000 (UTC)
Date:   Tue, 12 Nov 2019 07:29:49 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 02/10] ARM: dts: dra7: add cam clkctrl node
Message-ID: <20191112152949.GF5610@atomide.com>
References: <20191112142753.22976-1-bparrot@ti.com>
 <20191112142753.22976-3-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112142753.22976-3-bparrot@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191112 14:25]:
> Add clkctrl nodes for CAM domain.
> 
> Note that because of the current dts node name dependency for mapping to
> clock domain, we must still use "cam-clkctrl@" naming instead of generic
> "clock@" naming for the node. And because of this, it's probably best to
> apply the dts node addition together along with the other clock changes.

Thanks for updating this too.

Tero, for merging, you could create a separate clock dts changes branch
too on your clock changes if needed, up to you. Anyways best that you
queue all the clock changes and clock related dts changes:

Acked-by: Tony Lindgren <tony@atomide.com>
