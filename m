Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B80C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D703214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfDWNhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:37:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727983AbfDWNhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:37:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NDV0fq099055
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:37:04 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s22febs05-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:37:04 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ldufour@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 14:37:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 14:36:58 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NDav3t34668690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 13:36:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD4134204D;
        Tue, 23 Apr 2019 13:36:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03C0142047;
        Tue, 23 Apr 2019 13:36:57 +0000 (GMT)
Received: from [9.145.7.116] (unknown [9.145.7.116])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 13:36:56 +0000 (GMT)
Subject: bos
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, rguenther@suse.de,
        mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, stable@vger.kernel.org
References: <20190401141549.3F4721FE@viggo.jf.intel.com>
 <alpine.DEB.2.21.1904191248090.3174@nanos.tec.linutronix.de>
 <87d0lht1c0.fsf@concordia.ellerman.id.au>
 <6718ede2-1fcb-1a8f-a116-250eef6416c7@linux.vnet.ibm.com>
 <alpine.DEB.2.21.1904231533190.9956@nanos.tec.linutronix.de>
From:   Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date:   Tue, 23 Apr 2019 15:36:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904231533190.9956@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19042313-0008-0000-0000-000002DCBE43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042313-0009-0000-0000-000022490F58
Message-Id: <4791a72f-901c-59cb-0553-5c32e26423f7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/04/2019 à 15:34, Thomas Gleixner a écrit :
> On Tue, 23 Apr 2019, Laurent Dufour wrote:
>> Le 20/04/2019 à 12:31, Michael Ellerman a écrit :
>>> Thomas Gleixner <tglx@linutronix.de> writes:
>>>> Aside of that the powerpc variant looks suspicious:
>>>>
>>>> static inline void arch_unmap(struct mm_struct *mm,
>>>>                                 unsigned long start, unsigned long end)
>>>> {
>>>>    	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
>>>>                   mm->context.vdso_base = 0;
>>>> }
>>>>
>>>> Shouldn't that be:
>>>>
>>>>    	if (start >= mm->context.vdso_base && mm->context.vdso_base < end)
>>>>
>>>> Hmm?
>>>
>>> Yeah looks pretty suspicious. I'll follow-up with Laurent who wrote it.
>>> Thanks for spotting it!
>>
>> I've to admit that I had to read that code carefully before answering.
>>
>> There are 2 assumptions here:
>>   1. 'start' and 'end' are page aligned (this is guaranteed by __do_munmap().
>>   2. the VDSO is 1 page (this is guaranteed by the union vdso_data_store on
>> powerpc).
>>
>> The idea is to handle a munmap() call surrounding the VDSO area:
>>        | VDSO |
>>   ^start         ^end
>>
>> This is covered by this test, as the munmap() matching the exact boundaries of
>> the VDSO is handled too.
>>
>> Am I missing something ?
> 
> Well if this is the intention, then you missed to add a comment explaining it :)
> 
> Thanks,
> 
> 	tglx

You're right, and I was thinking the same when I read that code this 
morning ;)

I'll propose a patch to a add an explicit comment.

Thanks,
Laurent.

