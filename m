Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7640F2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCRJx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:53:28 -0400
Received: from 8bytes.org ([81.169.241.247]:58188 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfCRJxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:53:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 56DCE327; Mon, 18 Mar 2019 10:53:23 +0100 (CET)
Date:   Mon, 18 Mar 2019 10:53:21 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com,
        linux-arm-msm@vger.kernel.org, dianders@chromimum.org,
        hoegsberg@google.com, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Message-ID: <20190318095321.GA5417@8bytes.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
 <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 12:38:26PM -0700, Jordan Crouse wrote:
> Add an attribute to return the base address of the pagetable. This is used
> by auxiliary domains from arm-smmu to return the address of the pagetable
> to the leaf driver so that it can set the appropriate pagetable through
> it's own means.

What is this going to be used for? Page-table management is supposed to
happen in the arm-smmu driver and the gpu driver only makes changes
through iommu_map/iommu_unmap calls.


Regards,

	Joerg
