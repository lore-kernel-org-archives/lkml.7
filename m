Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68463C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5B8223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbfGWQqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:46:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730010AbfGWQqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:46:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NGhGTs122208
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:46:21 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tx60rr46d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:46:21 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maier@linux.ibm.com>;
        Tue, 23 Jul 2019 17:46:19 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Jul 2019 17:46:17 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6NGk19Q32244062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jul 2019 16:46:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FEAA11C052;
        Tue, 23 Jul 2019 16:46:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCEB111C04C;
        Tue, 23 Jul 2019 16:46:15 +0000 (GMT)
Received: from oc4120165700.ibm.com (unknown [9.152.96.145])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jul 2019 16:46:15 +0000 (GMT)
Subject: Re: Linux 5.3-rc1
To:     Guenter Roeck <linux@roeck-us.net>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <1563839144.2504.5.camel@HansenPartnership.com>
 <4dc6ef77-afce-1c6d-add3-8df76332e672@roeck-us.net>
 <1563859682.2504.17.camel@HansenPartnership.com>
 <1e05670d-9e28-1b1d-249d-743c736e6d63@linux.ibm.com>
 <1563895995.3609.10.camel@HansenPartnership.com>
 <20190723161918.GB9140@roeck-us.net>
From:   Steffen Maier <maier@linux.ibm.com>
Date:   Tue, 23 Jul 2019 18:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723161918.GB9140@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072316-0016-0000-0000-0000029577A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072316-0017-0000-0000-000032F36903
Message-Id: <f8f135a8-62ea-fb8b-339f-2fce8024ee1b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907230168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/19 6:19 PM, Guenter Roeck wrote:
> On Tue, Jul 23, 2019 at 08:33:15AM -0700, James Bottomley wrote:
> [ ... ]
>>
>> Yes, I think so.  Can someone try this, or something like it.
>>
>> Thanks,
>>
>> James
>>
>> ---
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 9381171c2fc0..4715671a1537 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1793,7 +1793,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>>   	dma_set_seg_boundary(dev, shost->dma_boundary);
>>   
>>   	blk_queue_max_segment_size(q, shost->max_segment_size);
>> -	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
>> +	if (shost->virt_boundary_mask)
>> +		blk_queue_virt_boundary(q, shost->virt_boundary_mask);
>>   	dma_set_max_seg_size(dev, queue_max_segment_size(q));
>>   
>>   	/*
> 
> This fixes the problem for me.

+1
(on a first glimpse with zfcp)


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

