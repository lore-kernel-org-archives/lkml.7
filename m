Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F3CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179220675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ipPaBOPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCGWCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:02:07 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18638 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfCGWCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:02:07 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8194d30000>; Thu, 07 Mar 2019 14:01:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 07 Mar 2019 14:02:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 07 Mar 2019 14:02:04 -0800
Received: from [10.24.71.26] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Mar
 2019 22:02:00 +0000
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
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
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
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <931d95b3-7153-4bfc-353b-7226d4ea9465@nvidia.com>
Date:   Fri, 8 Mar 2019 03:31:56 +0530
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB2271020E5B8C2345AFFBF968D14C0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551996116; bh=MLCFhA0OqeTDv/SfQOhiKXXQXXc0qTu34HvnmxDs6uo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ipPaBOPSw/VQjLIK+W/vdD0CdOZUY58tV/cY2x/7BdBXX1zPlcjZ3JYRTxF6PfXx3
         iqM1Eu7RtC0diqcNpHI+goqA0OG0eJ/GSnKz5lpaJSXz9KlnjTmnIqs3qhtgzv1TOK
         laQl/r9N4605epOahvbuD85EQPPUzZGC8GIgAqW1nC/vBMcOOB5Vtov6PdqeAqxRvI
         +l8njCJKbenocl0iyzAMXqlrVQGWuv9EhsFM7WSvsv0CtqmNwhs71zzXECG92HXuQa
         32bqEb9r3DUHp1GKkLo0xmdJ9Mb0wZl3JXJh49jqkGTU4fs5fRmM+w4KFKMhQPEwsX
         zNYEAt6ThUFFA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2019 2:51 AM, Parav Pandit wrote:
> 
> 
>> -----Original Message-----
>> From: Kirti Wankhede <kwankhede@nvidia.com>
>> Sent: Thursday, March 7, 2019 3:08 PM
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
>> On 3/8/2019 2:32 AM, Parav Pandit wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Kirti Wankhede <kwankhede@nvidia.com>
>>>> Sent: Thursday, March 7, 2019 2:54 PM
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
>>>> <snip>
>>>>
>>>>>>>
>>>>>>> Yes. I got my patches to adapt to mdev way. Will be posting RFC v2
>> soon.
>>>>>>> Will wait for a day to receive more comments/views from Greg and
>>>> others.
>>>>>>>
>>>>>>> As I explained in this cover-letter and discussion, First use case
>>>>>>> is to create and use mdevs in the host (and not in VM).
>>>>>>> Later on, I am sure once we have mdevs available, VM users will
>>>>>>> likely use
>>>>>> it.
>>>>>>>
>>>>>>> So, mlx5_core driver will have two components as starting point.
>>>>>>>
>>>>>>> 1. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev.c
>>>>>>> This is mdev device life cycle driver which will do,
>>>>>>> mdev_register_device()
>>>>>> and implements mlx5_mdev_ops.
>>>>>>>
>>>>>> Ok. I would suggest not use mdev.c file name, may be add device
>>>>>> name, something like mlx_mdev.c or vfio_mlx.c
>>>>>>
>>>>> mlx5/core is coding convention is not following to prefix mlx to its
>>>>> 40+
>>>> files.
>>>>>
>>>>> it uses actual subsystem or functionality name, such as, sriov.c
>>>>> eswitch.c fw.c en_tc.c (en for Ethernet) lag.c so, mdev.c aligns to
>>>>> rest of the 40+ files.
>>>>>
>>>>>
>>>>>>> 2. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev_driver.c
>>>>>>> This is mdev device driver which does mdev_register_driver() and
>>>>>>> probe() creates netdev by heavily reusing existing code of the PF
>> device.
>>>>>>> These drivers will not be placed under drivers/vfio/mdev, because
>>>>>>> this is
>>>>>> not a vfio driver.
>>>>>>> This is fine, right?
>>>>>>>
>>>>>>
>>>>>> I'm not too familiar with netdev, but can you create netdev on
>>>>>> open() call on mlx mdev device? Then you don't have to write mdev
>>>>>> device
>>>> driver.
>>>>>>
>>>>> Who invokes open() and release()?
>>>>> I believe it is the qemu would do open(), release, read/write/mmap?
>>>>>
>>>>> Assuming that is the case,
>>>>> I think its incorrect to create netdev in open.
>>>>> Because when we want to map the mdev to VM using above mdev calls,
>>>>> we
>>>> actually wont be creating netdev in host.
>>>>> Instead, some queues etc will be setup as part of these calls.
>>>>>
>>>>> By default this created mdev is bound to vfio_mdev.
>>>>> And once we unbind the device from this driver, we need to bind to
>>>>> mlx5
>>>> driver so that driver can create the netdev etc.
>>>>>
>>>>> Or did I get open() and friends call wrong?
>>>>>
>>>>
>>>> In 'struct mdev_parent_ops' there are create() and remove(). When
>>>> user creates mdev device by writing UUID to create sysfs, vendor
>>>> driver's
>>>> create() callback gets called. This should be used to allocate/commit
>>> Yes. I am already past that stage.
>>>
>>>> resources from parent device and on remove() callback free those
>> resources.
>>>> So there is no need to bind mlx5 driver to that mdev device.
>>>>
>>> If we don't bind mlx5 driver, vfio_mdev driver is bound to it. Such driver
>> won't create netdev.
>>
>> Doesn't need to.
>>
>> Create netdev from create() callback.
>>
> I strongly believe this is incorrect way to use create() API.
> Because,
> mdev is mediated device from its primary pci device. It is not a protocol device.
> 
> It it also incorrect to tell user that vfio_mdev driver is bound to this mdev and mlx5_core driver creating netdev on top of mdev.
> 

vfio_mdev is generic common driver.
Vendor driver who want to partition its device should handle its child
creation and its life cycle. What is wrong in that? Why netdev has to be
created from probe() only and not from create()?

> When we want to map this mdev to VM, what should create() do?

Mediated device should be created before it is mapped to VM.

If you look at the sequence of mdev device creation:
- 'struct device' is created with bus 'mdev_bus_type'
- register the device - device_register(&mdev->dev) -> which calls
vfio_mdev's probe() -> common code for all vendor drivers
- mdev_device_create_ops() -> calls vendor driver's create() -> this is
for vendor specific allocation and initialization. This is the callback
from where you can do what you want to do for mdev device creation and
initialization. Why it has to be named as probe()?


> We will have to shift the code from create() to mdev_device_driver()->probe() to address a use case of selectively mapping a mdev to VM or to host and implement appropriate open/close etc functions for VM case.
> 
> So why not start correctly from the beginning?
> 

What is wrong with current implementation which is being used and tested
for multiple devices?

Thanks,
Kirti

> 
>> Thanks,
>> Kirti
>>
>>> Again, we do not want to map this mdev to a VM.
>>> We want to consume it in the host where mdev is created.
>>> So I am able to detach this mdev from vfio_mdev driver as usaual using
>>> $ echo mdev_name > ../drivers/vfio_mdev/unbind
>>>
>>> Followed by binding it to mlx5_core driver.
>>>
>>> Below is sample output before binding it to mlx5_core driver.
>>> When we bind with mlx5_core driver, that driver creates the netdev in
>> host.
>>> If user wants to map this mdev to VM, user won't bind to mlx5_core driver.
>> instead he will bind to vfio driver and that does usual open/release/...
>>>
>>>
>>> lrwxrwxrwx 1 root root 0 Mar  7 14:24
>>> 69ea1551-d054-46e9-974d-8edae8f0aefe ->
>>> ../../../devices/pci0000:00/0000:00:02.2/0000:05:00.0/69ea1551-d054-46
>>> e9-974d-8edae8f0aefe
>>> [root@sw-mtx-036 net-next]# ls -l
>>> /sys/bus/mdev/devices/69ea1551-d054-46e9-974d-8edae8f0aefe/
>>> total 0
>>> lrwxrwxrwx 1 root root    0 Mar  7 14:24 driver ->
>> ../../../../../bus/mdev/drivers/vfio_mdev
>>> lrwxrwxrwx 1 root root    0 Mar  7 14:24 iommu_group ->
>> ../../../../../kernel/iommu_groups/0
>>> lrwxrwxrwx 1 root root    0 Mar  7 14:24 mdev_type ->
>> ../mdev_supported_types/mlx5_core-mgmt
>>> drwxr-xr-x 2 root root    0 Mar  7 14:24 power
>>> --w------- 1 root root 4096 Mar  7 14:24 remove
>>> lrwxrwxrwx 1 root root    0 Mar  7 14:24 subsystem -> ../../../../../bus/mdev
>>> -rw-r--r-- 1 root root 4096 Mar  7 14:24 uevent
>>>
>>>> open/release/read/write/mmap/ioctl are regular file operations for
>>>> that mdev device.
>>>>
>>>
>>>> Thanks,
>>>> Kirti
>>>
