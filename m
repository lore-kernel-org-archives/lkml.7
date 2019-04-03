Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9018DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5A72133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfDCSwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfDCSwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 787C230715CA;
        Wed,  3 Apr 2019 18:52:23 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14AE06012C;
        Wed,  3 Apr 2019 18:52:23 +0000 (UTC)
Date:   Wed, 3 Apr 2019 12:52:22 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Wang Hai <wanghai26@huawei.com>
Cc:     <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio/spapr_tce: Make symbol 'tce_iommu_driver_ops'
 static
Message-ID: <20190403125222.021d0908@x1.home>
In-Reply-To: <20190320064723.46604-1-wanghai26@huawei.com>
References: <20190320064723.46604-1-wanghai26@huawei.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 03 Apr 2019 18:52:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 02:47:23 -0400
Wang Hai <wanghai26@huawei.com> wrote:

> Fixes the following sparse warning:
> 
> drivers/vfio/vfio_iommu_spapr_tce.c:1401:36: warning:
>  symbol 'tce_iommu_driver_ops' was not declared. Should it be static?
> 
> Fixes: 5ffd229c0273 ("powerpc/vfio: Implement IOMMU driver for VFIO")
> Signed-off-by: Wang Hai <wanghai26@huawei.com>
> ---

Applied to vfio for-linus branch for v5.1 with Alexey's R-b.  Thanks!

Alex

>  drivers/vfio/vfio_iommu_spapr_tce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 8dbb270..6b64e45 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1398,7 +1398,7 @@ static void tce_iommu_detach_group(void *iommu_data,
>  	mutex_unlock(&container->lock);
>  }
>  
> -const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
> +static const struct vfio_iommu_driver_ops tce_iommu_driver_ops = {
>  	.name		= "iommu-vfio-powerpc",
>  	.owner		= THIS_MODULE,
>  	.open		= tce_iommu_open,

