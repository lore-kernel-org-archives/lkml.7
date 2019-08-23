Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D476BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF9122CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392728AbfHWI2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:28:04 -0400
Received: from 8bytes.org ([81.169.241.247]:51038 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390104AbfHWI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:28:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 196BE20E; Fri, 23 Aug 2019 10:28:03 +0200 (CEST)
Date:   Fri, 23 Aug 2019 10:27:57 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge
 systems
Message-ID: <20190823082757.GA24194@8bytes.org>
References: <20190817063502.27311-1-kai.hen.fen@canonical.com>
 <20190821051004.2367-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821051004.2367-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:10:04PM +0800, Kai-Heng Feng wrote:
>  drivers/iommu/Makefile           |  2 +-
>  drivers/iommu/amd_iommu.h        | 14 +++++
>  drivers/iommu/amd_iommu_init.c   |  5 +-
>  drivers/iommu/amd_iommu_quirks.c | 92 ++++++++++++++++++++++++++++++++
>  4 files changed, 111 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu.h
>  create mode 100644 drivers/iommu/amd_iommu_quirks.c

Applied, thanks.
