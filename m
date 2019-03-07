Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128E2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD66420851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FPaYYaZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCGTEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:04:42 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9494 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCGTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:04:41 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c816b3d0000>; Thu, 07 Mar 2019 11:04:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 07 Mar 2019 11:04:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 07 Mar 2019 11:04:38 -0800
Received: from [10.24.71.26] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Mar
 2019 19:04:34 +0000
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
 <20190301120358.7970f0ad@cakuba.netronome.com>
 <VI1PR0501MB227107F2EB29C7462DEE3637D1710@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190304173529.59aef2b3@cakuba.netronome.com>
 <VI1PR0501MB227144934A3FE9460D6970E5D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <54d846bc-cfa5-6665-efcb-a6c85e87763b@nvidia.com>
 <VI1PR0501MB2271962A3044DD29CE0E4C0CD1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB2271A1E091538621F00B2433D1720@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <VI1PR0501MB227137E2040C23E255DAC4F3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <97d63e18-b151-8b35-6687-1dcf5216f08a@nvidia.com>
 <VI1PR0501MB22711C5925D09B9822382AC3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Nvconfidentiality: public
From:   Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <9dbc644f-4e4c-7119-8f99-99850fc67b73@nvidia.com>
Date:   Fri, 8 Mar 2019 00:34:25 +0530
MIME-Version: 1.0
In-Reply-To: <VI1PR0501MB22711C5925D09B9822382AC3D1730@VI1PR0501MB2271.eurprd05.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551985470; bh=I44o5OoLcRBsUetZ2cqYvN3laQAQqzVtZBDH65rLrak=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FPaYYaZeHhzGsosXv/VGVi6BqmcHBzCLKM0E39iXW7o5zEnv3oIMlwPXffKYhOmuP
         HBGdpA9kPvthzw8vWYZcbspKshcdGEdQ1kCZDMPg2DFWjRJPkQeLzjv3oXqhSCRChx
         UL82X4HxJniIZw6ifiShXYQBkYSCOv62/Zau7WQMVaAENQ4YACKVpIGhbDVrijNukG
         PaQ+YYpYnXwxKZcq2YbdOyr4BNkUzvEcBPwiiiPjF09/LVRc2pFGwxo4CNXjkIw7fe
         pviPXFTyEx28nRaL2ir0ETQstSj8F7iTRIrTUtZA1EQ0ljv6F3bXWHUWaqNYhwUDMv
         VArCqml/Ga9+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC +=3D Alex

On 3/6/2019 11:12 AM, Parav Pandit wrote:
> Hi Kirti,
>=20
>> -----Original Message-----
>> From: Kirti Wankhede <kwankhede@nvidia.com>
>> Sent: Tuesday, March 5, 2019 9:51 PM
>> To: Parav Pandit <parav@mellanox.com>; Jakub Kicinski
>> <jakub.kicinski@netronome.com>
>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org; michal.lkml@markovi.net; davem@davemloft.net;
>> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
>> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink exten=
sion
>>
>>
>>
>> On 3/6/2019 6:14 AM, Parav Pandit wrote:
>>> Hi Greg, Kirti,
>>>
>>>> -----Original Message-----
>>>> From: Parav Pandit
>>>> Sent: Tuesday, March 5, 2019 5:45 PM
>>>> To: Parav Pandit <parav@mellanox.com>; Kirti Wankhede
>>>> <kwankhede@nvidia.com>; Jakub Kicinski
>> <jakub.kicinski@netronome.com>
>>>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; michal.lkml@markovi.net;
>> davem@davemloft.net;
>>>> gregkh@linuxfoundation.org; Jiri Pirko <jiri@mellanox.com>
>>>> Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink
>>>> extension
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
>>>>> owner@vger.kernel.org> On Behalf Of Parav Pandit
>>>>> Sent: Tuesday, March 5, 2019 5:17 PM
>>>>> To: Kirti Wankhede <kwankhede@nvidia.com>; Jakub Kicinski
>>>>> <jakub.kicinski@netronome.com>
>>>>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org;
>>>>> linux- kernel@vger.kernel.org; michal.lkml@markovi.net;
>>>>> davem@davemloft.net; gregkh@linuxfoundation.org; Jiri Pirko
>>>>> <jiri@mellanox.com>
>>>>> Subject: RE: [RFC net-next 0/8] Introducing subdev bus and devlink
>>>>> extension
>>>>>
>>>>> Hi Kirti,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Kirti Wankhede <kwankhede@nvidia.com>
>>>>>> Sent: Tuesday, March 5, 2019 4:40 PM
>>>>>> To: Parav Pandit <parav@mellanox.com>; Jakub Kicinski
>>>>>> <jakub.kicinski@netronome.com>
>>>>>> Cc: Or Gerlitz <gerlitz.or@gmail.com>; netdev@vger.kernel.org;
>>>>>> linux- kernel@vger.kernel.org; michal.lkml@markovi.net;
>>>>>> davem@davemloft.net; gregkh@linuxfoundation.org; Jiri Pirko
>>>>>> <jiri@mellanox.com>
>>>>>> Subject: Re: [RFC net-next 0/8] Introducing subdev bus and devlink
>>>>>> extension
>>>>>>
>>>>>>
>>>>>>
>>>>>>> I am novice at mdev level too. mdev or vfio mdev.
>>>>>>> Currently by default we bind to same vendor driver, but when it
>>>>>>> was
>>>>>> created as passthrough device, vendor driver won't create netdevice
>>>>>> or rdma device for it.
>>>>>>> And vfio/mdev or whatever mature available driver would bind at
>>>>>>> that
>>>>>> point.
>>>>>>>
>>>>>>
>>>>>> Using mdev framework, if you want to partition a physical device
>>>>>> into multiple logic devices, you can bind those devices to same
>>>>>> vendor driver through vfio-mdev, where as if you want to
>>>>>> passthrough the device bind it to vfio-pci. If I understand
>>>>>> correctly, that is what you are
>>>>> looking for.
>>>>>>
>>>>>>
>>>>> We cannot bind a whole PCI device to vfio-pci, reason is, A given
>>>>> PCI device has existing protocol devices on it such as netdevs and rd=
ma
>> dev.
>>>>> This device is partitioned while those protocol devices exist and
>>>>> mlx5_core, mlx5_ib drivers are loaded on it.
>>>>> And we also need to connect these objects rightly to eswitch exposed
>>>>> by devlink interface (net/core/devlink.c) that supports eswitch
>>>>> binding, health, registers, parameters, ports support.
>>>>> It also supports existing PCI VFs.
>>>>>
>>>>> I don=E2=80=99t think we want to replicate all of this again in mdev =
subsystem [1].
>>>>>
>>>>> [1]
>>>>> https://www.kernel.org/doc/Documentation/vfio-mediated-device.txt
>>>>>
>>>>> So devlink interface to migrate users from managing VFs to non_VF
>>>>> sub device is natural progression.
>>>>>
>>>>> However, in future, I believe we would be creating mediated devices
>>>>> on user request, to use mdev modules and map them to VM.
>>>>>
>>>>> Also 'mdev_bus' is created as a class and not as a bus. This limits
>>>>> to not use devlink interface whose handle is bus+device name.
>>>>>
>>>>> So one option is to change mdev from class to bus.
>>>>> devlink will create mdevs on the bus, mdev driver can probe these
>>>>> devices on host system by default.
>>>>> And if told to do passthrough, a different driver exposes them to VM.
>>>>> How feasible is this?
>>>>>
>>>> Wait, I do see a mdev bus and mdevs are created on this bus using
>>>> mdev_device_create().
>>>> So how about we create mdevs on this bus using devlink, instead of sys=
fs?
>>>> And driver side on host gets the mdev_register_driver()->probe()?
>>>>
>>>
>>> Thinking more and reviewing more mdev code, I believe mdev fits this
>>> need a lot better than new subdev bus, mfd, platform device, or devlink
>> subport.
>>> For coming future, to map this sub device (mdev) to VM will also be eas=
ier
>> by using mdev bus.
>>>
>>
>> Thanks for taking close look at mdev code.
>>
>> Assigning mdev to VM support is already in place, QEMU and libvirt have
>> support to assign mdev device to VM.
>>
>>> I also believe we can use the sysfs interface for mdev life cycle.
>>> Here when mdev are created it will register as devlink instance and
>>> will be able to query/config parameters before driver probe the device.
>>> (instead of having life cycle via devlink)
>>>
>>> Few enhancements would be needed for mdev side.
>>> 1. making iommu optional.
>>
>> Currently mdev devices are not IOMMU aware, vendor driver is responsible
>> for programming IOMMU for mdev device, if required.
>> IOMMU aware mdev device patch set is almost reviewed and ready to get
>> pulled. This is optional, vendor driver have to decide whether mdev devi=
ce
>> should be associated with its parents IOMMU or not. I'm testing it and I
>> think Alex is on vacation and this will get pulled when Alex will be bac=
k from
>> vacation.
>> https://lwn.net/Articles/779650/
>>
>>> 2. configuring mdev device parameters during creation time
>>>
>>
>> Mdev framework provides a way to define multiple types for creation
>> through sysfs. You can define multiple types rather than having creation
>> time parameter and on creation accordingly update 'available_instances'.
>> Mdev also provides a way to provide vendor-specific-attributes for paren=
t
>> physical device as well as for created mdev device. You can add sysfs
>> interface to get input parameters for a mdev device which can be used by
>> vendor driver when open() on that mdev device is called.
>>
>> Thanks,
>> Kirti
>=20
> Yes. I got my patches to adapt to mdev way. Will be posting RFC v2 soon.
> Will wait for a day to receive more comments/views from Greg and others.
>=20
> As I explained in this cover-letter and discussion,
> First use case is to create and use mdevs in the host (and not in VM).
> Later on, I am sure once we have mdevs available, VM users will likely us=
e it.
>=20
> So, mlx5_core driver will have two components as starting point.
>=20
> 1. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev.c
> This is mdev device life cycle driver which will do, mdev_register_device=
() and implements mlx5_mdev_ops.
>=20
Ok. I would suggest not use mdev.c file name, may be add device name,
something like mlx_mdev.c or vfio_mlx.c

> 2. drivers/net/ethernet/mellanox/mlx5/core/mdev/mdev_driver.c
> This is mdev device driver which does mdev_register_driver()=20
> and probe() creates netdev by heavily reusing existing code of the PF dev=
ice.
> These drivers will not be placed under drivers/vfio/mdev, because this is=
 not a vfio driver.
> This is fine, right?
>

I'm not too familiar with netdev, but can you create netdev on open()
call on mlx mdev device? Then you don't have to write mdev device driver.


> Given that this is net driver, we will be submitting patches,
> through netdev mailing list through Dave Miller's net-next tree.
> And CC kvm@vger.kernel.org, you and others as usual.
> Are you ok, merging code this way as mdev device creator and mdev driver.
> Yes?
>=20

Keep Alex and me in loop.

Thanks,
Kirti
