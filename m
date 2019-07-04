Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB5C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ABA218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfGDIMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:12:51 -0400
Received: from 8bytes.org ([81.169.241.247]:34054 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfGDIMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:12:50 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6164B2FB; Thu,  4 Jul 2019 10:12:49 +0200 (CEST)
Date:   Thu, 4 Jul 2019 10:12:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 06/10] iommu: using dev_get_drvdata directly
Message-ID: <20190704081247.GC6546@8bytes.org>
References: <20190704023620.4689-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704023620.4689-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:36:20AM +0800, Fuqian Huang wrote:
>  #define to_iommu(dev)							\
> -	((struct omap_iommu *)platform_get_drvdata(to_platform_device(dev)))
> +	((struct omap_iommu *)dev_get_drvdata(dev))

A similar change is already queued for v5.3.
