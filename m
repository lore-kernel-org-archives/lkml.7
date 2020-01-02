Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C5C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814DD20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 06:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTxriNvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgABGdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 01:33:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35724 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbgABGdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 01:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577946830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohVOrNWpj0c3bWsX3PgzLSLsQD6hl11NBoAIGnizLQ4=;
        b=iTxriNvXVaRVv7kqRE+5xuNqqWlgh+uTlXksaN2BaUVzH9zMPiiQSTzp01K8d4abaPDOD7
        be2F2RME+bfO1LwVW+NKkQ8w4nuOzsdsRqYisH03Nr6uBakfk7ymHOmQ7kFaZh+9SZmDBz
        RhWta7vhFjpU2U2JiOVuhNviqLbkcCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-VzjtRnStPBiYnq0VfzyZnA-1; Thu, 02 Jan 2020 01:33:47 -0500
X-MC-Unique: VzjtRnStPBiYnq0VfzyZnA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1CC7107ACC4;
        Thu,  2 Jan 2020 06:33:45 +0000 (UTC)
Received: from [10.72.12.230] (ovpn-12-230.pek2.redhat.com [10.72.12.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 416CC5DA2C;
        Thu,  2 Jan 2020 06:33:22 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for
 virtio-mmio specification version 3
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org,
        gerry@linux.alibaba.com, jing2.liu@intel.com, chao.p.peng@intel.com
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <85eeab19-1f53-6c45-95a2-44c1cfd39184@redhat.com>
 <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <683cac51-853d-c8c8-24c6-b01886978ca4@redhat.com>
Date:   Thu, 2 Jan 2020 14:33:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <28da67db-73ab-f772-fb00-5a471b746fc5@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/12/27 =E4=B8=8B=E5=8D=885:37, Liu, Jing2 wrote:
> Hi Jason,
>
> Thanks for reviewing the patches!
>
> =C2=A0[...]
>>> -
>>> +#include <linux/msi.h>
>>> +#include <asm/irqdomain.h>
>>> =C2=A0 =C2=A0 /* The alignment to use between consumer and producer p=
arts of=20
>>> vring.
>>> =C2=A0=C2=A0 * Currently hardcoded to the page size. */
>>> @@ -90,6 +90,12 @@ struct virtio_mmio_device {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* a list of queues so we can dispatch=
 IRQs */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t lock;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head virtqueues;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 int doorbell_base;
>>> +=C2=A0=C2=A0=C2=A0 int doorbell_scale;
>>
>>
>> It's better to use the terminology defined by spec, e.g=20
>> notify_base/notify_multiplexer etc.
>>
>> And we usually use unsigned type for offset.
>
> We will fix this in next version.
>
>
>>
>>
>>> +=C2=A0=C2=A0=C2=A0 bool msi_enabled;
>>> +=C2=A0=C2=A0=C2=A0 /* Name strings for interrupts. */
>>> +=C2=A0=C2=A0=C2=A0 char (*vm_vq_names)[256];
>>> =C2=A0 };
>>> =C2=A0 =C2=A0 struct virtio_mmio_vq_info {
>>> @@ -101,6 +107,8 @@ struct virtio_mmio_vq_info {
>>> =C2=A0 };
>>> =C2=A0 =C2=A0 +static void vm_free_msi_irqs(struct virtio_device *vde=
v);
>>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int=20
>>> nirqs);
>>> =C2=A0 =C2=A0 /* Configuration interface */
>>> =C2=A0 @@ -273,12 +281,28 @@ static bool vm_notify(struct virtqueue *=
vq)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct virtio_mmio_device *vm_dev =3D=20
>>> to_virtio_mmio_device(vq->vdev);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (vm_dev->version =3D=3D 3) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offset =3D vm_dev->do=
orbell_base +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_dev->doorbell_scale * vq->index;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(vq->index, vm_dev-=
>base + offset);
>>
>>
>> In virtio-pci we store the doorbell address in vq->priv to avoid=20
>> doing multiplication in fast path.
>
> Good suggestion. We will fix this in next version.
>
> [...]
>
>>> +
>>> +static int vm_request_msi_vectors(struct virtio_device *vdev, int=20
>>> nirqs)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct virtio_mmio_device *vm_dev =3D to_virtio_m=
mio_device(vdev);
>>> +=C2=A0=C2=A0=C2=A0 int irq, err;
>>> +=C2=A0=C2=A0=C2=A0 u16 csr =3D readw(vm_dev->base + VIRTIO_MMIO_MSI_=
STATUS);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (vm_dev->msi_enabled || (csr & VIRTIO_MMIO_MSI=
_ENABLE_MASK)=20
>>> =3D=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 vm_dev->vm_vq_names =3D kmalloc_array(nirqs,=20
>>> sizeof(*vm_dev->vm_vq_names),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 G=
FP_KERNEL);
>>> +=C2=A0=C2=A0=C2=A0 if (!vm_dev->vm_vq_names)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!vdev->dev.msi_domain)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vdev->dev.msi_domain =3D =
platform_msi_get_def_irq_domain();
>>> +=C2=A0=C2=A0=C2=A0 err =3D platform_msi_domain_alloc_irqs(&vdev->dev=
, nirqs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 m=
mio_write_msi_msg);
>>
>>
>> Can platform_msi_domain_alloc_irqs check msi_domain vs NULL?
>>
> Actually here, we need to firstly consider the cases that @dev doesn't=20
> have @msi_domain,
>
> according to the report by lkp.
>
> For the platform_msi_domain_alloc_irqs, it can help check inside.
>
>
>> [...]
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D register_virtio_device(&=
vm_dev->vdev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rc)
>>> @@ -619,8 +819,6 @@ static int virtio_mmio_remove(struct=20
>>> platform_device *pdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> =C2=A0 -
>>> -
>>
>>
>> Unnecessary changes.
>
> Got it. Will remove it later.
>
>
>> [...]
>>> =C2=A0 +/* MSI related registers */
>>> +
>>> +/* MSI status register */
>>> +#define VIRTIO_MMIO_MSI_STATUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0c0
>>> +/* MSI command register */
>>> +#define VIRTIO_MMIO_MSI_COMMAND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x0c2
>>> +/* MSI low 32 bit address, 64 bits in two halves */
>>> +#define VIRTIO_MMIO_MSI_ADDRESS_LOW=C2=A0=C2=A0=C2=A0 0x0c4
>>> +/* MSI high 32 bit address, 64 bits in two halves */
>>> +#define VIRTIO_MMIO_MSI_ADDRESS_HIGH=C2=A0=C2=A0=C2=A0 0x0c8
>>> +/* MSI data */
>>> +#define VIRTIO_MMIO_MSI_DATA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0x0cc
>>
>>
>> I wonder what's the advantage of using registers instead of memory=20
>> mapped tables as PCI did. Is this because MMIO doesn't have=20
>> capability list which makes it hard to be extended if we have=20
>> variable size of tables?
>>
> Yes, mmio doesn't have capability which limits the extension.


We may want to revisit and add something like this for future virtio=20
MMIO versions.


>
> It need some registers to specify the msi table/mask table/pending=20
> table offsets if using what pci did.
>
> As comments previously, mask/pending can be easily extended by MSI=20
> command.
>
>>
>>> +
>>> +/* RO: MSI feature enabled mask */
>>> +#define VIRTIO_MMIO_MSI_ENABLE_MASK=C2=A0=C2=A0=C2=A0 0x8000
>>> +/* RO: Maximum queue size available */
>>> +#define VIRTIO_MMIO_MSI_STATUS_QMASK=C2=A0=C2=A0=C2=A0 0x07ff
>>> +/* Reserved */
>>> +#define VIRTIO_MMIO_MSI_STATUS_RESERVED=C2=A0=C2=A0=C2=A0 0x7800
>>> +
>>> +#define VIRTIO_MMIO_MSI_CMD_UPDATE=C2=A0=C2=A0=C2=A0 0x1
>>
>>
>> I believe we need a command to read the number of vectors supported=20
>> by the device, or 2048 is assumed to be a fixed size here?
>
> For not bringing much complexity, we proposed vector per queue and=20
> fixed relationship between events and vectors.


It's a about the number of MSIs not the mapping between queues to MSIs.=20
And it looks to me it won't bring obvious complexity, just need a=20
register to read the #MSIs. Device implementation may stick to a fixed si=
ze.

Having few pages for a device that only have one queue is kind of a waste=
.

Thanks


>
>
> So the number of vectors supported by device is equal to the total=20
> number of vqs and config.
>
> We will try to explicitly highlight this point in spec for later versio=
n.
>
>
> Thanks!
>
> Jing
>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>

