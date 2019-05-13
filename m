Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07218C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAAE208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DHcA9Z32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfEMCpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:45:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43406 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbfEMCpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:45:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4D2hlBR011482;
        Mon, 13 May 2019 02:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=x0gnW+INC/YeTmeApouJTnXGIg6zn0tT5VaTPdxM56o=;
 b=DHcA9Z32aH0AOAGp1PFHjXTHiq00jun+G/JaB2j0BkvSUc+ZBZJkH1WlZ4RT8XDab85Y
 A/od1SEadzEDuLZMNKC52kgn7i90uGlfFKIMgvqpiehaFqTHh6Jqki1/6bdscLjK+elW
 lk5rlf/TO9/J3t66NhG6qh4Tr9xhezuj+zHbySbkEj5ASQg9C8nY3fG5jLhLGZjbVgdL
 52pQgrEPqmyFKEuFuMSSyYHsp0PSZTboNtSTa2fjLNKOqE8RtbSMzgXpYFNJAxKIZuCR
 /OoxUunO+bkKZFfVXGX+VDYIwPlVYz7NEADYPMHShShh1FjAq+71Zpql1JC18mKln4XV /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2sdq1q3xjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 02:44:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4D2i6HY096919;
        Mon, 13 May 2019 02:44:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2sep21u70f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 02:44:06 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4D2hsm3015121;
        Mon, 13 May 2019 02:43:54 GMT
Received: from [10.191.29.181] (/10.191.29.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 12 May 2019 19:43:54 -0700
Subject: Re: [PATCH 2/2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        paulmck@linux.ibm.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com
References: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
 <1555211464-28652-2-git-send-email-zhenzhong.duan@oracle.com>
 <20190510144749.592f4249@gandalf.local.home>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <88c81205-8b9d-5dae-95ba-ad115878ece9@oracle.com>
Date:   Mon, 13 May 2019 10:43:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510144749.592f4249@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9255 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130018
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9255 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2019/5/11 2:47, Steven Rostedt wrote:
> As nobody else commented, I will ;)
>
> Hi Zhenzhong!
>
> On Sun, 14 Apr 2019 11:11:04 +0800
> Zhenzhong Duan <zhenzhong.duan@oracle.com> wrote:
>
>> As stated in "Documentation/lockup-watchdogs.txt:line 22", the default
>> behaivor after 'hardlockup' is to stay locked up rather than panic.
> That actually says:
>
>   A 'hardlockup' is defined as a bug that causes the CPU to loop in
>   kernel mode for more than 10 seconds (see "Implementation" below for
>   details), without letting other interrupts have a chance to run.
>   Similarly to the softlockup case, the current stack trace is displayed
>   upon detection and the system will stay locked up unless the default
>   behavior is changed, which can be done through a sysctl,
>   'hardlockup_panic', a compile time knob, "BOOTPARAM_HARDLOCKUP_PANIC",
>   and a kernel parameter, "nmi_watchdog"
>
> If your config has:
>
>   CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
>
> The kernel will panic on hard lockup by default unless you add nopanic.
>
> If your config has:
>
>   # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
>
> Then the default will be not to panic unless you add "panic" to the
> kernel command line.
>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 2b8ee90..fcc9579 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2769,7 +2769,7 @@
>>   			0 - turn hardlockup detector in nmi_watchdog off
>>   			1 - turn hardlockup detector in nmi_watchdog on
>>   			When panic is specified, panic when an NMI watchdog
>> -			timeout occurs (or 'nopanic' to override the opposite
>> +			timeout occurs (or 'nopanic' which is the opposite
>>   			default). To disable both hard and soft lockup detectors,
> Honestly, I think the original text states what it does better than
> your update. Because the nopanic is added to override the "opposite
> default" which is if the config was set to do so.
>
> That said, this all still can be explained better. What about:
>
>          nmi_watchdog=   [KNL,BUGS=X86] Debugging features for SMP kernels
>                          Format: [panic,][nopanic,][num]
>                          Valid num: 0 or 1
>                          0 - turn hardlockup detector in nmi_watchdog off
>                          1 - turn hardlockup detector in nmi_watchdog on
>                          When panic is specified, panic when an NMI watchdog
>                          timeout occurs (or 'nopanic' to not panic on an NMI
> 			watchdog, if CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is set)
>                          To disable both hard and soft lockup detectors,
>                          please see 'nowatchdog'.
>                          This is useful when you use a panic=... timeout and
>                          need the box quickly up again.

Thanks Seeve for your comments, so the default behavior of hardlockup 
depends on the setting of CONFIG_BOOTPARAM_HARDLOCKUP_PANIC.

It did confused me previously. You suggested fix is better, I'll fix it 
later.


Zhenzhong

