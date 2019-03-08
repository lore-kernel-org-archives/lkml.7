Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2FF20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Z643nSGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCHMTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:19:21 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11194 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfCHMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:19:21 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c825dc70000>; Fri, 08 Mar 2019 04:19:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Mar 2019 04:19:18 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 08 Mar 2019 04:19:18 -0800
Received: from [10.24.71.26] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 8 Mar
 2019 12:19:13 +0000
Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
To:     Parav Pandit <parav@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Or Gerlitz <gerlitz.or@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.lkml@markovi.net" <michal.lkml@markovi.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB227137E2040C23E255DAC4F3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <97d63e18-b151-8b35-6687-1dcf5216f08a@nvidia.com>
 <VI1PR0501MB22711C5925D09B9822382AC3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <9dbc644f-4e4c-7119-8f99-99850fc67b73@nvidia.com>
 <VI1PR0501MB227181D2B27A29BCD8F5342FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <9e9b3e39-a649-a9cd-83cc-dab74cf77ac7@nvidia.com>
 <VI1PR0501MB22715BECE805956776809A1FD14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <965ae0c8-5e6d-20ac-4baa-22b7e8dab5e3@nvidia.com>
 <VI1PR0501MB2271020E5B8C2345AFFBF968D14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <931d95b3-7153-4bfc-353b-7226d4ea9465@nvidia.com>
 <VI1PR0501MB22713073D559C8A6B656ECC6D14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <fc0896c4-390f-7202-e70f-85e2c7335182@nvidia.com>
Date:   Fri, 8 Mar 2019 17:49:02 +0530
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB22713073D559C8A6B656ECC6D14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552047559; bh=HnP8b9osLmzRq5jCSpz1R/3ZMQfSRe1SqJDnwQauG5k=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Z643nSGeISDyAd9QoexdW63K4xRhSfHgtTxZbKsU94xWIs8nrmsfY7GgT6KdLEeZE
         DGSabhw2kaZw1sxPzMRy5+qTDRQ4GTL0ao2kLom/u4CahiXB8/u/LVfWu+lpQGcUaT
         CAk93cMdGw/Ob8aMSARjWV9Tu5JEu4SewLSolg+QkE3Rd4CmCAd6gR45la3XM9kF5p
         gW34qjd/ceE4J3DLD7ddmgr7KcBI/nYp8f4mL7Rddsa4YzH7Fdm/1i3NiqC/Rznkg3
         tBK7KOntLiB0Pytne68O9N6f2MU+9ZMM1PQMVeryQGTHt3ZKpJP1nqfCocTQWSQG3y
         q5+vu5ERUe2iA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2019 4:01 AM, Parav Pandit wrote:
> 
> 
>> -----Original Message-----
>> From: Kirti Wankhede <kwankhede@nvidia.com>
>> Sent: Thursday, March 7, 2019 4:02 PM
>> To: Parav Pandit <parav@mellanox.com>; Jakub Kicinski
>> <jakub.kicinski@netronome.com>
>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; michal.lkml@markovi.net; davem@davemloft.net;
>> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>; Alex
>> Williamson <alex.williamson@redhat.com>
>> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink extension
>>
>>
>>
>> On 3/8/2019 2:51 AM, Parav Pandit wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Kirti Wankhede <kwankhede@nvidia.com>
>>>> Sent: Thursday, March 7, 2019 3:08 PM
>>>> To: Parav Pandit <parav@mellanox.com>; Jakub Kicinski
>>>> <jakub.kicinski@netronome.com>
>>>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; michal.lkml@markovi.net;
>> davem@davemloft.net;
>>>> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>; Alex
>>>> Williamson <alex.williamson@redhat.com>
>>>> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink
>>>> extension
>>>>
>>>>
>>>>
>>>> On 3/8/2019 2:32 AM, Parav Pandit wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Kirti Wankhede <kwankhede@nvidia.com>
>>>>>> Sent: Thursday, March 7, 2019 2:54 PM
>>>>>> To: Parav Pandit <parav@mellanox.com>; Jakub Kicinski
>>>>>> <jakub.kicinski@netronome.com>
>>>>>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org;
>>>>>> linux- kernel@vger.kernel.org; michal.lkml@markovi.net;
>>>> davem@davemloft.net;
>>>>>> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>; Alex
>>>>>> Williamson <alex.williamson@redhat.com>
>>>>>> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink
>>>>>> extension
>>>>>>
>>>>>>
>>>>>>
>>>>>> <snip>
>>>>>>
>>>>>>>>>
>>>>>>>>> Yes. I got my patches to adapt to mdev way. Will be posting RFC
>>>>>>>>> v2
>>>> soon.
>>>>>>>>> Will wait for a day to receive more comments/views from Greg and
>>>>>> others.
>>>>>>>>>
>>>>>>>>> As I explained in this cover-letter and discussion, First use
>>>>>>>>> case is to create and use mdevs in the host (and not in VM).
>>>>>>>>> Later on, I am sure once we have mdevs available, VM users will
>>>>>>>>> likely use
>>>>>>>> it.
>>>>>>>>>
>>>>>>>>> So, mlx5_core driver will have two components as starting point.
>>>>>>>>>
>>>>>>>>> 1. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev.c
>>>>>>>>> This is mdev device life cycle driver which will do,
>>>>>>>>> mdev_register_device()
>>>>>>>> and implements mlx5_mdev_ops.
>>>>>>>>>
>>>>>>>> Ok. I would suggest not use mdev.c file name, may be add device
>>>>>>>> name, something like mlx_mdev.c or vfio_mlx.c
>>>>>>>>
>>>>>>> mlx5/core is coding convention is not following to prefix mlx to
>>>>>>> its
>>>>>>> 40+
>>>>>> files.
>>>>>>>
>>>>>>> it uses actual subsystem or functionality name, such as, sriov.c
>>>>>>> eswitch.c fw.c en_tc.c (en for Ethernet) lag.c so, mdev.c aligns
>>>>>>> to rest of the 40+ files.
>>>>>>>
>>>>>>>
>>>>>>>>> 2. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev_driver.c
>>>>>>>>> This is mdev device driver which does mdev_register_driver() and
>>>>>>>>> probe() creates netdev by heavily reusing existing code of the
>>>>>>>>> PF
>>>> device.
>>>>>>>>> These drivers will not be placed under drivers/vfio/mdev,
>>>>>>>>> because this is
>>>>>>>> not a vfio driver.
>>>>>>>>> This is fine, right?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'm not too familiar with netdev, but can you create netdev on
>>>>>>>> open() call on mlx mdev device? Then you don't have to write mdev
>>>>>>>> device
>>>>>> driver.
>>>>>>>>
>>>>>>> Who invokes open() and release()?
>>>>>>> I believe it is the qemu would do open(), release, read/write/mmap?
>>>>>>>
>>>>>>> Assuming that is the case,
>>>>>>> I think its incorrect to create netdev in open.
>>>>>>> Because when we want to map the mdev to VM using above mdev
>> calls,
>>>>>>> we
>>>>>> actually wont be creating netdev in host.
>>>>>>> Instead, some queues etc will be setup as part of these calls.
>>>>>>>
>>>>>>> By default this created mdev is bound to vfio_mdev.
>>>>>>> And once we unbind the device from this driver, we need to bind to
>>>>>>> mlx5
>>>>>> driver so that driver can create the netdev etc.
>>>>>>>
>>>>>>> Or did I get open() and friends call wrong?
>>>>>>>
>>>>>>
>>>>>> In 'struct mdev_parent_ops' there are create() and remove(). When
>>>>>> user creates mdev device by writing UUID to create sysfs, vendor
>>>>>> driver's
>>>>>> create() callback gets called. This should be used to
>>>>>> allocate/commit
>>>>> Yes. I am already past that stage.
>>>>>
>>>>>> resources from parent device and on remove() callback free those
>>>> resources.
>>>>>> So there is no need to bind mlx5 driver to that mdev device.
>>>>>>
>>>>> If we don't bind mlx5 driver, vfio_mdev driver is bound to it. Such
>>>>> driver
>>>> won't create netdev.
>>>>
>>>> Doesn't need to.
>>>>
>>>> Create netdev from create() callback.
>>>>
>>> I strongly believe this is incorrect way to use create() API.
>>> Because,
>>> mdev is mediated device from its primary pci device. It is not a protocol
>> device.
>>>
>>> It it also incorrect to tell user that vfio_mdev driver is bound to this mdev
>> and mlx5_core driver creating netdev on top of mdev.
>>>
>>
>> vfio_mdev is generic common driver.
>> Vendor driver who want to partition its device should handle its child
>> creation and its life cycle. What is wrong in that? Why netdev has to be
>> created from probe() only and not from create()?
>>
> I am not suggesting to invent any new probe() method.
> create() is generic mdev creation entry point.
> When create() is implemented by vendor driver, vendor driver doesn't know if this mdev will be provisioned for VM or for host.

Vendor driver doesn't need to know if mdev device is going to used for
VM or host.

> So it must do only generic mdev init sequence.
> This means, it cannot create netdev here. As simple as that.
> 
> When user wants to use this mdev in a host, user will first unbind it from vfio_mdev driver and binds this mdev to mlx5_driver.
> probe() of mlx5_core driver is called who did mdev_register_driver.
> At this point netdev is created.
> 
> If user wants to use this mdev for VM, than vfio_mdev driver and qemu will control it via open/release friend functions.
> 

VFIO interface is generic interface, one example is QEMU, as a user
space application, uses VFIO interface. But that doesn't mean that if
you are using VFIO interface that is only be used for VM.
You can write a user space application for host using VFIO interface.


>>> When we want to map this mdev to VM, what should create() do?
>>
>> Mediated device should be created before it is mapped to VM.
>>
> Of course.
> Let me rephrase the question: 
> what shouldn't be done by create() when it wants to map to VM?
> Answer is: it shouldn't create a netdev, but do necessary initialization so that it can be mapped to VM.
> Because netdev will be created inside the VM not in the host.
> 
> create() simply doesn't know during creation time, where this mdev will be used (VM or host).
> So it doesn't make any sense to create netdev in create().
> 

As I explained above, I disagree with this comment.

> I hope it's clear now.
> 
>> If you look at the sequence of mdev device creation:
>> - 'struct device' is created with bus 'mdev_bus_type'
>> - register the device - device_register(&mdev->dev) -> which calls vfio_mdev's
>> probe() -> common code for all vendor drivers
>> - mdev_device_create_ops() -> calls vendor driver's create() -> this is for
>> vendor specific allocation and initialization. This is the callback from where
>> you can do what you want to do for mdev device creation and initialization.
>> Why it has to be named as probe()?
> 
> I do not intent to create any new probe().
> I think I explained the flow well above - 
> i.e. role of mdev_driver->probe() vs mdev_device->create().
> 
>>
>>> We will have to shift the code from create() to mdev_device_driver()-
>>> probe() to address a use case of selectively mapping a mdev to VM or to
>> host and implement appropriate open/close etc functions for VM case.
>>>
>>> So why not start correctly from the beginning?
>>>
>>
>> What is wrong with current implementation which is being used and tested
>> for multiple devices?
>>
> Oh, nothing wrong in current implementation.
> Which current implementation provisions mdev in host (and not in guest VM)?
>

All mdev vendor driver implementations. Mdev device for host or VM :
there is no such difference, interface is generic.

> I am just using right code split of already available mdev.
> When user wants to map a device to VM, attach vfio_mdev driver and create vfio_device.
> When user wants to use a device in host, don't attach vfio_mdev driver, instead attach, appropriate driver what owns this mdev.
> 

No need to do that. Use VFIO interface in your user space application
when you want to use device in host.

Thanks,
Kirti

> Again,  I am not inventing any new probe().
> We will use all existing infra of mdev and core kernel to bind/unbind driver with device.
> 
