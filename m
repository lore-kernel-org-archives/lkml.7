Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0AECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16CD20854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391261AbfJPHnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:43:45 -0400
Received: from 8bytes.org ([81.169.241.247]:47712 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728420AbfJPHnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:43:45 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EFEB345B; Wed, 16 Oct 2019 09:43:43 +0200 (CEST)
Date:   Wed, 16 Oct 2019 09:43:39 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] iommu: rockchip: Free domain on .domain_free
Message-ID: <20191016074339.GA32232@8bytes.org>
References: <20191002172923.22430-1-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002172923.22430-1-ezequiel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 02:29:23PM -0300, Ezequiel Garcia wrote:
> IOMMU domain resource life is well-defined, managed
> by .domain_alloc and .domain_free.
> 
> Therefore, domain-specific resources shouldn't be tied to
> the device life, but instead to its domain.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.
