Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F5C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09C520651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vxtR2YjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfGQCKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:10:30 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48356 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfGQCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:10:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H28cCW063748;
        Wed, 17 Jul 2019 02:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=k6OoYDpDJSEgTlR5RU9Uko7N/wO/kkXQFXDYsd2fX68=;
 b=vxtR2YjGDMFfmCHNO5nY20srytuCTUahocLUmfg0L1yyjNBY0OIjy2FX580hfDkE0UC9
 ycAkTN7wl7DGD031V374WGZbONFC/8FAaB2QK4vIWIbG5BiElVSMq6W2Ll4sJMciEyNM
 /bcI1N2eF/nUHR24KNEkmbXsnXMkXOXPKHMCb5XKSLuky/c/s3AhrmYWa5PmOjCIeZOy
 NnevOXgdkSkYptgJCHAGgljJnLEHyFeE4mAay6fsNiRKQCWz7EQaxiGpGWs37ZBkZ4Qa
 VXOJi9a5NnxMADX0x/WlUyC0sTtGmXYMiTa2BV4gTxC1F6Ijip0f2Tk3iixaYy2rZUj2 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtqtkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:09:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H27n7Y037839;
        Wed, 17 Jul 2019 02:09:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tsmcc4suj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:09:35 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H29Ytv014962;
        Wed, 17 Jul 2019 02:09:34 GMT
Received: from [192.168.0.8] (/116.136.20.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 02:09:33 +0000
Subject: Re: [PATCH v7 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, sstabellini@kernel.org, tglx@linutronix.de,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        mingo@redhat.com
References: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
 <1562846532-32152-5-git-send-email-zhenzhong.duan@oracle.com>
 <2433589d-a2d2-6b51-cfbd-c1141014ab93@suse.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <67261f6e-5dce-2452-a6d6-aa6ca73dfeec@oracle.com>
Date:   Wed, 17 Jul 2019 10:09:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2433589d-a2d2-6b51-cfbd-c1141014ab93@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/7/16 18:57, Juergen Gross wrote:
> On 11.07.19 14:02, Zhenzhong Duan wrote:
>> .. as "nopv" support needs it to be changeable at boot up stage.
>>
>> Checkpatch report warning, so move variable declarations from
>> hypervisor.c to hypervisor.h
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> ---
>>   arch/x86/include/asm/hypervisor.h | 8 ++++++++
>>   arch/x86/kernel/cpu/hypervisor.c  | 8 --------
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/hypervisor.h 
>> b/arch/x86/include/asm/hypervisor.h
>> index f7b4c53..e41cbf2 100644
>> --- a/arch/x86/include/asm/hypervisor.h
>> +++ b/arch/x86/include/asm/hypervisor.h
>> @@ -58,6 +58,14 @@ struct hypervisor_x86 {
>>       bool ignore_nopv;
>>   };
>>   +extern const struct hypervisor_x86 x86_hyper_vmware;
>> +extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
>> +extern const struct hypervisor_x86 x86_hyper_xen_pv;
>> +extern const struct hypervisor_x86 x86_hyper_kvm;
>> +extern const struct hypervisor_x86 x86_hyper_jailhouse;
>> +extern const struct hypervisor_x86 x86_hyper_acrn;
>> +extern struct hypervisor_x86 x86_hyper_xen_hvm;
>
> This should either stay const and be changed in patch 5, or you
> should adapt its definition in arch/x86/xen/enlighten_hvm.c in
> this patch.

Ok, thanks for your suggestion.

I'll choose 2nd opinion as I don't need to change descripton with that.

Zhenzhong

