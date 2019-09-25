Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D02C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65B4217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c7tkPZug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406768AbfIYHeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:34:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60180 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405579AbfIYHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:34:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P7XsZD066421;
        Wed, 25 Sep 2019 07:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=rnwCP+yK6Y5sSERIDmHzeGo5Z0sHmxxaolBxB7tcZAU=;
 b=c7tkPZugFIf2O8S5EGXfb2sPCZIjOXyeTb15qd24WMNfj6jeFkPCMsuPHK76VntD4X7q
 9sjBdUPgD0AQyNO9nmuIGKC5dRsJd8sKTxrolWp9pBkO57pzDWbGSqB8b7P4eXVOG6xN
 TyZtOkN5ztdM0V1J6mxMELDZRoYG6VN+WviPeGZqFsXK41T0h59dq0mAZXe2yy7c2ChC
 A00huwvjQj+fasZso/Jk/s7h8OdCnBQ+/tRMPfJ39Nota9C/Lijc03GZb3bCVSxpv1Lv
 DOHDArrEQQsfESnFmhEHGv4jA8inyWtuBiL5J0dzVynrnrTYE10rpSLLbV3J1jRFtP9h Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v5btq2t5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 07:34:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8P7Y3J5093490;
        Wed, 25 Sep 2019 07:34:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v7vnxeae8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 07:34:07 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8P7XS1M005149;
        Wed, 25 Sep 2019 07:33:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Sep 2019 00:33:28 -0700
Date:   Wed, 25 Sep 2019 10:33:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jerry Lin <wahahab11@gmail.com>
Cc:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: olpc_dcon: fix wrong dependencies in Kconfig
 file
Message-ID: <20190925073321.GB27389@kadam>
References: <20190925072533.GA18121@compute1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925072533.GA18121@compute1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 03:25:33PM +0800, Jerry Lin wrote:
> To allow simultaneous support for XO-1 and XO-1.5.
> This module require GPIO_CS5535 (for 1.0) and ACPI (for 1.5) now.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Jerry Lin <wahahab11@gmail.com>
> ---
>  drivers/staging/olpc_dcon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
> index 4ae271f..c2429e4 100644
> --- a/drivers/staging/olpc_dcon/Kconfig
> +++ b/drivers/staging/olpc_dcon/Kconfig
> @@ -3,7 +3,7 @@ config FB_OLPC_DCON
>  	tristate "One Laptop Per Child Display CONtroller support"
>  	depends on OLPC && FB
>  	depends on I2C
> -	depends on (GPIO_CS5535 || ACPI)
> +	depends on (GPIO_CS5535 && ACPI)

Please, remove the parentheses as well.

regards,
dan carpenter

