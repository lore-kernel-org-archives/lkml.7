Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90286C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA702183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbfB1KEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:04:44 -0500
Received: from 8bytes.org ([81.169.241.247]:55840 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfB1KEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:04:44 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 85BEE4A3; Thu, 28 Feb 2019 11:04:42 +0100 (CET)
Date:   Thu, 28 Feb 2019 11:04:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
Subject: Re: linux-next: manual merge of the vhost tree with the iommu tree
Message-ID: <20190228100442.GB1594@8bytes.org>
References: <20190227152506.4696a59f@canb.auug.org.au>
 <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
 <20190227085546-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227085546-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:58:36AM -0500, Michael S. Tsirkin wrote:
> Even though it's not going into 5.1 I feel it's helpful to keep it in
> the vhost tree until the next cycle, it helps make sure unrelated
> changes don't break it.

It is not going to 5.1, so it shouldn't be in linux-next, no? And when
it is going upstream, it should do so through the iommu tree. If you
keep it separatly in the vhost tree for testing purposes, please make
sure it is not included into your linux-next branch.

Regards,

	Joerg
