Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F5DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C1520685
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qqozQFgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCYTHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:07:12 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16552 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:07:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9926e20000>; Mon, 25 Mar 2019 12:07:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Mar 2019 12:07:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Mar 2019 12:07:11 -0700
Received: from [10.24.70.95] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Mar
 2019 19:07:09 +0000
Subject: Re: [PATCH 4/8] vfio/mdev: Drop redundant extern for exported symbols
To:     Parav Pandit <parav@mellanox.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
 <1553296835-37522-5-git-send-email-parav@mellanox.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <658437a2-6ed1-c834-bc40-f1bf6dce920c@nvidia.com>
Date:   Tue, 26 Mar 2019 00:37:04 +0530
MIME-Version: 1.0
In-Reply-To: <1553296835-37522-5-git-send-email-parav@mellanox.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553540834; bh=Y3L4lTBtYm3DgoGk8V3wwnm0/vEgQe1YGBLNasnjKLI=;
        h=X-PGP-Universal:Subject:To:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=qqozQFggmLHSX5d/QduWSb8RXmmD2O4OdZEjIR/TnQv5AW+LDHBz45AL5Co7N1h5M
         iMyVlFvJ3opxo6KHNeNWNQJ/hwtISq+uJlZyro6Fgfbqp2yofeIgyx9UHkH2lHCtpb
         +TTVBNqJ4Znragz2d0f/vDWR7AlMHceKIUZKZS5HtdfXORyaLMTe4qzhWH9wh3UMCr
         T/DKLJb/ivfM05fPj9tnQHJ9840mew8ulHZXBmjJKvsw8uTV4fgbXn/lZhx9HEetx+
         hrxO9M8uhnyVTQ/xgiWGrhoFqKiF+nYK9pGtLGKjYDpW9FhUALgbi8Fmq5o4UbRdyz
         QNdQV9cDkKCJw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/2019 4:50 AM, Parav Pandit wrote:
> There is no need use 'extern' for exported functions.
> 
> Signed-off-by: Parav Pandit <parav@mellanox.com>
> ---
>  include/linux/mdev.h | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index b6e048e..0924c48 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -118,21 +118,20 @@ struct mdev_driver {
>  
>  #define to_mdev_driver(drv)	container_of(drv, struct mdev_driver, driver)
>  
> -extern void *mdev_get_drvdata(struct mdev_device *mdev);
> -extern void mdev_set_drvdata(struct mdev_device *mdev, void *data);
> -extern uuid_le mdev_uuid(struct mdev_device *mdev);
> +void *mdev_get_drvdata(struct mdev_device *mdev);
> +void mdev_set_drvdata(struct mdev_device *mdev, void *data);
> +uuid_le mdev_uuid(struct mdev_device *mdev);
>  
>  extern struct bus_type mdev_bus_type;
>  
> -extern int  mdev_register_device(struct device *dev,
> -				 const struct mdev_parent_ops *ops);
> -extern void mdev_unregister_device(struct device *dev);
> +int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops);
> +void mdev_unregister_device(struct device *dev);
>  
> -extern int  mdev_register_driver(struct mdev_driver *drv, struct module *owner);
> -extern void mdev_unregister_driver(struct mdev_driver *drv);
> +int mdev_register_driver(struct mdev_driver *drv, struct module *owner);
> +void mdev_unregister_driver(struct mdev_driver *drv);
>  
> -extern struct device *mdev_parent_dev(struct mdev_device *mdev);
> -extern struct device *mdev_dev(struct mdev_device *mdev);
> -extern struct mdev_device *mdev_from_dev(struct device *dev);
> +struct device *mdev_parent_dev(struct mdev_device *mdev);
> +struct device *mdev_dev(struct mdev_device *mdev);
> +struct mdev_device *mdev_from_dev(struct device *dev);
>  
>  #endif /* MDEV_H */
> 

Adding 'extern' to exported symbols is inline to other exported
functions from device's core module like device_register(),
device_unregister(), get_device(), put_device()

Thanks,
Kirti

