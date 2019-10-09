Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F5C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E495720B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bT7cxLKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfJIH5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:57:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57212 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJIH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:57:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x997sXBm124958;
        Wed, 9 Oct 2019 07:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=XgsFcT5hGVYVzo6YrFsEdxjWbLcz+YMz59J3P6pk7wk=;
 b=bT7cxLKOpJ5m1amur6Nq92dDZ3w1IY/IotFEQAKazmgDUG6lAFViWWQlZnBwbuK7OrFv
 T54xGbJyxb9OtYUqhi7imVpCh9sHg7rO7SVLZuDrecgrUY2RM20wR9NrbJsvzeDcDiO2
 Gp6JDJ3Cz0XLp4EFP55tQUtDe//zo6dEzr+eH1Yg3up8L81x+teX8V8BUqTZJM35h1bV
 8qhHD5rjCpLWsHCm6uM4az64972JidxnIcUevXcY5wLWB6SEg4sNEL0wlmTujPX/Adlt
 NldHVqBGGQoko3IqgWYrQYTrnKyJVWoS8cqGr3uLe4fCj31UhkeItatP+eYVeDz4Xo1n oA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vejkujcsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 07:57:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x997rEih158629;
        Wed, 9 Oct 2019 07:57:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vgev0s72h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 07:57:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x997v7JE009598;
        Wed, 9 Oct 2019 07:57:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 00:57:07 -0700
Date:   Wed, 9 Oct 2019 10:57:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        gneukum1@gmail.com, michael.scheiderer@fau.de,
        fabian.krueger@fau.de, linux-kernel@vger.kernel.org,
        simon@nikanor.nu
Subject: Re: [PATCH] KPC2000: kpc2000_spi.c: Fix alignment and style problems.
Message-ID: <20191009075700.GK25098@kadam>
References: <1570593039-19059-1-git-send-email-chandra627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570593039-19059-1-git-send-email-chandra627@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=924
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=998 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:50:39PM -0700, Chandra Annamaneni wrote:
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 3be33c4..a20f2d7 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -30,19 +30,27 @@
>  #include "kpc.h"
>  
>  static struct mtd_partition p2kr0_spi0_parts[] = {
> -	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
> -	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
> +	{ .name = "SLOT_0",	.size = 7798784,	.offset = 0,},
> +	{ .name = "SLOT_1",	.size = 7798784,	.offset =
> +							 MTDPART_OFS_NXTBLK},

This looks worse than the original code...  :(  You could maybe make it
a little bit tighter if you used space characters.

	{ .name = "SLOT_0",    .size = 7798784,		 .offset = 0,                },
	{ .name = "SLOT_1",    .size = 7798784,		 .offset = MTDPART_OFS_NXTBLK},
	{ .name = "SLOT_2",    .size = 7798784,		 .offset = MTDPART_OFS_NXTBLK},
	{ .name = "SLOT_3",    .size = 7798784,	         .offset = MTDPART_OFS_NXTBLK},
	{ .name = "CS0_EXTRA", .size = MTDPART_SIZ_FULL, .offset = MTDPART_OFS_NXTBLK},

It still goes over 80 characters, but that's okay.  Or we could just
leave the original code as is.

[ snip ]

>  static struct flash_platform_data p2kr0_spi1_pdata = {
>  	.name =		"SPI1",
>  	.nr_parts =	ARRAY_SIZE(p2kr0_spi1_parts),
> @@ -165,7 +174,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
>  	u64 val;
>  
>  	addr += idx;
> -	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0))
> +	if (idx == KP_SPI_REG_CONFIG && cs->conf_cache >= 0)

I like these changes but Greg doesn't.  So don't bother with this one.

>  		return cs->conf_cache;
>  
>  	val = readq(addr);

The rest of the changes are fine.  Split them into multiple patches and
resend.

regards,
dan carpenter

