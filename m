Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80996C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572EC218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDLQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:57:37 -0400
Received: from muru.com ([72.249.23.125]:45674 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfDLQ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:57:37 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E372580F3;
        Fri, 12 Apr 2019 16:57:51 +0000 (UTC)
Date:   Fri, 12 Apr 2019 09:57:33 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     robh+dt@kernel.org, s-anna@ti.com, nm@ti.com, lokeshvutla@ti.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ARM: dts: dra7: Separate AM57 dtsi files
Message-ID: <20190412165733.GA2839@atomide.com>
References: <20190405132806.20772-1-rogerq@ti.com>
 <20190408094249.29894-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408094249.29894-1-rogerq@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190408 09:43]:
> AM5 and DRA7 SoC families have different set of modules
> in them so the SoC sepecific dtsi files need to be separated.
> 
> e.g. Some of the major differences between AM576 and DRA76
> 
> 		DRA76x	AM576x
> 
> USB3		x
> USB4		x
> ATL		x
> VCP		x
> MLB		x
> ISS		x
> PRU-ICSS1		x
> PRU-ICSS2		x
> 
> This patch only deals with disabling USB3, USB4 and ATL for
> AM57 variants.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> 
> Changelog:
> 
> v2:
> - fix am57xx-beagle-x15-common.dtsi

Thanks applying this into omap-for-v5.2/dt.

Regards,

Tony
