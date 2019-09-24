Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E157C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B552146E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 09:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504320AbfIXJlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:41:08 -0400
Received: from 8bytes.org ([81.169.241.247]:55638 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504288AbfIXJlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:41:08 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EE14C3A2; Tue, 24 Sep 2019 11:41:06 +0200 (CEST)
Date:   Tue, 24 Sep 2019 11:41:05 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu/amd: Wait for completion of IOTLB flush in
 attach_device
Message-ID: <20190924094105.GB11453@8bytes.org>
References: <1568137765-20278-1-git-send-email-sironi@amazon.de>
 <1568137765-20278-2-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568137765-20278-2-git-send-email-sironi@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 07:49:21PM +0200, Filippo Sironi wrote:
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> ---
>  drivers/iommu/amd_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied this one with a commit message and a fixes tag, thanks.

