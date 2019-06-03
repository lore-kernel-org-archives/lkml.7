Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE1AC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DF528099
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfFCKSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:18:41 -0400
Received: from 8bytes.org ([81.169.241.247]:41022 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfFCKSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:18:41 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 147B436B; Mon,  3 Jun 2019 12:18:40 +0200 (CEST)
Date:   Mon, 3 Jun 2019 12:18:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <damm+renesas@opensource.se>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        iommu@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iommu/ipmmu-vmsa: Suspend/resume support and
 assorted cleanups
Message-ID: <20190603101836.GI12745@8bytes.org>
References: <20190527115253.2114-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527115253.2114-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 01:52:47PM +0200, Geert Uytterhoeven wrote:
> Geert Uytterhoeven (6):
>   iommu/ipmmu-vmsa: Link IOMMUs and devices in sysfs
>   iommu/ipmmu-vmsa: Prepare to handle 40-bit error addresses
>   iommu/ipmmu-vmsa: Make IPMMU_CTX_MAX unsigned
>   iommu/ipmmu-vmsa: Move num_utlbs to SoC-specific features
>   iommu/ipmmu-vmsa: Extract hardware context initialization
>   iommu/ipmmu-vmsa: Add suspend/resume support

Applied, thanks Geert.
