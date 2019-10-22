Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD54CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E31A21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BbyZ+sZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbfJVQNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:13:37 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58520 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389312AbfJVQNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:13:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9MGDTIF052496;
        Tue, 22 Oct 2019 11:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571760809;
        bh=QGk7qbe/nYACD/rro5HVU0hxjmC2+PiIZcphPyYqDg4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BbyZ+sZSr3GX6SkfLtTPvcIegE8IWRidE7M9CyzLnq/VjEjC/TU+aRjcyOQJHytN9
         csyjsi10Ulk28g61RvhvXfgwaW+lJEKTUNQZkA4yk6fVP2e2e1Fhhea+YavWWmzHe6
         LqI6XK2TeYMgYp1CLe1Z82oO49YahMfMDr4IY1sc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9MGDTBd043929
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Oct 2019 11:13:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 22
 Oct 2019 11:13:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 22 Oct 2019 11:13:19 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with SMTP id x9MGDDPn111989;
        Tue, 22 Oct 2019 11:13:13 -0500
Date:   Tue, 22 Oct 2019 11:13:13 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/9] ARM: dts: dra7: add cam clkctrl node
Message-ID: <20191022161313.nzwovtxipibpvwpf@ti.com>
References: <20191018154849.3127-1-bparrot@ti.com>
 <20191018154849.3127-2-bparrot@ti.com>
 <20191022154012.GM5610@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191022154012.GM5610@atomide.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote on Tue [2019-Oct-22 08:40:12 -0700]:
> * Benoit Parrot <bparrot@ti.com> [191018 15:46]:
> > Add clkctrl nodes for CAM domain.
> 
> You're missing the Linux clk folks and list from Cc, can
> you please resend?

Sure.

> 
> I need an ack for the clk-7xx.c changes if I'm to apply
> this patch.
> 
> Probably the best way would be for tero to collect
> all the drivers/clk/ti clock data changes and provide
> an immutable branch with those that I can merge too.

So I assume then that the clk*.c and header file changes should be split in
a separate patch?

Tero,
Let me know how youo would like to proceed.

Benoit

> 
> That way the related dts changes can be applied on
> top of it with things working.
> 
> Regards,
> 
> Tony
