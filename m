Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D1DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3096218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbfB1PIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:08:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731275AbfB1PIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:08:15 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SF4Cem080735
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:08:14 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qxfhnfwv3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 10:08:14 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 28 Feb 2019 15:08:12 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Feb 2019 15:08:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1SF86Zm11665490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 15:08:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D747D11C05B;
        Thu, 28 Feb 2019 15:08:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A37711C04C;
        Thu, 28 Feb 2019 15:08:06 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.99.237])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Feb 2019 15:08:06 +0000 (GMT)
Date:   Thu, 28 Feb 2019 16:08:05 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 0/7] vfio: ap: AP Queue Interrupt Control
In-Reply-To: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022815-4275-0000-0000-000003152541
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022815-4276-0000-0000-000038236C99
Message-Id: <20190228160805.3fcc126b@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=727 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 16:29:53 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> This patch implement PQAP/AQIC interception in KVM.
> 
> To implement this we need to add a new structure, vfio_ap_queue,to be
> able to retrieve the mediated device associated with a queue and specific
> values needed to register/unregister the interrupt structures:
>  - APQN: to be able to issue the commands and search for queue structures
>  - NIB : to unpin the NIB on clear IRQ
>  - ISC : to unregister with the GIB interface
>  - MATRIX: a pointer to the matrix mediated device
>  - LIST: the list_head to handle the vfio_queue life cycle
> 
> Having this structure and the list management greatly ease the handling
> of the AP queues and diminues the LOCs needed in the vfio_ap driver by
> more than 150 lines in comparison with the previous version.
> 
> 
> 0) Queues life cycle
> 
> vfio_ap_queues are created on probe
> 
> We define one bucket on the matrix device to store the free vfio_ap_queues,
> the queues not assign to any matrix mediated device.
> 
> We define one bucket on each matrix mediated device to hold the
> vfio_ap_queues belonging to it.
> 
> vfio_ap_queues are deleted on remove
> 
> This makes the search for a queue easy and the detection of assignent
> incoherency obvious (the queue is not avilable) and simplifies assignment.
> 
> 
> 1) Phase 1, probe and remove from vfio_ap_queue
> 
> The vfio_ap_queue structures are dynamically allocated and setup
> when a queue is probed by the ap_vfio_driver.
> The vfio_ap_queue is linked to the ap_queue device as the driver data.
> 
> The new The vfio_ap_queue is put on a free_list belonging to the
> matrix device.
> 
> The vfio_ap_queue are free during remove.
> 
> 
> 2) Phase 2, assignment of vfio_ap_queue to a mediated device
> 
> When a APID is assigned we look for APQI already assigned to
> the matrix mediated device and associate all the queue with the
> APQN = (APID,APQI) to the mediated device by adding them to
> the mediated device queue list.
> We do the same when a APQI is assigned.
> 
> If any queue with a matching APQN can not be found on the matrix
> device free list it means it is already associated to another matrix
> mediated device and no queue is added to the matrix mediated device.
> 
> 3) Phase 3, starting the guest
> 
> When the VFIO device is opened the PQAP callback and a pointer to
> the matrix mediated device are set inside KVM during the open callback.
> 
> When the device is closed or if a queue is removed, the vfio_ap_queue is
> dissociated from the mediated device.
> 
> 
> 4) Phase 3 intercepting the PQAP/AQIC instruction
> 
> On interception of the PQAP/AQIC instruction, the interception code
> makes sure the pqap_hook is initialized and allowed to be called
> and call it.
> Otherwise it reports the usual -EOPNOTSUPP return code to let
> QEMU handle the fault.
>   
> the pqap callback search for the queue asociated with the APQN
> stored in the register 0, setting the code to "illegal APQN"
> if the vfio_ap_queue can not be found.
> 
> Depending on the "i" bit of the register 1, the pqap callback
> setup or clear the interruption by calling the host format PQAP/AQIC
> instruction.
> When seting up the interruption it uses the NIB and the guest ISC
> provided by the guest and the host ISC provided by the registration
> to the GIB code, pin the NIB and also stores ISC and NIB inside
> the vfio_ap_queue structure.
> When clearing the interrupt it retrieves the host ISC to unregister
> with the GIB code and unpin the NIB.
> 
> We take care when enabling GISA that the guest may have issued a
> reset and will not need to disable the interuptions before
> re-enabling interruptions.

Please let us know what guarantees, that we will disable the
interruptions we previously enabled using AQIC (and generally facilitate
proper cleanup) *before* kvm_s390_gisa_destroy() makes the gisa and
with that the IPM go away!

Please note that IMHO this needs to be guaranteed by the kernel
regardless of what userspace (QEMU) or the guest does.

(I've asked this question before during our internal review but I could
not find the answer if there was one after going trough my mails.)

Regards,
Halil

