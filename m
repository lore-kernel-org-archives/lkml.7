Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC7BC10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727E520836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCCNLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:11:19 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53574 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCCNLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:11:18 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id B57089E77B1;
        Sun,  3 Mar 2019 13:11:14 +0000 (GMT)
Date:   Sun, 3 Mar 2019 13:11:12 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH] docs: driver-api: iio: fix errors in documentation
Message-ID: <20190303131112.0d072a01@archlinux>
In-Reply-To: <20190225202326.17178-1-tduszyns@gmail.com>
References: <20190225202326.17178-1-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 21:23:26 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Improve IIO documentation by fixing a few mistakes.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan


> ---
>  Documentation/driver-api/iio/buffers.rst     | 2 +-
>  Documentation/driver-api/iio/core.rst        | 6 +++---
>  Documentation/driver-api/iio/hw-consumer.rst | 2 +-
>  Documentation/driver-api/iio/triggers.rst    | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/iio/buffers.rst b/Documentation/driver-api/iio/buffers.rst
> index 02c99a6bee18..e9036ef9f8f4 100644
> --- a/Documentation/driver-api/iio/buffers.rst
> +++ b/Documentation/driver-api/iio/buffers.rst
> @@ -26,7 +26,7 @@ IIO buffer setup
>  ================
> 
>  The meta information associated with a channel reading placed in a buffer is
> -called a scan element . The important bits configuring scan elements are
> +called a scan element. The important bits configuring scan elements are
>  exposed to userspace applications via the
>  :file:`/sys/bus/iio/iio:device{X}/scan_elements/*` directory. This file contains
>  attributes of the following form:
> diff --git a/Documentation/driver-api/iio/core.rst b/Documentation/driver-api/iio/core.rst
> index 9a34ae03b679..54f193edbf8b 100644
> --- a/Documentation/driver-api/iio/core.rst
> +++ b/Documentation/driver-api/iio/core.rst
> @@ -2,8 +2,8 @@
>  Core elements
>  =============
> 
> -The Industrial I/O core offers a unified framework for writing drivers for
> -many different types of embedded sensors. a standard interface to user space
> +The Industrial I/O core offers both a unified framework for writing drivers for
> +many different types of embedded sensors and a standard interface to user space
>  applications manipulating sensors. The implementation can be found under
>  :file:`drivers/iio/industrialio-*`
> 
> @@ -11,7 +11,7 @@ Industrial I/O Devices
>  ----------------------
> 
>  * struct :c:type:`iio_dev` - industrial I/O device
> -* :c:func:`iio_device_alloc()` - alocate an :c:type:`iio_dev` from a driver
> +* :c:func:`iio_device_alloc()` - allocate an :c:type:`iio_dev` from a driver
>  * :c:func:`iio_device_free()` - free an :c:type:`iio_dev` from a driver
>  * :c:func:`iio_device_register()` - register a device with the IIO subsystem
>  * :c:func:`iio_device_unregister()` - unregister a device from the IIO
> diff --git a/Documentation/driver-api/iio/hw-consumer.rst b/Documentation/driver-api/iio/hw-consumer.rst
> index 8facce6a6733..e0fe0b98230e 100644
> --- a/Documentation/driver-api/iio/hw-consumer.rst
> +++ b/Documentation/driver-api/iio/hw-consumer.rst
> @@ -1,7 +1,7 @@
>  ===========
>  HW consumer
>  ===========
> -An IIO device can be directly connected to another device in hardware. in this
> +An IIO device can be directly connected to another device in hardware. In this
>  case the buffers between IIO provider and IIO consumer are handled by hardware.
>  The Industrial I/O HW consumer offers a way to bond these IIO devices without
>  software buffer for data. The implementation can be found under
> diff --git a/Documentation/driver-api/iio/triggers.rst b/Documentation/driver-api/iio/triggers.rst
> index f89d37e7dd82..5c2156de6284 100644
> --- a/Documentation/driver-api/iio/triggers.rst
> +++ b/Documentation/driver-api/iio/triggers.rst
> @@ -38,7 +38,7 @@ There are two locations in sysfs related to triggers:
> 
>  * :file:`/sys/bus/iio/devices/iio:device{X}/trigger/*`, this directory is
>    created once the device supports a triggered buffer. We can associate a
> -  trigger with our  device by writing the trigger's name in the
> +  trigger with our device by writing the trigger's name in the
>    :file:`current_trigger` file.
> 
>  IIO trigger setup
> --
> 2.20.1
> 

