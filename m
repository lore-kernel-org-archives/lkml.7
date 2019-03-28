Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4CE2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfC1UrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:47:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726243AbfC1UrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:47:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SKi8PN144769
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:47:03 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rh41xm5dq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 16:47:03 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 28 Mar 2019 20:47:02 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 20:47:00 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SKkt0I26869776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 20:46:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 802087805E;
        Thu, 28 Mar 2019 20:46:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5484C7805C;
        Thu, 28 Mar 2019 20:46:54 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 20:46:54 +0000 (GMT)
Subject: Re: [PATCH v6 4/7] vfio: ap: register IOMMU VFIO notifier
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-5-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 28 Mar 2019 16:46:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1553265828-27823-5-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032820-0004-0000-0000-000014F477B6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010830; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01181039; UDB=6.00618119; IPR=6.00961757;
 MB=3.00026198; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-28 20:47:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032820-0005-0000-0000-00008B0FEA64
Message-Id: <1731fb82-7877-9018-d12e-fd0e2406ac19@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 10:43 AM, Pierre Morel wrote:
> To be able to use the VFIO interface to facilitate the
> mediated device memory pinning/unpinning we need to register
> a notifier for IOMMU.
> 
> While we will start to pin one guest page for the interrupt indicator
> byte, this is still ok with ballooning as this page will never be
> used by the guest virtio-balloon driver.
> So the pinned page will never be freed. And even a broken guest does
> so, that would not impact the host as the original page is still
> in control by vfio.

I apologize, but I do not understand what you are saying in the second
sentence of the paragraph above. Why will the pinned page never be 
freed? I understand that the pinned page is under the control of vfio
until it is freed, but have no idea what you mean by "and even a broken
guest does so"? A broken guest does what? Can you please reword this so
it makes more sense?

> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 38 +++++++++++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
>   2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index bdb36e0..3478499 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -787,6 +787,35 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>   	NULL
>   };
>   
> +/**
> + * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
> + *
> + * @nb: The notifier block
> + * @action: Action to be taken
> + * @data: data associated with the request
> + *
> + * For an UNMAP request, unpin the guest IOVA (the NIB guest address we
> + * pinned before). Other requests are ignored.
> + *
> + */
> +static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	struct ap_matrix_mdev *matrix_mdev;
> +
> +	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
> +

I don't understand why we registered this notifier. I may be wrong, but
AFAIU, this notifier will be invoked only when the VFIO_IOMMU_UNMAP_DMA
ioctl is called from userspace. I did an experiment and inserted some
printf's to see if this ever gets called and verified it does not. Maybe
you have a good reason of which I'm not aware. Can you enlighten me
here?

> +	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
> +		struct vfio_iommu_type1_dma_unmap *unmap = data;
> +		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
> +
> +		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>   				       unsigned long action, void *data)
>   {
> @@ -897,6 +926,13 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   		goto free_notifier;
>   	}
>   
> +	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
> +	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
> +	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				     &events, &matrix_mdev->iommu_notifier);
> +	if (ret)
> +		goto free_notifier;
> +
>   	ret = vfio_ap_mdev_set_kvm(matrix_mdev);
>   	if (!ret)
>   		goto unlock;
> @@ -917,6 +953,8 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   
>   	mutex_lock(&matrix_dev->lock);
>   	vfio_ap_mdev_unset_kvm(matrix_mdev);
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				 &matrix_mdev->iommu_notifier);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
>   	module_put(THIS_MODULE);
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 3e6940c..4a287c8 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -82,9 +82,11 @@ struct ap_matrix_mdev {
>   	struct list_head node;
>   	struct ap_matrix matrix;
>   	struct notifier_block group_notifier;
> +	struct notifier_block iommu_notifier;
>   	struct kvm *kvm;
>   	struct kvm_s390_module_hook pqap_hook;
>   	struct list_head qlist;
> +	struct mdev_device *mdev;
>   };
>   
>   extern int vfio_ap_mdev_register(void);
> 

