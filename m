Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB45C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE36A20818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfEOQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:22:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:34513 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfEOQWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:22:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 09:22:19 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2019 09:22:19 -0700
Date:   Wed, 15 May 2019 09:25:13 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 02/16] iommu: Introduce cache_invalidate API
Message-ID: <20190515092513.3e4a2f77@jacob-builder>
In-Reply-To: <d555d96d-a3ec-53e2-2c49-b783bb2d6806@arm.com>
References: <1556922737-76313-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556922737-76313-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <d32d3d19-11c9-4af9-880b-bb8ebefd4f7f@redhat.com>
        <44d5ba37-a9e9-cc7a-2a3a-d32b840afa29@arm.com>
        <7807afe9-efab-9f48-4ca0-2332a7a54950@redhat.com>
        <1a5a5fad-ed21-5c79-9a9e-ff21fadfb95f@arm.com>
        <1edd45e6-4da3-e393-36b2-9e63cd5f7607@redhat.com>
        <4094baf1-6cf5-a33b-4717-08ced0673c50@arm.com>
        <5d2c0279-7fa9-3d11-9999-583f9ed329ba@redhat.com>
        <20190514105509.7865ebc0@jacob-builder>
        <d555d96d-a3ec-53e2-2c49-b783bb2d6806@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 16:52:46 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 14/05/2019 18:55, Jacob Pan wrote:
> > Yes, I agree to replace the standalone __64 pasid with this struct.
> > Looks more inline with address selective info., Just to double
> > confirm the new struct.
> > 
> > Jean, will you put this in your sva/api repo?  
> 
> Yes, I pushed it along with some documentation fixes (mainly getting
> rid of scripts/kernel-doc warnings and outputting valid rst)
> 
Just pulled, I am rebasing on top of this branch. If you could also
include our api for bind guest pasid, then we have a complete set of
common APIs in one place.
https://lkml.org/lkml/2019/5/3/775

I just need to add a small tweak for supporting non-identity guest-host
PASID mapping for the next version.

> Thanks,
> Jean

[Jacob Pan]
