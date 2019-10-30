Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F14CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1B92087E
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfJ3Jgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:36:52 -0400
Received: from 8bytes.org ([81.169.241.247]:49998 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfJ3Jgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:36:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A6DBB34A; Wed, 30 Oct 2019 10:36:50 +0100 (CET)
Date:   Wed, 30 Oct 2019 10:36:49 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Kit Chow <kchow@gigaio.com>
Subject: Re: [PATCH v2 0/2]  AMD IOMMU Changes for NTB
Message-ID: <20191030093649.GB7254@8bytes.org>
References: <20191022220121.1120-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022220121.1120-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 04:01:19PM -0600, Logan Gunthorpe wrote:
> Logan Gunthorpe (2):
>   iommu/amd: Support multiple PCI DMA aliases in device table
>   iommu/amd: Support multiple PCI DMA aliases in IRQ Remapping
> 
>  drivers/iommu/amd_iommu.c       | 170 +++++++++++++++++---------------
>  drivers/iommu/amd_iommu_types.h |   2 +-
>  2 files changed, 92 insertions(+), 80 deletions(-)

Applied, thanks.
