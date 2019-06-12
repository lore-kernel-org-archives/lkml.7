Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D50CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8D32086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406059AbfFLIh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:37:28 -0400
Received: from 8bytes.org ([81.169.241.247]:43552 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfFLIh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:37:28 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2237A642; Wed, 12 Jun 2019 10:37:27 +0200 (CEST)
Date:   Wed, 12 Jun 2019 10:37:25 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, cai@lca.pw,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fixes and cleanups for linux-next
Message-ID: <20190612083725.GE17505@8bytes.org>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612002851.17103-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 08:28:44AM +0800, Lu Baolu wrote:
> Lu Baolu (6):
>   iommu/vt-d: Don't return error when device gets right domain
>   iommu/vt-d: Set domain type for a private domain
>   iommu/vt-d: Don't enable iommu's which have been ignored
>   iommu/vt-d: Allow DMA domain attaching to rmrr locked device
>   iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
>   iommu/vt-d: Consolidate domain_init() to avoid duplication

Applied, thanks.
