Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808B9C00302
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598962084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfKEIyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:54:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727925AbfKEIyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:54:11 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA58lxV8088836
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 03:54:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w34x32c28-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 03:54:10 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Tue, 5 Nov 2019 08:54:08 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Nov 2019 08:54:05 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA58s4Us57737256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Nov 2019 08:54:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30EE411C050;
        Tue,  5 Nov 2019 08:54:04 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D64F311C04A;
        Tue,  5 Nov 2019 08:54:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.160])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Nov 2019 08:54:02 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] Documentation/ABI: mark /sys/kernel/fadump_* sysfs
 files deprecated
To:     Hari Bathini <hbathini@linux.ibm.com>, mpe@ellerman.id.au
Cc:     corbet@lwn.net, mahesh@linux.vnet.ibm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
References: <20191018130557.2217-1-sourabhjain@linux.ibm.com>
 <20191018130557.2217-4-sourabhjain@linux.ibm.com>
 <f69daa7b-ddb3-8190-c409-28a22c504fed@linux.ibm.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
Date:   Tue, 5 Nov 2019 14:24:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f69daa7b-ddb3-8190-c409-28a22c504fed@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19110508-0012-0000-0000-00000360D22C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110508-0013-0000-0000-0000219C2A5F
Message-Id: <b1bc42cc-8d80-d104-b1b3-684c08531c78@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/19 1:11 PM, Hari Bathini wrote:
> 
> 
> On 18/10/19 6:35 PM, Sourabh Jain wrote:
>> The /sys/kernel/fadump_* sysfs files are replicated under
> 
> [...]
> 
>> +Note: The following FADump sysfs files are deprecated.
>> +
>> +    Deprecated                       Alternative
>> +    -------------------------------------------------------------------------------
>> +    /sys/kernel/fadump_enabled           /sys/kernel/fadump/fadump_enabled
>> +    /sys/kernel/fadump_registered        /sys/kernel/fadump/fadump_registered
>> +    /sys/kernel/fadump_release_mem       /sys/kernel/fadump/fadump_release_mem
> 
> /sys/kernel/fadump/* looks tidy instead of /sys/kernel/fadump/fadump_* 
> I mean, /sys/kernel/fadump/fadump_enabled => /sys/kernel/fadump/enabled and such..



Could you please confirm whether you want to address the sysfs file path differently or
actually changing the sysfs file name from fadump_enabled to enabled.

- Sourabh Jain

