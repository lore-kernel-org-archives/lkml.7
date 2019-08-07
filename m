Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59025C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F8821E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbfHGJ2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfHGJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:28:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF3B72F366E;
        Wed,  7 Aug 2019 09:28:07 +0000 (UTC)
Received: from gondolin (ovpn-117-166.ams2.redhat.com [10.36.117.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDD391001284;
        Wed,  7 Aug 2019 09:28:03 +0000 (UTC)
Date:   Wed, 7 Aug 2019 11:28:01 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     kvm@vger.kernel.org, wankhede@nvidia.com,
        linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
        cjia@nvidia.com
Subject: Re: [PATCH v1 2/2] vfio/mdev: Removed unused and redundant API for
 mdev UUID
Message-ID: <20190807112801.6b2ceb36.cohuck@redhat.com>
In-Reply-To: <20190806141826.52712-3-parav@mellanox.com>
References: <20190802065905.45239-1-parav@mellanox.com>
        <20190806141826.52712-1-parav@mellanox.com>
        <20190806141826.52712-3-parav@mellanox.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 09:28:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Aug 2019 09:18:26 -0500
Parav Pandit <parav@mellanox.com> wrote:

> There is no single production driver who is interested in mdev device
> uuid. Currently UUID is mainly used to derive a device name.
> Additionally mdev device name is already available using core kernel
> API dev_name().

Well, the mdev code actually uses the uuid to check for duplicates
before registration with the driver core would fail... I'd just drop
the two sentences talking about the device name, IMHO they don't really
add useful information; but I'll leave that decision to the maintainers.

> 
> Hence removed unused exported symbol.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
> Changelog:
> v0->v1:
>  - Updated commit log to address comments from Cornelia
> ---
>  drivers/vfio/mdev/mdev_core.c | 6 ------
>  include/linux/mdev.h          | 1 -
>  2 files changed, 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
