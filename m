Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3208AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B7821951
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0M2R05t/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGZPGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:06:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43944 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfGZPGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:06:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QF491w082670;
        Fri, 26 Jul 2019 15:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 references : cc : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TyuezGjFNIBIK7D86zFS1Jtit2cGKoVDSzpMZXV1Hl8=;
 b=0M2R05t/4ciOKyQtMW3yPYFg+4ZvAIweE4GabWP0hy0zZ/BCPY0pvCJ4MrfqIWCMMN+/
 dhrzdfFlk1DehYdn2l5BeW+xKEYc2oowv4GP6PKTJgftNAFhtNmQguiS0m3UOAk4dJOk
 XFg7tr4spQ9nyB43KGRM6tQZDcUwnAgnH1uV7bVBJKqYmtAE5Lvo8EhFqPchiGtpa8Tv
 ai6ekOfvMMo5zVpzVm+Na3gK2pEWPDY4so2AhVkJNM3ZkEiqHxRSZ1lHi83C7ki8gqRt
 VQDT5blmi9i/wHyjQcoQMJaTpgg0pzCRxkF5DiOIOcnpxXz1xmAn8ftk6mXVhfQ+qtLE 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tx61cb03r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 15:06:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6QF32Zn061264;
        Fri, 26 Jul 2019 15:06:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tx60ygpt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 15:06:37 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6QF6a1S002217;
        Fri, 26 Jul 2019 15:06:36 GMT
Received: from [10.152.34.53] (/10.152.34.53)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Jul 2019 08:06:36 -0700
Subject: Re: LPC 2019 distros microconference proposal: "Distros and Syzkaller
 - Why bother?"
From:   George Kennedy <george.kennedy@oracle.com>
To:     linux-kernel@vger.kernel.org
References: <1ada9248-6406-1afb-2b37-a25a1c3d6e03@oracle.com>
Cc:     dhaval.giani@gmail.com
Organization: Oracle Corporation
Message-ID: <6d1a7a20-a420-7e3b-2dde-e924717012d9@oracle.com>
Date:   Fri, 26 Jul 2019 11:06:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1ada9248-6406-1afb-2b37-a25a1c3d6e03@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907260186
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9330 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ <dhaval.giani@gmail.com>

On 7/26/2019 10:48 AM, George Kennedy wrote:
> I have proposed "Distros and Syzkaller - Why bother?" for the LPC 2019 
> distros microconference.
>
> I am curious as to how other distros are using Syzkaller and if there 
> are ways for us to collaborate.
>
> I am curious how Syzkaller fits into the distro's development cycle, 
> release cycle and if it is part
> of the distro's Continuous Integration (CI) process?
>
> Any insights would be appreciated.
>
> Thank you,
> George Kennedy
>

