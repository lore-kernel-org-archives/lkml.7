Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BD7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F80C2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfCVJiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:38:15 -0400
Received: from 8bytes.org ([81.169.241.247]:58570 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbfCVJiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:38:15 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 397412D8; Fri, 22 Mar 2019 10:38:13 +0100 (CET)
Date:   Fri, 22 Mar 2019 10:38:11 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        mark gross <mgross@intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Check capability before disabling
 protected memory
Message-ID: <20190322093811.GB18669@8bytes.org>
References: <20190320015834.22653-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320015834.22653-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 09:58:33AM +0800, Lu Baolu wrote:
> The spec states in 10.4.16 that the Protected Memory Enable
> Register should be treated as read-only for implementations
> not supporting protected memory regions (PLMR and PHMR fields
> reported as Clear in the Capability register).
> 
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: mark gross <mgross@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Fixes: f8bab73515ca5 ("intel-iommu: PMEN support")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied both, thanks.
