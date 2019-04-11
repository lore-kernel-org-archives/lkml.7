Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF206C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80402184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDKMwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:52:51 -0400
Received: from 8bytes.org ([81.169.241.247]:34080 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfDKMwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:52:51 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8B7F142D; Thu, 11 Apr 2019 14:52:49 +0200 (CEST)
Date:   Thu, 11 Apr 2019 14:52:43 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] IOMMU: Tegra SMMU fixes
Message-ID: <20190411125242.GA4518@8bytes.org>
References: <20190306225009.3391-1-digetx@gmail.com>
 <99d4f594-f9a0-1cf6-8031-a3faa8e091e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99d4f594-f9a0-1cf6-8031-a3faa8e091e3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:14:18AM +0300, Dmitry Osipenko wrote:

> Joerg, could you please apply this series?

Applied, thanks.
