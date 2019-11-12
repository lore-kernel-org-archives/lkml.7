Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7606CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471CD214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfKLOA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:00:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbfKLOA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:00:58 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACE0kV4125518
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:00:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7vwgb7aq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:00:52 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 12 Nov 2019 14:00:13 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 14:00:10 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACE092161145222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 14:00:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60425A4057;
        Tue, 12 Nov 2019 14:00:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF2D9A404D;
        Tue, 12 Nov 2019 14:00:07 +0000 (GMT)
Received: from [9.199.52.230] (unknown [9.199.52.230])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 14:00:07 +0000 (GMT)
Subject: Re: [PATCH v2] perf tool: Provide an option to print perf_event_open
 args and return value
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191108093024.27077-1-ravi.bangoria@linux.ibm.com>
 <20191108094128.28769-1-ravi.bangoria@linux.ibm.com>
 <20191108110009.GE18723@krava> <20191112112910.GK9365@kernel.org>
 <20191112113748.GL9365@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 12 Nov 2019 19:30:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112113748.GL9365@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111214-0028-0000-0000-000003B63D34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111214-0029-0000-0000-0000247940B3
Message-Id: <85a6a2a2-0aa0-ef71-d2e7-816013e5f80d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/12/19 5:07 PM, Arnaldo Carvalho de Melo wrote:
>> [root@quaco ~]# perf test -v python
>> 18: 'import perf' in python                               :
>> --- start ---
>> test child forked, pid 19237
>> Traceback (most recent call last):
>>    File "<stdin>", line 1, in <module>
>> ImportError: /tmp/build/perf/python/perf.so: undefined symbol: debug_peo_args
>> test child finished with -1
>> ---- end ----
>> 'import perf' in python: FAILED!
>> [root@quaco ~]#
>>
>> Please always test your changes using 'perf test', before and after, to
>> see if some regression is being added. I'm trying to fix this one.
> 
> I added this to fix this issue,

Sorry about that. Missed to run it. Will take care next time onwards.
Thanks for the fix.

-Ravi

