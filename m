Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869F220659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 09:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfJOJvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 05:51:17 -0400
Received: from 8bytes.org ([81.169.241.247]:47358 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfJOJvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 05:51:17 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 622FF398; Tue, 15 Oct 2019 11:51:15 +0200 (CEST)
Date:   Tue, 15 Oct 2019 11:51:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agross@kernel.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/qcom: Simplify a test in 'qcom_iommu_add_device()'
Message-ID: <20191015095113.GA14518@8bytes.org>
References: <20190916202936.30403-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916202936.30403-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:29:36PM +0200, Christophe JAILLET wrote:
> 'iommu_group_get_for_dev()' never returns NULL, so this test can be
> simplified a bit.
> 
> This way, the test is consistent with all other calls to
> 'iommu_group_get_for_dev()'.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/iommu/qcom_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
