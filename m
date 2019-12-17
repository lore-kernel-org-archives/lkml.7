Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D799AC2D0C5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B611B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 09:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfLQJea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:34:30 -0500
Received: from 8bytes.org ([81.169.241.247]:57620 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQJea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 04:34:30 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C683B286; Tue, 17 Dec 2019 10:34:28 +0100 (CET)
Date:   Tue, 17 Dec 2019 10:34:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 0/2] iommu/amd: Fixes for x2APIC support
Message-ID: <20191217093427.GD8689@8bytes.org>
References: <1574258149-15602-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574258149-15602-1-git-send-email-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 07:55:47AM -0600, Suravee Suthikulpanit wrote:
> Adding feature support check for MMIO access to MSI capability
> block registers when enabling x2APIC (XT) mode. Also fix up logic
> for checking XT feature support for IVHD type 10h.
> 
> Suravee Suthikulpanit (2):
>   iommu/amd: Check feature support bit before accessing MSI capability
>     registers
>   iommu/amd: Only support x2APIC with IVHD type 11h/40h

Applied both, thanks Suravee.

