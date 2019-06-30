Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792CC5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50CA208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfF3U47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 16:56:59 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:36710 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfF3U46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 16:56:58 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8A2E9803B3;
        Sun, 30 Jun 2019 22:56:56 +0200 (CEST)
Date:   Sun, 30 Jun 2019 22:56:55 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        od@zcrc.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] DRM: ingenic: Use devm_platform_ioremap_resource
Message-ID: <20190630205655.GB17046@ravnborg.org>
References: <20190627182114.27299-1-paul@crapouillou.net>
 <20190630081833.GC5081@ravnborg.org>
 <1561892949.1773.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561892949.1773.0@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=w0JLnzDVMa1QFTO2tlAA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

> > > 
> > >  -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  -	base = devm_ioremap_resource(dev, mem);
> > >  +	base = devm_platform_ioremap_resource(pdev, 0);
> > >   	if (IS_ERR(base)) {
> > >   		dev_err(dev, "Failed to get memory resource");
> > Consider to include the error code in the error message here.
> 
> I don't think it's needed; a non-zero error code in the probe function will
> have the drivers core automatically print a message with the name of the
> failing driver and the return code.

You are right, I continue to forget this.
So the above is fine.

	Sam
