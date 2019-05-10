Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8EC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3819B2182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 03:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pSj6ssFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEJDXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 23:23:42 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:54330 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfEJDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 23:23:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4A3JaPV006206;
        Fri, 10 May 2019 03:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=O6+xUKWNdwz44CAQq1ERbOLEmB9+b7RfoaoWF0Y4mb4=;
 b=pSj6ssFmTMF0t++JKWjtBRHtNJMA2rBJU+LVRWnlHpXoKp3iJe+E1S3MSyXM0djK+hQU
 /7242BF/C2Sgi97mQ8ir35Uu1Fb43y9OH9Gu5q63CyXRxP0lkYDWk02jQp+ipzuaWVy8
 1e8ITbeidF+ZzZP5ux/N4k5B4mhqcUTfP7pz1F9VGqw/g6XI/v6ZfQgrwe2er3uQRujm
 KAZQHQVSRf66TnryE4p+pN8T+yXgbs4iIw1aOagQX25lkCVOpZCRdWDVfzvPklmgukj3
 b7F8pW577kwdEEL69OiYRViPbVxqAMNurKEdw8bu8ZaO8VuRqwVeprykGIX681slBzlq qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s94b6egx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 03:22:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4A3M0ca172871;
        Fri, 10 May 2019 03:22:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sagyvkj3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 03:22:36 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4A3MUSt000635;
        Fri, 10 May 2019 03:22:30 GMT
Received: from [10.191.28.74] (/10.191.28.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 May 2019 20:22:30 -0700
Subject: Re: [PATCH 2/2] doc: kernel-parameters.txt: fix documentation of
 nmi_watchdog parameter
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@linux.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        keescook@chromium.org, srinivas.eeda@oracle.com
References: <1555211464-28652-1-git-send-email-zhenzhong.duan@oracle.com>
 <1555211464-28652-2-git-send-email-zhenzhong.duan@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Organization: Oracle Corporation
Message-ID: <ca8971aa-7500-1067-fb4e-2dd03c806b86@oracle.com>
Date:   Fri, 10 May 2019 11:22:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555211464-28652-2-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905100021
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9252 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905100021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/14 11:11, Zhenzhong Duan wrote:
> As stated in "Documentation/lockup-watchdogs.txt:line 22", the default
> behaivor after 'hardlockup' is to stay locked up rather than panic.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90..fcc9579 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2769,7 +2769,7 @@
>   			0 - turn hardlockup detector in nmi_watchdog off
>   			1 - turn hardlockup detector in nmi_watchdog on
>   			When panic is specified, panic when an NMI watchdog
> -			timeout occurs (or 'nopanic' to override the opposite
> +			timeout occurs (or 'nopanic' which is the opposite
>   			default). To disable both hard and soft lockup detectors,
>   			please see 'nowatchdog'.
>   			This is useful when you use a panic=... timeout and

Hi Maintainers,

Any comment?


Thanks

Zhenzhong

