Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3442C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9FD20640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfIRITR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:19:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727337AbfIRITQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:19:16 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8I8Hbu7184748
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:19:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v3gj7rxa7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:19:14 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Wed, 18 Sep 2019 09:19:13 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 09:19:11 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8I8JApK36241542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 08:19:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ECF24C059;
        Wed, 18 Sep 2019 08:19:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0AF64C04E;
        Wed, 18 Sep 2019 08:19:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.138])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 08:19:08 +0000 (GMT)
Subject: Re: [PATCH v3] powerpc/fadump: sysfs for fadump memory reservation
To:     Hari Bathini <hbathini@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-doc@vger.kernel.org, mahesh@linux.vnet.ibm.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
References: <20190810175905.7761-1-sourabhjain@linux.ibm.com>
 <53311fa4-2cce-1eb6-1aae-0c835e06eb24@linux.ibm.com>
 <cf4fdb60-438c-bc4e-d759-1fbb27364c50@linux.ibm.com>
 <f53e4cfe-57cb-d8a6-385a-fa6243940573@linux.ibm.com>
 <f8e9cbdd-1926-081d-c8e6-f9d55408fe51@linux.ibm.com>
 <87sgpn2t2w.fsf@concordia.ellerman.id.au>
 <b3540b13-20f9-6995-831e-b7f88121fd1f@linux.ibm.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
Date:   Wed, 18 Sep 2019 13:49:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b3540b13-20f9-6995-831e-b7f88121fd1f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091808-0008-0000-0000-00000317D5C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091808-0009-0000-0000-00004A365650
Message-Id: <c9ce4153-c634-b336-6bf0-6b43b93f11b4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/19 11:32 AM, Hari Bathini wrote:
> 
> 
> On 27/08/19 8:49 AM, Michael Ellerman wrote:
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>>> On 26/08/19 4:14 PM, Sourabh Jain wrote:
>>>> On 8/26/19 3:46 PM, Sourabh Jain wrote:
>>>>> On 8/26/19 3:29 PM, Hari Bathini wrote:
>>>>>> On 10/08/19 11:29 PM, Sourabh Jain wrote:
>>>>>>> Add a sys interface to allow querying the memory reserved by
>>>>>>> fadump for saving the crash dump.
>>>>>>>
>>>>>>> Add an ABI doc entry for new sysfs interface.
>>>>>>>    - /sys/kernel/fadump_mem_reserved
>>>>>>>
>>>>>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>>>>> ---
>>>>>>> Changelog:
>>>>>>> v1 -> v2:
>>>>>>>   - Added ABI doc for new sysfs interface.
>>>>>>>
>>>>>>> v2 -> v3:
>>>>>>>   - Updated the ABI documentation.
>>>>>>> ---
>>>>>>>
>>>>>>>  Documentation/ABI/testing/sysfs-kernel-fadump    |  6 ++++++
>>>>>>
>>>>>> Shouldn't this be Documentation/ABI/testing/sysfs-kernel-fadump_mem_reserved?
>>>>
>>>> How about documenting fadump_mem_reserved and other sysfs attributes suggested
>>>> by you in a single file Documentation/ABI/testing/sysfs-kernel-fadump?
>>>
>>> I wouldn't mind that but please do check if it is breaking a convention..
>>
>> AIUI a file named like that would hold the documentation for the files
>> inside a directory called /sys/kernel/fadump.
>>
>> And in fact that's probably where these files should live, rather than
>> just dropped directly into /sys/kernel.
> Michael, could that be corrected now by introducing new sysfs files for FADump in
> /sys/kernel/fadump/.
> 
> Also, duplicating current /sys/kernel/fadump_* files as /sys/kernel/fadump/* files
> & eventually dropping /sys/kernel/fadump_* files sometime later..


Sent a patch series that adds fadump_mem_reserved sysfs file along with reorganizing
the existing fadump sysfs files.

Patch series available here:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2019-September/197100.html

- Sourabh Jain

