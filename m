Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE283C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA04120B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfEMHGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:06:04 -0400
Received: from verein.lst.de ([213.95.11.211]:37359 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfEMHGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:06:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id A4EE268AFE; Mon, 13 May 2019 09:05:42 +0200 (CEST)
Date:   Mon, 13 May 2019 09:05:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com,
        mika.westerberg@linux.intel.com, pengfei.xu@intel.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] swiotlb: Factor out slot allocation and free
Message-ID: <20190513070542.GA18739@lst.de>
References: <0c6e5983-312b-0d6b-92f5-64861cd6804d@linux.intel.com> <20190423061232.GB12762@lst.de> <dff50b2c-5e31-8b4a-7fdf-99d17852746b@linux.intel.com> <20190424144532.GA21480@lst.de> <a189444b-15c9-8069-901d-8cdf9af7fc3c@linux.intel.com> <20190426150433.GA19930@lst.de> <93b3d627-782d-cae0-2175-77a5a8b3fe6e@linux.intel.com> <90182d27-5764-7676-8ca6-b2773a40cfe1@arm.com> <20190429114401.GA30333@lst.de> <7033f384-7823-42ec-6bda-ae74ef689f4f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7033f384-7823-42ec-6bda-ae74ef689f4f@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 09:54:30AM +0800, Lu Baolu wrote:
> Agreed. I will prepare the next version simply without the optimization, so 
> the offset is not required.
>
> For your changes in swiotlb, will you formalize them in patches or want
> me to do this?

Please do it yourself given that you still need the offset and thus a
rework of the patches anyway.
