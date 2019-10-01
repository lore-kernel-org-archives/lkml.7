Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5ABECDFB6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B17521783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 06:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbfJAGnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 02:43:45 -0400
Received: from verein.lst.de ([213.95.11.211]:42743 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfJAGnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:43:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5558A68B20; Tue,  1 Oct 2019 08:43:40 +0200 (CEST)
Date:   Tue, 1 Oct 2019 08:43:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <cai@lca.pw>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        vladimir.murzin@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma/coherent: remove unused dma_get_device_base()
Message-ID: <20191001064339.GA8582@lst.de>
References: <1568725242-2433-1-git-send-email-cai@lca.pw> <1569444877.5576.232.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569444877.5576.232.camel@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:54:37PM -0400, Qian Cai wrote:
> Ping. Please take a look at this trivial patch.

No need to rush.  We just had the 5.4 merge window closing.  I'll
queue this up in the dma-mapping for-next tree for 5.5 once I open it.
