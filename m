Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5157DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260C42083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDKFHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbfDKFHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:07:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3B501Pl036424
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:07:40 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rsvqhnnep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:07:39 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Thu, 11 Apr 2019 06:07:37 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 06:07:33 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B57W2B28901408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 05:07:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F1D7A4059;
        Thu, 11 Apr 2019 05:07:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B99C8A4040;
        Thu, 11 Apr 2019 05:07:30 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.73.26])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 05:07:30 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 06/15] powerpc/Kconfig: select PPC_MM_SLICES from subarch type
In-Reply-To: <87zhox3zjo.fsf@linux.ibm.com>
References: <cover.1554321743.git.christophe.leroy@c-s.fr> <2cd783f6975b126f024ee0965047342b6c36bded.1554321743.git.christophe.leroy@c-s.fr> <87zhox3zjo.fsf@linux.ibm.com>
Date:   Thu, 11 Apr 2019 10:37:29 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19041105-0012-0000-0000-0000030D9275
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041105-0013-0000-0000-00002145B8F6
Message-Id: <87tvf53zam.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> Lets select PPC_MM_SLICES from the subarch config item instead of
>> doing it via defaults declaration in the PPC_MM_SLICES item itself.
>>
>
> Did we miss the book3s 64 default y here?
>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/platforms/Kconfig.cputype | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
>> index 842b2c7e156a..a46a0adb634d 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -34,6 +34,7 @@ config PPC_8xx
>>  	bool "Freescale 8xx"
>>  	select FSL_SOC
>>  	select SYS_SUPPORTS_HUGETLBFS
>> +	select PPC_MM_SLICES if HUGETLB_PAGE
>>  
>>  config 40x
>>  	bool "AMCC 40x"
>> @@ -75,6 +76,7 @@ config PPC_BOOK3S_64
>>  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>>  	select ARCH_SUPPORTS_NUMA_BALANCING
>>  	select IRQ_WORK
>> +	select PPC_MM_SLICES


ok this takes care of BOOK3S_64.


>>  
>>  config PPC_BOOK3E_64
>>  	bool "Embedded processors"
>> @@ -360,8 +362,6 @@ config PPC_BOOK3E_MMU
>>  
>>  config PPC_MM_SLICES
>>  	bool
>> -	default y if PPC_BOOK3S_64
>> -	default y if PPC_8xx && HUGETLB_PAGE
>>  
>>  config PPC_HAVE_PMU_SUPPORT
>>         bool
>> -- 
>> 2.13.3

