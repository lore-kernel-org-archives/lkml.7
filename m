Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB617C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B4023405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3Nu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:50:27 -0400
Received: from 8bytes.org ([81.169.241.247]:52468 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbfH3NuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:50:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id ECF9520E; Fri, 30 Aug 2019 15:50:23 +0200 (CEST)
Date:   Fri, 30 Aug 2019 15:50:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        shameerali.kolothum.thodi@huawei.com, alex.williamson@redhat.com,
        robin.murphy@arm.com, hch@infradead.org
Subject: Re: [PATCH v3] iommu: revisit iommu_insert_resv_region()
 implementation
Message-ID: <20190830135022.GB11578@8bytes.org>
References: <20190821120940.22337-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821120940.22337-1-eric.auger@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 02:09:40PM +0200, Eric Auger wrote:
>  drivers/iommu/iommu.c | 96 +++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 49 deletions(-)

Applied, thanks.
