Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC503ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFF920842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A5xDwPGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbfJANR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:17:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfJANR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:17:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91DDbdU191350;
        Tue, 1 Oct 2019 13:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=2CaoF5N6B1PLkCP4DaoWaEz16b+2iGGcswNGpgHzJMk=;
 b=A5xDwPGJAvWyON+A6egUaUghA6inUvt5JB/nWDXJXDZv4isjXeiXY0qCat2pbEZQCGZZ
 C6pjaKfUxYsGRHQlqynJ3EeZ/NV1+FP/C0rzOfRrHiUKIVha+zFoDfLjgXJ5JYmf6ayh
 CD+Qi0uWBgHeOlr5nimp+lbdf9YuvXR2GDvitsGwtztCIQhJBXI8mVal7IfMMF+BYeN2
 N46OP+O8SR4O2YWHHBqYs1581Z1JlptkkO9mdOBLcf0TqB4QVOXsXc40QFhe+4TrXdVV
 t+ADZhHbyNv3l+SfnGsnAs2KQJcEbM20p2SsNFQ7lFgsSuS97Mbu2PFJzzjS/zNyjQ1x lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v9yfq5r6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:17:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x91DDrq3130787;
        Tue, 1 Oct 2019 13:17:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vbmpyj7fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 13:17:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x91DHNC2031371;
        Tue, 1 Oct 2019 13:17:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 06:17:23 -0700
Date:   Tue, 1 Oct 2019 16:17:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Staging: exfat: exfat_super.c Fixed coding style
 issues.
Message-ID: <20191001131717.GD22609@kadam>
References: <20190929002119.20689-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929002119.20689-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 07:21:19PM -0500, Jesse Barton wrote:
> Fixed Coding Style issues

Which ones?

> 
> Signed-off-by: Jesse Barton <jessebarton95@gmail.com>
> ---
>  drivers/staging/exfat/exfat_super.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
> index 3c7e2b7c2195..b9656ec06144 100644
> --- a/drivers/staging/exfat/exfat_super.c
> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -640,8 +640,7 @@ static int ffs_lookup_file(struct inode *inode, char *path, struct file_id_t *fi
>  	return ret;
>  }
>  
> -static int ffs_create_file(struct inode *inode, char *path, u8 mode,
> -			 struct file_id_t *fid)
> +static int ffs_create_file(struct inode *inode, char *path, u8 mode, struct file_id_t *fid)

I think now checkpatch will complain that the line is too long?  What we
want here is:

static int ffs_create_file(struct inode *inode, char *path, u8 mode,
			   struct file_id_t *fid)

[tab][tab][tab][space][space][space]struct file_id_t *fid)

So they line up.

regards,
dan carpenter

