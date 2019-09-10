Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1000C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 08:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405075AbfIJIRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 04:17:20 -0400
Received: from 8bytes.org ([81.169.241.247]:53740 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbfIJIRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 04:17:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8BBE34D9; Tue, 10 Sep 2019 10:17:18 +0200 (CEST)
Date:   Tue, 10 Sep 2019 10:17:16 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Adam Zerella <adam.zerella@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix sparse warnings
Message-ID: <20190910081716.GD3247@8bytes.org>
References: <20190907065812.19505-1-adam.zerella@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907065812.19505-1-adam.zerella@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 04:58:12PM +1000, Adam Zerella wrote:
>  drivers/iommu/amd_iommu.c      |  4 ++--
>  drivers/iommu/amd_iommu_init.c | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.
