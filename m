Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D54CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EA5222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410354AbfJRPWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:22:55 -0400
Received: from verein.lst.de ([213.95.11.211]:48205 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388554AbfJRPWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:22:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 26CFB68AFE; Fri, 18 Oct 2019 17:22:52 +0200 (CEST)
Date:   Fri, 18 Oct 2019 17:22:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Return the correct dma mask when we are
 bypassing the IOMMU
Message-ID: <20191018152251.GB32150@lst.de>
References: <20191008143357.GA599223@rani.riverdale.lan> <85123533-2e9c-af73-3014-782dd6f925cb@linux.intel.com> <20191016191551.GA2692557@rani> <20191017070847.GA15037@lst.de> <20191018095036.GB4670@8bytes.org> <20191018151453.GA32023@lst.de> <20191018152149.GA29059@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018152149.GA29059@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 05:21:49PM +0200, Joerg Roedel wrote:
> > > Fine with me.
> > > 
> > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > 
> > That means you want me to queue it up?
> 
> Yes, feel free to take it into your tree.

Done.
