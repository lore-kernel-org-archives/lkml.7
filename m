Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2EBC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5056621849
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfGWOZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:25:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726633AbfGWOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:25:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NEM5ks024249
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:25:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tx3sqgn7p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:25:17 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 23 Jul 2019 15:25:15 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 15:25:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NEPC1130146878
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 14:25:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BBD811C054;
        Tue, 23 Jul 2019 14:25:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA4A511C05C;
        Tue, 23 Jul 2019 14:25:11 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.96.145])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 14:25:11 +0000 (GMT)
Subject: Re: Linux 5.3-rc1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <1563839144.2504.5.camel@HansenPartnership.com>
 <4dc6ef77-afce-1c6d-add3-8df76332e672@roeck-us.net>
 <1563859682.2504.17.camel@HansenPartnership.com>
From:   Steffen Maier <maier@linux.ibm.com>
Date:   Tue, 23 Jul 2019 16:25:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563859682.2504.17.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072314-0008-0000-0000-00000300153F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072314-0009-0000-0000-0000226DA2A9
Message-Id: <1e05670d-9e28-1b1d-249d-743c736e6d63@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/19 7:28 AM, James Bottomley wrote:
> On Mon, 2019-07-22 at 19:42 -0700, Guenter Roeck wrote:
>> On 7/22/19 4:45 PM, James Bottomley wrote:
>>> [linux-scsi added to cc]
>>> On Mon, 2019-07-22 at 15:21 -0700, Guenter Roeck wrote:
>>>> On Sun, Jul 21, 2019 at 02:33:38PM -0700, Linus Torvalds wrote:
>>>>
>>>> [ ... ]
>>>>>
>>>>> Go test,
>>>>>
>>>>
>>>> Things looked pretty good until a few days ago. Unfortunately,
>>>> the last few days brought in a couple of issues.
>>>>
>>>> riscv:virt:defconfig:scsi[virtio]
>>>> riscv:virt:defconfig:scsi[virtio-pci]
>>>>
>>>> Boot tests crash with no useful backtrace. Bisect points to
>>>> merge ac60602a6d8f ("Merge tag 'dma-mapping-5.3-1'"). Log is at
>>>> https://kerneltests.org/builders/qemu-riscv64-master/builds/238/s
>>>> teps
>>>> /qemubuildcommand_1/logs/stdio
>>>>
>>>> ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112
>>>> ppc64:pseries:pseries_defconfig:sata-sii3112
>>>> ppc64:pseries:pseries_defconfig:little:sata-sii3112
>>>> ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112
>>>>
>>>> ata1: lost interrupt (Status 0x50)
>>>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>>>> ata1.00: failed command: READ DMA
>>>>
>>>> and many similar errors. Boot ultimately times out. Bisect points
>>>> to
>>>> merge
>>>> f65420df914a ("Merge tag 'scsi-fixes'").
>>>>
>>>> Logs:
>>>> https://kerneltests.org/builders/qemu-ppc64-master/builds/1212/st
>>>> eps/
>>>> qemubuildcommand/logs/stdio
>>>> https://kerneltests.org/builders/qemu-ppc-master/builds/1255/step
>>>> s/qe
>>>> mubuildcommand/logs/stdio
>>>>
>>>> Guenter
>>>>
>>>> ---
>>>> riscv bisect log
>>>>
>>>> # bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
>>>> # good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core:
>>>> take
>>>> the DMA max mapping size into account

>>>> # first bad commit: [ac60602a6d8f6830dee89f4b87ee005f62eb7171]
>>>> Merge
>>>> tag 'dma-mapping-5.3-1' of git://git.infradead.org/users/hch/dma-
>>>> mapping

>>> When a bisect lands on a merge commit it usually indicates bad
>>> interaction between two trees.  The way to find it is to do a
>>> bisect,
>>> but merge up to the other side of the scsi-fixes pull before
>>> running
>>> tests so the interaction is exposed in the bisect.
>>>
>>
>> Can you provide instructions for dummies ?
> 
> do a man git-bisect and then follow the 'Automatically bisect with
> temporary modifications' example.  You substitute
> 168c79971b4a7be7011e73bf488b740a8e1135c8 for hot-fix
> 
>>> However my money is on:
>>>
>>>
>>> commit bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
>>> Author: Christoph Hellwig <hch@lst.de>
>>> Date:   Mon Jun 17 14:19:54 2019 +0200
>>>
>>>       scsi: core: take the DMA max mapping size into account
>>>    
>>> Now that I look at the code again:
>>>
>>>
>>> +       shost->max_sectors = min_t(unsigned int, shost-
>>>> max_sectors,
>>> +                       dma_max_mapping_size(dev) << SECTOR_SHIFT);
>>>
>>> That shift looks to be the wrong way around (should be >>).  I bet
>>> something is giving a very large number which becomes zero on left
>>> shift, meaning max_sectors gets set to zero.
>>>
>>
>> That does indeed look bad, but changing it doesn't make a difference.
> 
> Odd, all the other changes are driver specific (and not in ATA) apart
> from this one:
> 
> commit 7ad388d8e4c703980b7018b938cdeec58832d78d
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Jun 17 14:19:53 2019 +0200
> 
>      scsi: core: add a host / host template field for the virt boundary
> 
> 
> I suppose it could be because the virt_boundary_mask isn't set, but
> that should just set zero, which is what block usually does.

I found max_segment_size unexpectedly to be UINT_MAX with zfcp today in our CI. 
My investigations are still very early, but I thought, I share a few thoughts 
as I'm way too unfamiliar with the DMA business and thus hope for help.

Above commit introduced an unconditional call to blk_queue_virt_boundary(q, 
shost->virt_boundary_mask), _after_ blk_queue_max_segment_size(q, 
shost->max_segment_size).

Looking at the source, dma_set_max_seg_size() seems to unconditionally 
overwrite max_segment_size:

> /**
>  * blk_queue_virt_boundary - set boundary rules for bio merging
>  * @q:  the request queue for the device
>  * @mask:  the memory boundary mask
>  **/
> void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
> {
> 	q->limits.virt_boundary_mask = mask;
> 
> 	/*
> 	 * Devices that require a virtual boundary do not support scatter/gather
> 	 * I/O natively, but instead require a descriptor list entry for each
> 	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
> 	 * of that they are not limited by our notion of "segment size".
> 	 */
> 	q->limits.max_segment_size = UINT_MAX;
> }
> EXPORT_SYMBOL(blk_queue_virt_boundary);

Wild guess: Do we need to make the call to blk_queue_virt_boundary() conditional?

Cf. https://www.spinics.net/lists/linux-scsi/msg131077.html ("[PATCH v2] iser: 
explicitly set shost max_segment_size if non virtual boundary devices")

-- 
Mit freundlichen Gruessen / Kind regards
Steffen Maier

Linux on IBM Z Development

https://www.ibm.com/privacy/us/en/
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

