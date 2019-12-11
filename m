Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862CCC2D0C5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A762173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576056067;
	bh=gzDA3JJnu708N4xoucs8RAE4lUx+pZwj+RYMbSyB3LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FYvkAayAXI5/46+Q98Wwwee/DzdMWmPf3BRxOMLs+k09dY4Z/pdLCjXpZCePe94eG
	 rQHjdWsv/vo9mPoVrsEDSuMxUDhPvEtte6vD/Ao2EiK4N1RLI789RwfWQEw2IplP++
	 Wq/ZuhrDlk0DU/A1ZwI4CuMHO5Cj46zAHsa7Vo/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfLKJVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfLKJVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:21:05 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A737214AF;
        Wed, 11 Dec 2019 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576056064;
        bh=gzDA3JJnu708N4xoucs8RAE4lUx+pZwj+RYMbSyB3LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JnhSW1JjOn7hiWYurytdcwcMptqWolC9yyigMO0/FpxLCa5iiqrgR63k5Q2YHyQWG
         GcHfSJXjhE2NURShz8DRmpToqMSOurOrLthtFKiaBuJV1mzu0bqb7I4NPZHiyIa6wP
         i1gxUGE2PFeSIsKe4xTvrGaqsYRuTNSKJ8303yEU=
Date:   Wed, 11 Dec 2019 17:20:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: put SAIs into async mode
Message-ID: <20191211092052.GX15858@dragon>
References: <20191129210937.26808-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129210937.26808-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 10:09:37PM +0100, Michael Walle wrote:
> The LS1028A SoC has only unidirectional SAIs. Therefore, it doesn't make
> sense to have the RX and TX part synchronous. Even worse, the RX part
> wont work out of the box because by default it is configured as
> synchronous to the TX part. And as said before, the pinmux of the SoC
> can only be configured to route either the RX or the TX signals to the
> SAI but never both at the same time. Thus configure the asynchronous
> mode by default.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks.
