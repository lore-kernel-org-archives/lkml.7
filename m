Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19136C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95CE206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 18:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfLXSpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 13:45:08 -0500
Received: from muru.com ([72.249.23.125]:49400 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfLXSpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 13:45:07 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 751A88107;
        Tue, 24 Dec 2019 18:45:46 +0000 (UTC)
Date:   Tue, 24 Dec 2019 10:45:03 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?QW5kcsOp?= Hentschel <nerv@dawncrow.de>
Cc:     webmaster@dawncrow.de, linux@arm.linux.org.uk, robh+dt@kernel.org,
        mark.rutland@arm.com, bcousson@baylibre.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: Add omap3-echo
Message-ID: <20191224184503.GK35479@atomide.com>
References: <20191224161005.28083-1-nerv@dawncrow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191224161005.28083-1-nerv@dawncrow.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* André Hentschel <nerv@dawncrow.de> [191224 16:11]:
> This is the first generation Amazon Echo from 2016.
> Audio support is not yet implemented.

OK looks good to me, just worried about one part:

> +&sgx_module {
> +	status = "disabled";
> +};

We should have a separate am3703.dtsi or whatever the SoC model
disabling sgx if not there on the SoC. That way board specific
dts files can just include it without having to debug this issue
over and over.

Regards,

Tony
