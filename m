Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4089C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48AA2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfDOMxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:53:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727243AbfDOMxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:53:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3FCkL1f122275
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 08:53:05 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rvqv1qeyd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 08:53:05 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pc@us.ibm.com>;
        Mon, 15 Apr 2019 13:53:04 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Apr 2019 13:53:01 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3FCr0Jl33161260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 12:53:00 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8888128067;
        Mon, 15 Apr 2019 12:53:00 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C67328066;
        Mon, 15 Apr 2019 12:53:00 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.41.247.5])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 15 Apr 2019 12:53:00 +0000 (GMT)
Subject: Re: perf tools:Is there any tools to found out the max latency by irq
 or cpu idle
To:     Linhaifeng <haifeng.lin@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <4099DE2E54AFAD489356C6C9161D53339591D64A@DGGEML502-MBX.china.huawei.com>
 <8ce8c596-123e-1342-5ccc-06a5fd8a60ec@redhat.com>
 <4099DE2E54AFAD489356C6C9161D53339591DE6D@DGGEML502-MBX.china.huawei.com>
From:   Paul Clarke <pc@us.ibm.com>
Date:   Mon, 15 Apr 2019 07:52:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4099DE2E54AFAD489356C6C9161D53339591DE6D@DGGEML502-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041512-0072-0000-0000-0000041A131A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010931; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189429; UDB=6.00623199; IPR=6.00970215;
 MB=3.00026451; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-15 12:53:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041512-0073-0000-0000-00004BD5AED0
Message-Id: <6e6a98a4-a442-1e10-cf5a-56b6792d42ba@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/19 1:01 AM, Linhaifeng wrote:
> Sorry, the value 131081408 is just for example. Actually the result is like this:
>  sqrt 2019-04-10 23:53:50: 43968
>  sqrt 2019-04-10 23:53:51: 44060
>  sqrt 2019-04-10 23:53:52: 49012
>  sqrt 2019-04-10 23:53:53: 38172
>  sqrt 2019-04-10 23:53:54: 131081408
>  sqrt 2019-04-10 23:53:55: 43600
>  sqrt 2019-04-10 23:53:56: 46704
>  sqrt 2019-04-10 23:53:57: 46880
>  sqrt 2019-04-10 23:53:58: 44332
>  ……
>  sqrt 2019-04-10 02:17:15: 136345876
>  ……
>  sqrt 2019-04-10 04:40:35: 136335644
>  ……

Given the periodicity, I'm wondering if it could be System Management Interrupts (SMIs)?

If so, some BIOSes have settings to mitigate, otherwise, there's not much that can be done, per my understanding.

PC

> -----Original Message-----
> From: William Cohen [mailto:wcohen@redhat.com] 
> Sent: 2019年4月12日 22:06
> To: Linhaifeng <haifeng.lin@huawei.com>; linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: perf tools:Is there any tools to found out the max latency by irq or cpu idle
> 
> On 4/11/19 8:57 PM, Linhaifeng wrote:
>> Hi,
>> I have a single thread application like this:
>>
>> While (1) {
>>     start = rdtsc();
>>     sqrt (1024);      
>> 　　end = rdtsc();
>> 　　cycles = end – start;
>> 　　printf("cycles: %d-%02d-%02d %02d:%02d:%02d: %lu\n", 
>> 　　　　　　1900+timeinfo->tm_year, 1+timeinfo->tm_mon, timeinfo->tm_mday, timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec,
>> 　　　　　　cycles);
>> }
>> It print the cycles of sqrt every second and run with taskset –c 1 ./sqrt.
>> The result of test is:
>>
>> sqrt 2019-04-10 23:53:50: 43968
>> sqrt 2019-04-10 23:53:51: 44060
>> sqrt 2019-04-10 23:53:52: 49012
>> sqrt 2019-04-10 23:53:53: 38172
>> sqrt 2019-04-10 23:53:54: 131081408
>> sqrt 2019-04-10 23:53:55: 43600
>> sqrt 2019-04-10 23:53:56: 46704
>> sqrt 2019-04-10 23:53:57: 46880
>> sqrt 2019-04-10 23:53:58: 44332
>> ……
>> sqrt 2019-04-10 02:17:15: 131081408
>> ……
>> sqrt 2019-04-10 04:40:35: 131081408
>> ……
>>
>> Every 2hour23min there would be a large cycles. I use perf sched not found any sched_switch events.
> 
> Hi,
> 
> The fact that it is the same value 131081408 every 2 hours 23 minutes looks suspect. One would expect some variation in the counts.  It looks like there is some rollover or overflow issue.  It would be helpful to print out the start and end values to see what is going on with the raw rdstc values.  Maybe the thread is being moved between processors and the TSC are out of sync.  What particular processor model was this running on? Was this running on physical hardware or inside a kvm guest? 
> 
> According to the Intel 64 and IA-32 Architecture Software Devloper's Manual Volume 3 (325384-sdm-vol-3abcd.pdf):
> 
> The RDTSC instruction reads the time-stamp counter and is guaranteed to return a monotonically increasing unique value whenever executed, except for a 64-bit counter wraparound. Intel guarantees that the time-stamp counter will not wraparound within 10 years after being reset. The period for counter wrap is longer for Pentium 4, Intel Xeon, P6 family, and Pentium processors.
> 
> -Will Cohen
> 
> 
>>
>> L2GW_2680:/home/fsp/zn # perf sched record -C 6-11 -o perf.sched ^C[ 
>> perf record: Woken up 64 times to write data ] [ perf record: Captured 
>> and wrote 204.878 MB perf.sched (1911189 samples) ]
>>
>> L2GW_2680:/home/fsp/zn # perf sched latency -i perf.sched
>>
>> ----------------------------------------------------------------------
>> -------------------------------------------
>>   Task                  |   Runtime ms  | Switches | Average delay ms 
>> | Maximum delay ms | Maximum delay at       |
>> ----------------------------------------------------------------------
>> -------------------------------------------
>> ----------------------------------------------------------------------
>> -------------------------------------------
>>   TOTAL:                |      0.000 ms |        0 |
>> ---------------------------------------------------
>>
>>
>>
>> Is there any other tools of perf to found out the max latency by irq or cpu idle ?
>>
>>
> 

