Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DBCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB80E20578
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EV3csapz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfJ2SCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:02:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfJ2SCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:02:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9THmv00162095;
        Tue, 29 Oct 2019 18:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=ZFk4RYgrZI0f0ewy+MahA6aBxAaCaiu6liBC9GUFjz0=;
 b=EV3csapzGHJZpkvwhywzweBVuxTHrmv3zxWKpCwRGRTx/drJ7ruTmGvGIw68xjYitowE
 eXLH9Bfo8cyOOaxV9lcyfLE+92+0Qa5QzrhrBe26Qq5XmRB0CJbBpJ8XJoD1kJHWUiR8
 rd+LYewygwlNxPHglDVfh54n85NarmJK5sf+jirJ5OAuYYtevfw3Tk2j15eKk/1680wh
 gjoT9nJu3rOvlgDX1HZJ423o8tLagoGL/nEOy1ycjNDOiBWWOcavlLYREOfIX3X1WN0z
 VXDbZdmorKxm5pYxPAg/RgFM/aOIKURlfUWa1p7GbmPNIjBjFJuwCrKSG7RubG7X1gxa bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vvdjub5eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:01:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9THn8a3106010;
        Tue, 29 Oct 2019 17:59:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vxpenp3gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 17:59:58 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9THxvLp029160;
        Tue, 29 Oct 2019 17:59:57 GMT
Received: from dhcp-10-159-132-196.vpn.oracle.com (/10.159.132.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 10:59:57 -0700
Subject: Re: [PATCH -next] memory: emif: remove set but not used variables
 'cs1_used' and 'custom_configs'
To:     YueHaibing <yuehaibing@huawei.com>, ssantosh@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20191023135149.34704-1-yuehaibing@huawei.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <09afad3c-5612-141b-3824-f44c79a09f94@oracle.com>
Date:   Tue, 29 Oct 2019 10:59:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023135149.34704-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=862
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=964 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/19 6:51 AM, YueHaibing wrote:
> drivers/memory/emif.c:1616:9: warning:
>   variable cs1_used set but not used [-Wunused-but-set-variable]
> drivers/memory/emif.c:1624:36: warning:
>   variable custom_configs set but not used [-Wunused-but-set-variable]
> 
> They are never used since introduction.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
Applied
