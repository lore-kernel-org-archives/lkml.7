Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F4C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 20:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfD3UVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 16:21:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:56933 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfD3UVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 16:21:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 13:21:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="228167388"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 30 Apr 2019 13:21:19 -0700
Date:   Tue, 30 Apr 2019 13:24:05 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Auger Eric <eric.auger@redhat.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 06/19] drivers core: Add I/O ASID allocator
Message-ID: <20190430132405.62902350@jacob-builder>
In-Reply-To: <fd5b8c6c-05f0-307b-aaa2-0938337014a8@arm.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-7-git-send-email-jacob.jun.pan@linux.intel.com>
        <4550408f-39ff-7bf9-0072-a0898c6c2f60@redhat.com>
        <fd5b8c6c-05f0-307b-aaa2-0938337014a8@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 11:41:05 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 25/04/2019 11:17, Auger Eric wrote:
> >> +/**
> >> + * ioasid_alloc - Allocate an IOASID
> >> + * @set: the IOASID set
> >> + * @min: the minimum ID (inclusive)
> >> + * @max: the maximum ID (exclusive)
> >> + * @private: data private to the caller
> >> + *
> >> + * Allocate an ID between @min and @max (or %0 and %INT_MAX).
> >> Return the  
> > I would remove "(or %0 and %INT_MAX)".  
> 
> Agreed, those where the default values of idr, but the xarray doesn't
> define a default max value. By the way, I do think squashing patches 6
> and 7 would be better (keeping my SOB but you can change the author).
> 
I will squash 6 and 7 in v3. I will just add my SOB but keep the
author if that is OK.
