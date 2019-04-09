Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C07C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEBA20850
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDIRLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:11:06 -0400
Received: from verein.lst.de ([213.95.11.211]:51747 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbfDIRLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:11:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 515BE68B02; Tue,  9 Apr 2019 19:10:52 +0200 (CEST)
Date:   Tue, 9 Apr 2019 19:10:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/21] dma-iommu: cleanup dma-iommu.h
Message-ID: <20190409171052.GB14679@lst.de>
References: <20190327080448.5500-1-hch@lst.de> <20190327080448.5500-5-hch@lst.de> <7d7efc03-75b2-58c7-f744-d7bc3de6a771@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d7efc03-75b2-58c7-f744-d7bc3de6a771@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 06:42:57PM +0100, Robin Murphy wrote:
> Other than introducing this unnecessary dupe,

Fixed.
