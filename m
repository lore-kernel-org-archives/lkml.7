Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E3C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E602620B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbfFRPbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:31:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:48962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729209AbfFRPbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:31:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C8BAAF9F;
        Tue, 18 Jun 2019 15:30:59 +0000 (UTC)
Date:   Tue, 18 Jun 2019 17:30:57 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     dwmw2@infradead.org, eric.auger@redhat.com,
        baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/intel: remove an unused variable "length"
Message-ID: <20190618153057.GP8151@suse.de>
References: <20190617132027.1960-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617132027.1960-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 09:20:27AM -0400, Qian Cai wrote:
> The linux-next commit "iommu/vt-d: Duplicate iommu_resv_region objects
> per device list" [1] left out an unused variable,
> 
> drivers/iommu/intel-iommu.c: In function 'dmar_parse_one_rmrr':
> drivers/iommu/intel-iommu.c:4014:9: warning: variable 'length' set but
> not used [-Wunused-but-set-variable]
> 
> [1] https://lore.kernel.org/patchwork/patch/1083073/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/iommu/intel-iommu.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

