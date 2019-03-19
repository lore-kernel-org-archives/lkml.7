Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0169EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEE8206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfCSQsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:48:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726876AbfCSQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:48:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2JGmOva139150
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:48:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rb48xg09r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:48:35 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 19 Mar 2019 16:48:30 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 16:48:27 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2JGmQuV44892402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 16:48:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17220AE053;
        Tue, 19 Mar 2019 16:48:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1943AE051;
        Tue, 19 Mar 2019 16:48:24 +0000 (GMT)
Received: from [9.145.41.62] (unknown [9.145.41.62])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 16:48:24 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v5 4/7] s390: ap: setup relation betwen KVM and mediated
 device
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
 <1552493104-30510-5-git-send-email-pmorel@linux.ibm.com>
 <20190315191557.6c8d7668@oc2783563651>
 <7c199329-0e82-ff61-46b7-78237a0f01ce@linux.ibm.com>
 <20190319125425.0cf5324e@oc2783563651>
 <2c459ebe-2b37-72bc-1ede-b196e54dc78d@linux.ibm.com>
 <dc32eea1-31c9-790e-f012-71259e51cb8c@linux.ibm.com>
 <20190319162712.37f804f8@oc2783563651>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 19 Mar 2019 17:48:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319162712.37f804f8@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031916-0028-0000-0000-00000355F212
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031916-0029-0000-0000-000024149070
Message-Id: <1dd78905-bc87-d47c-6e8a-ba0a2a00102d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 16:27, Halil Pasic wrote:
> On Tue, 19 Mar 2019 15:47:05 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>>>>>>>         if (matrix_mdev->kvm)
>>>>>>>             kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
>>>>>>
>>>>>> This still conditional?
>>>>>
>>>>> Yes, nothing to clear if there is no KVM.
>>>>>   
>>>>
>>>> Since we have ensured the open only works if there is a KVM at that
>>>> point in time, and we have taken a reference to KVM, I would expect
>>>> KVM can not go away before we give up our reference.
>>>
>>> Right.
>>
>> Right but based on the assumption we do a kvm_get_kvm() during open.
>>
>> But now we will do it inside the notifier, so the logic is to do a
>> kvm_put_kvm in the notifier too.
>> This is important because userland will ask us to release the KVM/VFIO
>> link through this notifier.
>> So I will have to rework this part where KVM==NULL in the notifier too.
>>
>> Regards,
>> Pierre
> 
> I think it can be done both ways. If you ensure KVM != NULL if the open
> succeeds and take the reference in the notifier. I suppose if open()
> fails release() won't be called. But the logic/code in open() would get
> quite ugly because the callback could be called assync so that it
> overlaps with the rest of open().

Not necessary, but there is more than just the kvm_get_kvm().

When the user calls KVM_DEV_VFIO_GROUP_DEL he asks to break the link 
between VFIO and KVM.

Currently we just ignore this instead of stopping all activity 
associated with KVM.

But we have more bugs there:
We should not support multiple open of the mdev which will overwrite 
matrix->kvm for the same mdev with a different KVM.
I send a bugfix for this.


> 
> Not failing open() in case of no KVM is there yet is in my opinion
> cleaner anyway.

If we handle correctly the notifiers and the exclusivity, we can do this.
I will make this correctly for the next iteration.

Regards,
Pierre

> 
> Regards,
> Halil
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

