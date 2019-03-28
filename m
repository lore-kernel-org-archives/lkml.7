Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B3AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF482183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfC1QMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:12:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727247AbfC1QMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:12:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SG9WLZ122280
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:12:30 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rh16419gy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:12:29 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 28 Mar 2019 16:12:26 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 16:12:24 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SGCJLr11927686
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 16:12:19 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C577805F;
        Thu, 28 Mar 2019 16:12:19 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B046778064;
        Thu, 28 Mar 2019 16:12:17 +0000 (GMT)
Received: from [9.60.75.235] (unknown [9.60.75.235])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 16:12:17 +0000 (GMT)
Subject: Re: [PATCH v6 3/7] s390: ap: setup relation betwen KVM and mediated
 device
To:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1553265828-27823-1-git-send-email-pmorel@linux.ibm.com>
 <1553265828-27823-4-git-send-email-pmorel@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 28 Mar 2019 12:12:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1553265828-27823-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032816-0012-0000-0000-0000171E6E82
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010829; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01180947; UDB=6.00618064; IPR=6.00961666;
 MB=3.00026196; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-28 16:12:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032816-0013-0000-0000-000056AB59F5
Message-Id: <1ea236d1-ca0b-03c0-3699-0c0deb435785@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 10:43 AM, Pierre Morel wrote:
> When the mediated device is open we setup the relation with KVM unset it
> when the mediated device is released.

s/open we setup/open, we set up/
s/with KVM unset/with KVM and unset/

> 
> We lock the matrix mediated device to avoid any change until the
> open is done.
> We make sure that KVM is present when opening the mediated device
> otherwise we return an error.

s/mediated device/mediated device,/

> 
> Increase kvm's refcount to ensure the KVM structures are still available
> during the use of the mediated device by the guest.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 143 +++++++++++++++++++++-----------------
>   1 file changed, 79 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 77f7bac..bdb36e0 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -787,74 +787,24 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
>   	NULL
>   };
>   
> -/**
> - * vfio_ap_mdev_set_kvm
> - *
> - * @matrix_mdev: a mediated matrix device
> - * @kvm: reference to KVM instance
> - *
> - * Verifies no other mediated matrix device has @kvm and sets a reference to
> - * it in @matrix_mdev->kvm.
> - *
> - * Return 0 if no other mediated matrix device has a reference to @kvm;
> - * otherwise, returns an -EPERM.
> - */
> -static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> -				struct kvm *kvm)
> -{
> -	struct ap_matrix_mdev *m;
> -
> -	mutex_lock(&matrix_dev->lock);
> -
> -	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> -		if ((m != matrix_mdev) && (m->kvm == kvm)) {
> -			mutex_unlock(&matrix_dev->lock);
> -			return -EPERM;
> -		}
> -	}
> -
> -	matrix_mdev->kvm = kvm;
> -	mutex_unlock(&matrix_dev->lock);
> -
> -	return 0;
> -}
> -
>   static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>   				       unsigned long action, void *data)
>   {
> -	int ret;
>   	struct ap_matrix_mdev *matrix_mdev;
>   
>   	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>   		return NOTIFY_OK;
>   
>   	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> -
> -	if (!data) {
> -		matrix_mdev->kvm = NULL;
> -		return NOTIFY_OK;
> -	}
> -
> -	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
> -	if (ret)
> -		return NOTIFY_DONE;
> -
> -	/* If there is no CRYCB pointer, then we can't copy the masks */
> -	if (!matrix_mdev->kvm->arch.crypto.crycbd)
> -		return NOTIFY_DONE;
> -
> -	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
> -				  matrix_mdev->matrix.aqm,
> -				  matrix_mdev->matrix.adm);
> +	matrix_mdev->kvm = data;
>   
>   	return NOTIFY_OK;
>   }
>   
> -static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> +static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
>   {
>   	int ret;
>   	int rc = 0;
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   	struct vfio_ap_queue *q;
>   
>   	list_for_each_entry(q, &matrix_mdev->qlist, list) {
> @@ -871,41 +821,106 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
>   	return rc;
>   }
>   
> +/**
> + * vfio_ap_mdev_set_kvm
> + *
> + * @matrix_mdev: a mediated matrix device
> + *
> + * - Verifies that the hook is free and install the PQAP hook
> + * - Copy the matrix masks inside the CRYCB
> + * - Increment the KVM rerference count
> + *
> + * Return 0 if no other mediated matrix device has a reference to @kvm;
> + * otherwise, returns an -EPERM.
> + */
> +static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	if (matrix_mdev->kvm->arch.crypto.pqap_hook)
> +		return -EPERM;

How would this happen; in other words, why are we checking this?

> +	matrix_mdev->kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
> +
> +	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
> +				  matrix_mdev->matrix.aqm,
> +				  matrix_mdev->matrix.adm);
> +
> +	kvm_get_kvm(matrix_mdev->kvm);
> +	return 0;
> +}
> +
> +/**
> + * vfio_ap_mdev_unset_kvm
> + *
> + * @matrix_mdev: a mediated matrix device
> + *
> + * - Clears the matrix masks inside the CRYCB
> + * - Reset the queues before to clear the hook in case IRQ happen during
> + *   reset.
> + * - Clears the hook
> + * - Decrement the KVM rerference count
> + */
> +static int vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
> +{
> +	struct kvm *kvm = matrix_mdev->kvm;
> +
> +	kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> +	vfio_ap_mdev_reset_queues(matrix_mdev);
> +	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
> +	matrix_mdev->kvm = NULL;
> +	kvm_put_kvm(kvm);
> +	return 0;
> +}
> +
>   static int vfio_ap_mdev_open(struct mdev_device *mdev)
>   {
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   	unsigned long events;
>   	int ret;
>   
> +	mutex_lock(&matrix_dev->lock);
>   
> -	if (!try_module_get(THIS_MODULE))
> -		return -ENODEV;
> +	if (!try_module_get(THIS_MODULE)) {
> +		ret = -ENODEV;
> +		goto unlock;
> +	}
>   
>   	matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>   	events = VFIO_GROUP_NOTIFY_SET_KVM;
>   
>   	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				     &events, &matrix_mdev->group_notifier);
> -	if (ret) {
> -		module_put(THIS_MODULE);
> -		return ret;
> +	if (ret)
> +		goto put_unlock;
> +
> +	/* We do not support opening the mediated device without KVM */
> +	if (!matrix_mdev->kvm) {
> +		ret = -ENOENT;
> +		goto free_notifier;
>   	}
>   
> -	return 0;
> +	ret = vfio_ap_mdev_set_kvm(matrix_mdev);
> +	if (!ret)
> +		goto unlock;
> +
> +free_notifier:
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> +				 &matrix_mdev->group_notifier);
> +put_unlock:
> +	module_put(THIS_MODULE);
> +unlock:
> +	mutex_unlock(&matrix_dev->lock);
> +	return ret;
>   }
>   
>   static void vfio_ap_mdev_release(struct mdev_device *mdev)
>   {
>   	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>   
> -	if (matrix_mdev->kvm)
> -		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> -
> -	matrix_mdev->kvm = NULL;
> -	vfio_ap_mdev_reset_queues(mdev);
> +	mutex_lock(&matrix_dev->lock);
> +	vfio_ap_mdev_unset_kvm(matrix_mdev);
>   	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>   				 &matrix_mdev->group_notifier);
>   	module_put(THIS_MODULE);
> +	mutex_unlock(&matrix_dev->lock);
>   }
>   
>   static int vfio_ap_mdev_get_device_info(unsigned long arg)
> @@ -939,7 +954,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct mdev_device *mdev,
>   		break;
>   	case VFIO_DEVICE_RESET:
>   		mutex_lock(&matrix_dev->lock);
> -		ret = vfio_ap_mdev_reset_queues(mdev);
> +		ret = vfio_ap_mdev_reset_queues(mdev_get_drvdata(mdev));
>   		mutex_unlock(&matrix_dev->lock);
>   		break;
>   	default:
> 

