Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6531EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D6E21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 15:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLSPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:35:59 -0500
Received: from 8bytes.org ([81.169.241.247]:58250 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfLSPf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 10:35:58 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 20A6C431; Thu, 19 Dec 2019 16:35:56 +0100 (CET)
Date:   Thu, 19 Dec 2019 16:35:41 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
Message-ID: <20191219153541.GA21694@8bytes.org>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
 <20191218134205.1271740-5-thierry.reding@gmail.com>
 <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
 <20191219124747.GA1440537@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219124747.GA1440537@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 01:47:47PM +0100, Thierry Reding wrote:
> On Thu, Dec 19, 2019 at 09:53:22AM +0800, Lu Baolu wrote:
> > Please tweak the title to
> > 
> > "iommu/vt-d: Use generic_iommu_put_resv_regions()"
> > 
> > then,
> > 
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > Best regards,
> > baolu
> 
> Joerg, do you want me to resend with this change or is it more efficient
> if you fix up the subject while applying?

No need to re-send, I'll fix it up in this patch and in the others too.


	Joerg
