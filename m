Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70AC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F097208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 04:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2u2YMm9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfGBEit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 00:38:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39608 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfGBEis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 00:38:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x624XkMF095873;
        Tue, 2 Jul 2019 04:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=/2LHMY9wbAor8bZR0fN9L8PLrX6qbsO7NNpH1UIpzQU=;
 b=2u2YMm9yy8nU9Tj9/2jKRysJLa0L214kwYtqOm702YTP9ieMWzyWFaTZLt1iNPcCxwK5
 LVb9NZ5W2K58B/Pk4X3UgbiRfUWwOztBOpBcCccttEFsozG4K7P8tgiM0sj+sg+i1N01
 oJKxHESsIu1+4Fp1MIVZEj1nsTJAsRL46RSD/anNvT3JMOKaA45oYAE9dwTf12iwtmIB
 yzi+CUqmAin56MKWNtpWpMgoeDAygYpfhtQjArH6aan1x0qIGHDQZoAgqCH29mZLsMe2
 cZJScYZEMhQKbSwpwS5xYDcXAR6Bc+cnDSe1Mej+ACaOU/n0+G2pJA6z691EkG3Mk+RM Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2te61e111w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 04:38:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x624bxdW124275;
        Tue, 2 Jul 2019 04:38:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tebqg98m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jul 2019 04:38:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x624c6Yr020828;
        Tue, 2 Jul 2019 04:38:06 GMT
Received: from [10.191.19.75] (/10.191.19.75)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 21:38:05 -0700
Subject: Re: [PATCH v3 3/4] Revert "xen: Introduce 'xen_nopv' to disable PV
 extensions for HVM guests."
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.co, jgross@suse.com, sstabellini@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
References: <1561947628-1147-1-git-send-email-zhenzhong.duan@oracle.com>
 <1561947628-1147-4-git-send-email-zhenzhong.duan@oracle.com>
 <20190702034818.GB8003@bostrovs-us.us.oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <454f55e9-176c-2ac0-8422-09811f80cdde@oracle.com>
Date:   Tue, 2 Jul 2019 12:38:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702034818.GB8003@bostrovs-us.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907020048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/2 11:48, Boris Ostrovsky wrote:
> On Mon, Jul 01, 2019 at 10:20:27AM +0800, Zhenzhong Duan wrote:
>> This reverts commit 8d693b911bb9c57009c24cb1772d205b84c7985c.
>>
>> Instead we use an unified parameter 'nopv' for all the hypervisor
>> platforms.
>>
>> Signed-off-by: Zhenzhong Duan<zhenzhong.duan@oracle.com>
>> Reviewed-by: Juergen Gross<jgross@suse.com>
>> Cc: Boris Ostrovsky<boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross<jgross@suse.com>
>> Cc: Stefano Stabellini<sstabellini@kernel.org>
>> Cc: Thomas Gleixner<tglx@linutronix.de>
>> Cc: Ingo Molnar<mingo@redhat.com>
>> Cc: Borislav Petkov<bp@alien8.de>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  4 ----
>>   arch/x86/xen/enlighten_hvm.c                    | 12 +-----------
>>   2 files changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 21e08af..d5c3dcc 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5251,10 +5251,6 @@
>>   			Disables the ticketlock slowpath using Xen PV
>>   			optimizations.
>>   
>> -	xen_nopv	[X86]
>> -			Disables the PV optimizations forcing the HVM guest to
>> -			run as generic HVM guest with no PV drivers.
>> -
> So someone upgrades the kernel and suddenly things work differently?
>
> At least there should be a warning that the option has been replaced
> with 'nopv' (but I would actually keep this option working as well).

OK, I'll add new patch to map xen_nopv to nopv. So if 'xen_nopv' is 
used, we go

to the path for 'nopv'. I will be same effect.

Thanks

Zhenzhong

