Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8055C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C702173B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LF7vLq5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfE0HcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:32:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60148 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0HcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:32:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4R7Sp3Y025804;
        Mon, 27 May 2019 07:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=Dj/c4jygPsLOwoeXy2QzAi6Z5tucTz7dWZXb8pwrNIY=;
 b=LF7vLq5dVtLXBIjepZ2FjTaw9k6FsyFAt6nYbD4PYk91TIeK3SKmjHkpsZPS9FMEnVqf
 XMYbeBLruRwmwGqQGatmtQQqGq94j7rEpn9t3sq1MIvSLXTfiVik3Gtp4iA4n1sT5jG4
 6lyqraSaDRLj7mOwbWwGmbGJMmCVqKjyKbXLU3BLCSY49/5aM0jsOBBcNU9Tambk+mZP
 KCoJbrwrBDKlvv2BFOovdUAok0Cp1P6LDwusQy23uMnwS7r1Io6lbaoaWfDwL3Xyc13v
 fa3QlZv7LJ6FRcfQAi0hGSgDjiOHsfNMoGJdDGFMbE+UcDMwJkEuneJu9DK5KdC5f1FL 5g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2spw4t4p1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 07:32:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4R7VjON196133;
        Mon, 27 May 2019 07:32:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2srbdw844a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 May 2019 07:32:12 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4R7W6rb021727;
        Mon, 27 May 2019 07:32:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 May 2019 00:32:06 -0700
Date:   Mon, 27 May 2019 10:31:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] staging: kpc2000: add missing spaces in core.c
Message-ID: <20190527073159.GX31203@kadam>
References: <20190524110802.2953-1-simon@nikanor.nu>
 <20190524110802.2953-4-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190524110802.2953-4-simon@nikanor.nu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905270053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9269 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905270053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 01:08:01PM +0200, Simon Sandström wrote:
> Fixes checkpatch.pl errors "space required before the open brace '{'"
> and "(foo*)" should be "(foo *)".
> 
> Signed-off-by: Simon Sandström <simon@nikanor.nu>
> ---
>  drivers/staging/kpc2000/kpc2000/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc2000/kpc2000/core.c
> index 40f65f96986b..bb3b427a72b1 100644
> --- a/drivers/staging/kpc2000/kpc2000/core.c
> +++ b/drivers/staging/kpc2000/kpc2000/core.c
> @@ -308,7 +308,7 @@ static long kp2000_cdev_ioctl(struct file *filp, unsigned int ioctl_num,
>  
>  	dev_dbg(&pcard->pdev->dev, "kp2000_cdev_ioctl(filp = [%p], ioctl_num = 0x%08x, ioctl_param = 0x%016lx) pcard = [%p]\n", filp, ioctl_num, ioctl_param, pcard);
>  
> -	switch (ioctl_num){
> +	switch (ioctl_num) {
>  	case KP2000_IOCTL_GET_CPLD_REG:             return readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG);
>  	case KP2000_IOCTL_GET_PCIE_ERROR_REG:       return readq(pcard->sysinfo_regs_base + REG_PCIE_ERROR_COUNT);
>  
> @@ -326,7 +326,7 @@ static long kp2000_cdev_ioctl(struct file *filp, unsigned int ioctl_num,
>  		temp.ddna = pcard->ddna;
>  		temp.cpld_reg = readq(pcard->sysinfo_regs_base + REG_CPLD_CONFIG);
>  
> -		ret = copy_to_user((void*)ioctl_param, (void*)&temp, sizeof(temp));
> +		ret = copy_to_user((void *)ioctl_param, (void *)&temp, sizeof(temp));
>  		if (ret)
>  			return -EFAULT;

This should really be written like so:

		if (copy_to_user((void __user *)ioctl_param, &temp,
				 sizeof(temp)))
			return -EFAULT;

temp is really the wrong name.  "temp" is for temperatures.  "tmp" means
temporary.  But also "tmp" is wrong here because it's not a temporary
variable.  It's better to call it "regs" here.

regards,
dan carpenter

