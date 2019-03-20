Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE4AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BD22175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCTBBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:01:53 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:33536 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfCTBBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:01:53 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-21-58-nat.elisa-mobile.fi [85.76.21.58])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id B350430053;
        Wed, 20 Mar 2019 03:01:50 +0200 (EET)
Date:   Wed, 20 Mar 2019 03:01:50 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation
Message-ID: <20190320010150.GA7872@darkstar.musicnaut.iki.fi>
References: <20190319201952.1309-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319201952.1309-1-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:19:52PM +0100, Janusz Krzysztofik wrote:
> In order to request dynamic allocationn of GPIO IDs, a negative number
> should be passed as a base GPIO ID via platform data.  Unfortuntely,
> commit 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global
> GPIO numbers") didn't follow that rule while switching to dynamically
> allocated GPIO IDs for Amstrad Delta latches, making their IDs
> overlapping with those already assigned to OMAP GPIO devices.  Fix it.
> 
> Fixes: 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers")
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: stable@vger.kernel.org

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
