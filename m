Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCCAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E192083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfDKIfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:35:23 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:44550 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKIfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:35:23 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id EECE525AD6D;
        Thu, 11 Apr 2019 18:35:20 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 0C287940356; Thu, 11 Apr 2019 10:35:19 +0200 (CEST)
Date:   Thu, 11 Apr 2019 10:35:18 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific
 features
Message-ID: <20190411083518.enlytqnwukzgwslz@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-5-geert+renesas@glider.be>
 <20190411083240.jxv3xoasrg3vx5zh@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411083240.jxv3xoasrg3vx5zh@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:32:40AM +0200, Simon Horman wrote:
> On Wed, Apr 03, 2019 at 08:21:46PM +0200, Geert Uytterhoeven wrote:
> > The maximum number of micro-TLBs per IPMMU instance is not fixed, but
> > depends on the SoC type.  Hence move it from struct ipmmu_vmsa_device to
> > struct ipmmu_features, and set up the correct value for both R-Car Gen2
> > and Gen3 SoCs.
> > 
> > Note that currently no code uses this value.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Are there any plans to use num_utlbs in the driver or anywhere else in the
> kernel? If not, perhaps it should be removed?

I see that I spoke too soon and it is used by a patch later on in this
series.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
