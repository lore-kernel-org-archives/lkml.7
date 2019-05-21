Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CB6C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A8D21479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BFTBWPYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfEUJnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:43:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfEUJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:43:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L9YI0C193001;
        Tue, 21 May 2019 09:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CV3K5vVj968rbCwHTWBpou4tQEBJWFpNs+IiANmFcHs=;
 b=BFTBWPYpwoS4xVmnzUqSvTh4pjcuOeoHhbsu63iYoeYogj5CLBo7IUbzAQDkavUt3g/b
 H0ObpMgpXWWTSoTDX7PB3o7aoNl3AEriyF8/FPf/LYmL6N/NtS6CGaY+VT90LJP3SCOx
 h1rmYTDfLzoufVCuOduA8CUGy4RPawyC06Y10cJuUZJv6S+IvfMjVMWQBsyn/pu//nRZ
 8ZzNIAsmshrGwmjWaatoGkPkQdBLq6aQwN+nC0HReEUWXXVlefL52Ff8C8i0lmga/oLS
 2b8wTYig5Nda0TzCY0yDB3mRXgsnCbJmIUxz4l9wycWoFiuZIzdicH/xx5tDVORmzv4g mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2sj9ftc70n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 09:42:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L9fd6W034592;
        Tue, 21 May 2019 09:42:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2sks1jbx6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 09:42:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4L9gbr9014313;
        Tue, 21 May 2019 09:42:37 GMT
Received: from [10.191.5.201] (/10.191.5.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 09:42:37 +0000
Subject: Re: [PATCH v2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com
References: <1557632127-16717-1-git-send-email-zhenzhong.duan@oracle.com>
 <20190514152113.336e6116@oasis.local.home>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <064f1230-be51-37ef-9283-69a7277fdd67@oracle.com>
Date:   Tue, 21 May 2019 17:42:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514152113.336e6116@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210062
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/5/15 3:21, Steven Rostedt wrote:
> On Sun, 12 May 2019 11:35:27 +0800
> Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
>
>> The default behavior of hardlockup depends on the config of
>> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.
>>
>> Fix the description of nmi_watchdog to make it clear.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
> Perhaps it should have been:
>
>   Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> As the wording is what I suggested ;-)

Sure, I should have done that. Just not familiar with which one is better.

Not clear if I should send a v3 adding Suggested-by and Acked-by?

Zhenzhong

>
> -- Steve
>
>> ---
>>   v2: fix description using words suggested by Steven Rostedt
>>
>>   Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 08df588..b9d4358 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2805,8 +2805,9 @@
>>   			0 - turn hardlockup detector in nmi_watchdog off
>>   			1 - turn hardlockup detector in nmi_watchdog on
>>   			When panic is specified, panic when an NMI watchdog
>> -			timeout occurs (or 'nopanic' to override the opposite
>> -			default). To disable both hard and soft lockup detectors,
>> +			timeout occurs (or 'nopanic' to not panic on an NMI
>> +			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
>> +			To disable both hard and soft lockup detectors,
>>   			please see 'nowatchdog'.
>>   			This is useful when you use a panic=... timeout and
>>   			need the box quickly up again.
