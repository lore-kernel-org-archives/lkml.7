Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1341C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDA620873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDKIXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:23:45 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:43416 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfDKIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:23:45 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B012625AD6D;
        Thu, 11 Apr 2019 18:23:42 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id BB40A940356; Thu, 11 Apr 2019 10:23:40 +0200 (CEST)
Date:   Thu, 11 Apr 2019 10:23:40 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iommu/ipmmu-vmsa: Prepare to handle 40-bit error
 addresses
Message-ID: <20190411082340.rtqnhizeb4njafmk@verge.net.au>
References: <20190403182148.18058-1-geert+renesas@glider.be>
 <20190403182148.18058-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403182148.18058-3-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:21:44PM +0200, Geert Uytterhoeven wrote:
> On R-Car Gen3, the faulting virtual address is a 40-bit address, and
> comprised of two registers.  Read the upper address part, and combine
> both parts, when running on a 64-bit system.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Apart from this, the driver doesn't support 40-bit IOVA addresses yet.

None the less this seems like progress.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
