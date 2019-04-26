Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF2C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0635206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfDZONq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:13:46 -0400
Received: from 8bytes.org ([81.169.241.247]:37830 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfDZONn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:13:43 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A204BD91; Fri, 26 Apr 2019 16:13:41 +0200 (CEST)
Date:   Fri, 26 Apr 2019 16:13:41 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     freedreno@lists.freedesktop.org, jean-philippe.brucker@arm.com,
        linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        hoegsberg@google.com, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 04/15] iommu: Add DOMAIN_ATTR_PTBASE
Message-ID: <20190426141341.GB6731@8bytes.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
 <1551469117-3404-5-git-send-email-jcrouse@codeaurora.org>
 <20190318095321.GA5417@8bytes.org>
 <20190318141912.GA10168@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318141912.GA10168@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

On Mon, Mar 18, 2019 at 08:19:12AM -0600, Jordan Crouse wrote:
> Adreno GPUs can an internal mechanism to switch the pagetable address in the
> attached arm-smmu v2 IOMMU so that each individual rendering process can have
> their own pagetable. The driver uses iommu_map and iommu_unmap to write
> the pagetable but the address for each individual pagetable needs to be queried
> so it can be sent to the hardware. You can see the driver specific code that
> does this here:

Okay, thanks for the explanation. I still don't like it, but it is
probably better putting gpu-specfic context-switch logic into the iommu
driver, so I guess this is okay.


Regards,

	Joerg
