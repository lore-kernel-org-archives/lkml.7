Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CAAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8292F21670
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394959AbfIFPzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:55:50 -0400
Received: from 8bytes.org ([81.169.241.247]:53430 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394948AbfIFPzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:55:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F0FDE3AA; Fri,  6 Sep 2019 17:55:48 +0200 (CEST)
Date:   Fri, 6 Sep 2019 17:55:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Suman Anna <s-anna@ti.com>, Joerg Roedel <jroedel@suse.de>,
        Tero Kristo <t-kristo@ti.com>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: omap: mark pm functions __maybe_unused
Message-ID: <20190906155548.GA27659@8bytes.org>
References: <20190906151551.1192788-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906151551.1192788-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 05:15:38PM +0200, Arnd Bergmann wrote:
>  drivers/iommu/omap-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks Arnd.
