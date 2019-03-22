Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C80EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BBC2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfCVWVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:21:38 -0400
Received: from muru.com ([72.249.23.125]:42226 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCVWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:21:37 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E3DBF80DB;
        Fri, 22 Mar 2019 22:21:50 +0000 (UTC)
Date:   Fri, 22 Mar 2019 15:21:34 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation
Message-ID: <20190322222134.GI19425@atomide.com>
References: <20190319201952.1309-1-jmkrzyszt@gmail.com>
 <20190320010150.GA7872@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320010150.GA7872@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [190320 01:02]:
> On Tue, Mar 19, 2019 at 09:19:52PM +0100, Janusz Krzysztofik wrote:
> > In order to request dynamic allocationn of GPIO IDs, a negative number
> > should be passed as a base GPIO ID via platform data.  Unfortuntely,
> > commit 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global
> > GPIO numbers") didn't follow that rule while switching to dynamically
> > allocated GPIO IDs for Amstrad Delta latches, making their IDs
> > overlapping with those already assigned to OMAP GPIO devices.  Fix it.
> > 
> > Fixes: 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers")
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v5.1/fixes thanks.

Tony
