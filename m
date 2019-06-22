Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C77C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6322070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 19:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfFVTrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 15:47:19 -0400
Received: from 8bytes.org ([81.169.241.247]:60822 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVTrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:47:18 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CF92E447; Sat, 22 Jun 2019 21:47:17 +0200 (CEST)
Date:   Sat, 22 Jun 2019 21:47:16 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>, dave.jiang@intel.com
Subject: Re: [PATCH] Revert "iommu/vt-d: Fix lock inversion between
 iommu->lock and device_domain_lock"
Message-ID: <20190622194716.GA30910@8bytes.org>
References: <20190621023205.12936-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621023205.12936-1-peterx@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 10:32:05AM +0800, Peter Xu wrote:
> This reverts commit 7560cc3ca7d9d11555f80c830544e463fcdb28b8.

Applied and on its way upstream, thanks.


	Joerg
