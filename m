Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92020206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfC1KcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfC1KcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:32:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2983F3001C8A;
        Thu, 28 Mar 2019 10:32:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-18.ams2.redhat.com [10.36.116.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE5AD6E3E5;
        Thu, 28 Mar 2019 10:32:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D33E01750F; Thu, 28 Mar 2019 11:32:09 +0100 (CET)
Date:   Thu, 28 Mar 2019 11:32:09 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 -next] drm/virtio: remove set but not used variable
 'vgdev'
Message-ID: <20190328103209.wmdakmzmiwaxf7cx@sirius.home.kraxel.org>
References: <20190320020308.12745-1-yuehaibing@huawei.com>
 <20190325092631.152060-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325092631.152060-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 28 Mar 2019 10:32:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 09:26:31AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_init_mem_type':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:117:28: warning:
>  variable 'vgdev' set but not used [-Wunused-but-set-variable]
> 
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_bo_swap_notify':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:300:28: warning:
>  variable 'vgdev' set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in dc5698e80cf7 ("Add virtio gpu driver.")

Patch queued up.

thanks,
  Gerd

