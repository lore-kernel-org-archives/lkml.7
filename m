Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2CEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F792080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436767AbfFLIE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:04:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbfFLIE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:04:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DDA5ABE9;
        Wed, 12 Jun 2019 08:04:28 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:04:26 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     tmurphy@arista.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] iommu/amd: fix a null-ptr-deref in map_sg()
Message-ID: <20190612080426.GL8151@suse.de>
References: <20190506164440.37399-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506164440.37399-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 12:44:40PM -0400, Qian Cai wrote:
> The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
> iommu_map_page") 

That patch was reverted by me in

	97a18f548548a6ee1b9be14c6fc72090b8839875

because it caused issues by testers. So maybe re-submit the above patch
with this fix included?

Regards,

	Joerg

