Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7844CC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AF920C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436581AbfHIPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:31:04 -0400
Received: from 8bytes.org ([81.169.241.247]:48554 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:31:03 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E28C43D0; Fri,  9 Aug 2019 17:31:01 +0200 (CEST)
Date:   Fri, 9 Aug 2019 17:31:00 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH] iommu/amd: Re-factor guest virtual APIC (de-)activation
 code
Message-ID: <20190809153100.GB12930@8bytes.org>
References: <1563908430-81636-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563908430-81636-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 07:00:37PM +0000, Suthikulpanit, Suravee wrote:
> Re-factore the logic for activate/deactivate guest virtual APIC mode (GAM)
> into helper functions, and export them for other drivers (e.g. SVM).
> to support run-time activate/deactivate of SVM AVIC.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd_iommu.c       | 85 +++++++++++++++++++++++++++++------------
>  drivers/iommu/amd_iommu_types.h |  9 +++++
>  include/linux/amd-iommu.h       | 12 ++++++
>  3 files changed, 82 insertions(+), 24 deletions(-)

Applied, thanks Suravee.
