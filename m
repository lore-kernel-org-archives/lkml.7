Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667EE206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfDZPCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:02:45 -0400
Received: from 8bytes.org ([81.169.241.247]:37896 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfDZPCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:02:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E1FA7D91; Fri, 26 Apr 2019 17:02:43 +0200 (CEST)
Date:   Fri, 26 Apr 2019 17:02:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Murphy <tmurphy@arista.com>
Cc:     iommu@lists.linux-foundation.org, murphyt7@tcd.ie,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove old no iommu direct mapping code
Message-ID: <20190426150242.GL24576@8bytes.org>
References: <20190423200335.3888-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423200335.3888-1-tmurphy@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 09:03:34PM +0100, Tom Murphy wrote:
> These checks were intended to handle devices not mapped by the IOMMU.
> Since the AMD IOMMU driver uses per-device dma_ops these functions can
> no longer be called by direct mapped devices. So these checks aren't
> needed anymore.
> 
> Signed-off-by: Tom Murphy <tmurphy@arista.com>
> ---
>  drivers/iommu/amd_iommu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

This has already been done by Christoph, see

	https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?id=7a5dbf3ab2f04905cf8468c66fcdbfb643068bcb

Regards,

	Joerg
