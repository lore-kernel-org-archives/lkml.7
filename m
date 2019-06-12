Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F6C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F50520874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436937AbfFLITr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:19:47 -0400
Received: from 8bytes.org ([81.169.241.247]:43524 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404384AbfFLITr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:19:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7F6AB642; Wed, 12 Jun 2019 10:19:45 +0200 (CEST)
Date:   Wed, 12 Jun 2019 10:19:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
        eric.auger@redhat.com, ashok.raj@intel.com, yi.l.liu@intel.com,
        robdclark@gmail.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/4] iommu: Add device fault reporting API
Message-ID: <20190612081944.GB17505@8bytes.org>
References: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603145749.46347-1-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 03:57:45PM +0100, Jean-Philippe Brucker wrote:
> Jacob Pan (3):
>   driver core: Add per device iommu param
>   iommu: Introduce device fault data
>   iommu: Introduce device fault report API
> 
> Jean-Philippe Brucker (1):
>   iommu: Add recoverable fault reporting
> 
>  drivers/iommu/iommu.c      | 236 ++++++++++++++++++++++++++++++++++++-
>  include/linux/device.h     |   3 +
>  include/linux/iommu.h      |  87 ++++++++++++++
>  include/uapi/linux/iommu.h | 153 ++++++++++++++++++++++++
>  4 files changed, 476 insertions(+), 3 deletions(-)
>  create mode 100644 include/uapi/linux/iommu.h

Applied, thanks.
