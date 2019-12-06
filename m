Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97ABDC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7919D24673
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 19:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfLFTTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 14:19:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbfLFTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:19:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6JHM1r093045
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 14:19:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq9hp9f7q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:19:41 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Fri, 6 Dec 2019 19:19:39 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 19:19:37 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6JIteD37355782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 19:18:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 454AA4204C;
        Fri,  6 Dec 2019 19:19:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ABEB4203F;
        Fri,  6 Dec 2019 19:19:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.71.21])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 19:19:34 +0000 (GMT)
Subject: Re: [PATCH v4 6/6] powerpc/fadump: sysfs for fadump memory
 reservation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20191206122434.29587-1-sourabhjain@linux.ibm.com>
 <20191206122434.29587-7-sourabhjain@linux.ibm.com>
 <20191206124855.GE1360047@kroah.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
Date:   Sat, 7 Dec 2019 00:49:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191206124855.GE1360047@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120619-0008-0000-0000-0000033E5B24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120619-0009-0000-0000-00004A5D8348
Message-Id: <dd95f01f-791d-6c6c-e4f5-5824939e01a2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_06:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 6:18 PM, Greg KH wrote:
> On Fri, Dec 06, 2019 at 05:54:34PM +0530, Sourabh Jain wrote:
>> Add a sys interface to allow querying the memory reserved by FADump for
>> saving the crash dump.
>>
>> Also added Documentation/ABI for the new sysfs file.
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>  Documentation/ABI/testing/sysfs-kernel-fadump    |  7 +++++++
>>  Documentation/powerpc/firmware-assisted-dump.rst |  5 +++++
>>  arch/powerpc/kernel/fadump.c                     | 15 +++++++++++++++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-fadump b/Documentation/ABI/testing/sysfs-kernel-fadump
>> index 5d988b919e81..8f7a64a81783 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-fadump
>> +++ b/Documentation/ABI/testing/sysfs-kernel-fadump
>> @@ -31,3 +31,10 @@ Description:	write only
>>  		the system is booted to capture the vmcore using FADump.
>>  		It is used to release the memory reserved by FADump to
>>  		save the crash dump.
>> +
>> +What:		/sys/kernel/fadump/mem_reserved
>> +Date:		Dec 2019
>> +Contact:	linuxppc-dev@lists.ozlabs.org
>> +Description:	read only
>> +		Provide information about the amount of memory reserved by
>> +		FADump to save the crash dump in bytes.
>> diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
>> index 365c10209ef3..04993eaf3113 100644
>> --- a/Documentation/powerpc/firmware-assisted-dump.rst
>> +++ b/Documentation/powerpc/firmware-assisted-dump.rst
>> @@ -268,6 +268,11 @@ Here is the list of files under kernel sysfs:
>>      be handled and vmcore will not be captured. This interface can be
>>      easily integrated with kdump service start/stop.
>>  
>> + /sys/kernel/fadump/mem_reserved
>> +
>> +   This is used to display the memory reserved by FADump for saving the
>> +   crash dump.
>> +
>>   /sys/kernel/fadump_release_mem
>>      This file is available only when FADump is active during
>>      second kernel. This is used to release the reserved memory
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 41a3cda81791..b2af51b7c750 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -1357,6 +1357,13 @@ static ssize_t fadump_enabled_show(struct kobject *kobj,
>>  	return sprintf(buf, "%d\n", fw_dump.fadump_enabled);
>>  }
>>  
>> +static ssize_t fadump_mem_reserved_show(struct kobject *kobj,
>> +					struct kobj_attribute *attr,
>> +					char *buf)
>> +{
>> +	return sprintf(buf, "%ld\n", fw_dump.reserve_dump_area_size);
>> +}
>> +
>>  static ssize_t fadump_register_show(struct kobject *kobj,
>>  					struct kobj_attribute *attr,
>>  					char *buf)
>> @@ -1430,6 +1437,10 @@ static struct kobj_attribute enable_attr = __ATTR(enabled,
>>  static struct kobj_attribute register_attr = __ATTR(registered,
>>  						0644, fadump_register_show,
>>  						fadump_register_store);
>> +static struct kobj_attribute mem_reserved_attr = __ATTR(mem_reserved,
>> +						0444, fadump_mem_reserved_show,
>> +						NULL);
> 
> __ATTRI_RO()?
> 
>> +
>>  
>>  DEFINE_SHOW_ATTRIBUTE(fadump_region);
>>  
>> @@ -1464,6 +1475,10 @@ static void fadump_init_files(void)
>>  			pr_err("unable to create release_mem sysfs file (%d)\n",
>>  			       rc);
>>  	}
>> +	rc = sysfs_create_file(fadump_kobj, &mem_reserved_attr.attr);
>> +	if (rc)
>> +		pr_err("unable to create mem_reserved sysfs file (%d)\n",
>> +		       rc);
> 
> Again, put it in an attribute group, that would have only required one
> line, and not this mess of not cleaning up if something went wrong.


Will make the changes accordingly.


Thanks,
Sourabh Jain

