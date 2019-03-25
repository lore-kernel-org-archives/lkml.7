Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011B720863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mwF6RY/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfCYSlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:41:13 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17776 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfCYSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:41:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9920c30000>; Mon, 25 Mar 2019 11:41:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 11:41:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Mar 2019 11:41:09 -0700
Received: from [10.24.70.95] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Mar
 2019 18:41:06 +0000
Subject: Re: [PATCH 3/8] vfio/mdev: Removed unused kref
To:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
 <1553296835-37522-4-git-send-email-parav@mellanox.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <235e0fbf-0ed7-211e-64fa-08a173db45c0@nvidia.com>
Date:   Tue, 26 Mar 2019 00:11:01 +0530
MIME-Version: 1.0
In-Reply-To: <1553296835-37522-4-git-send-email-parav@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553539267; bh=e7/eeZtULPIyCKfTEsC1xwk8qXIRSPsX0XufTlKRMHo=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mwF6RY/7LaN68bv3o5QgQT1GmT1JEn7ZvDzoL/8s2s6yYB8Nqw7i4Cs+0IZ1zi9qi
         MYALFThxNe2jRik8up9OJOPB7gRyGcZEWU1MqRbogxPWDYByVdL7rB7ip1r3NWbO5B
         v29U3vSkyjoWJN/Pp2zuAIZG0O/kTT4lz2J5jRyEM5ssph25DhE9eeq4wicEPEsMRI
         i4bDP5m4Po8AtkUluaMODmeKm44h5D0AN8aaDXYfPg8Jp8MlJm4WtrRxKX1Sc7Yra3
         0AYG3HIO/lpGmgr8kxdQF9nSrKgSiANiU5q1Wyp3bFrXYEGFyNAPFGmJabbx2Qccxn
         MD4IW4TWV29Gw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2019 4:50 AM, Parav Pandit wrote:
> Remove unused kref from the mdev_device structure.
> 
> Fixes: 7b96953bc640 ("vfio: Mediated device Core driver")
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/vfio/mdev/mdev_core.c    | 1 -
>  drivers/vfio/mdev/mdev_private.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> index 4f213e4d..3d91f62 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -311,7 +311,6 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
>  	mutex_unlock(&mdev_list_lock);
>  
>  	mdev->parent = parent;
> -	kref_init(&mdev->ref);
>  
>  	mdev->dev.parent  = dev;
>  	mdev->dev.bus     = &mdev_bus_type;
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
> index b5819b7..84b2b6c 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -30,7 +30,6 @@ struct mdev_device {
>  	struct mdev_parent *parent;
>  	uuid_le uuid;
>  	void *driver_data;
> -	struct kref ref;
>  	struct list_head next;
>  	struct kobject *type_kobj;
>  	bool active;
> 

Yes, this should be removed.

Reviewed By: Kirti Wankhede <kwankhede@nvidia.com>

Thanks,
Kirti

