Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0BAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749DE2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDZOta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:49:30 -0400
Received: from 8bytes.org ([81.169.241.247]:37876 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDZOta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:49:30 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C7C23D91; Fri, 26 Apr 2019 16:49:28 +0200 (CEST)
Date:   Fri, 26 Apr 2019 16:49:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH next 13/25] iommu/omap: Use dev_get_drvdata()
Message-ID: <20190426144927.GJ24576@8bytes.org>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
 <20190423075020.173734-14-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423075020.173734-14-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 03:50:08PM +0800, Kefeng Wang wrote:
>  drivers/iommu/omap-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.
