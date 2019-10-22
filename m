Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476FFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A43020B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbfJVQqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:46:40 -0400
Received: from muru.com ([72.249.23.125]:39144 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389018AbfJVQqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:46:39 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C27FC80FA;
        Tue, 22 Oct 2019 16:47:13 +0000 (UTC)
Date:   Tue, 22 Oct 2019 09:46:36 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        linux-omap@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/3] ARM: dts: dra7: add vpe nodes
Message-ID: <20191022164636.GD5610@atomide.com>
References: <20191009175628.20570-1-bparrot@ti.com>
 <20191022162720.yile7i4qwxgbuuou@ti.com>
 <20191022163048.GY5610@atomide.com>
 <20191022163319.ceb5wkwabw3w3kou@ti.com>
 <20191022163754.GC5610@atomide.com>
 <20191022164429.4hcyrnmtvklfd4oq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022164429.4hcyrnmtvklfd4oq@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191022 16:45]:
> Tony Lindgren <tony@atomide.com> wrote on Tue [2019-Oct-22 09:37:54 -0700]:
> > * Benoit Parrot <bparrot@ti.com> [191022 16:34]:
> > > Tony Lindgren <tony@atomide.com> wrote on Tue [2019-Oct-22 09:30:48 -0700]:
> > > > * Benoit Parrot <bparrot@ti.com> [191022 16:28]:
> > > > > Tony,
> > > > > 
> > > > > Ping,
> > > > > 
> > > > > I already had comments from Rob but i would like your feedback before
> > > > > sending a v2.
> > > > 
> > > > Looks good to me in general other than what Rob commented
> > > > on. Did not spot any node naming issues here :)
> > > 
> > > Would I need to split off the clk*.c/.h as well here though?
> > 
> > Yeah please do patches with just drivers/clk/ti and
> > include/dt-bindings/clock changes in them. then Tero
> > can queue them into an immutable branch that I can merge
> > in too and use as a base for the dts changes.
> 
> Although the .h is in include/dt-binding. Does it still belong in the same
> patch as drivers/clk/ti/clk-7xx.c then?
> 
> Just making sure....

Yes if it's needed to compile the drivers/clk/ti patch.
Otherwise it can stay with the dts changes.

Regards,

Tony
