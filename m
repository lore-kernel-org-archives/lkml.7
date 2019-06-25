Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CD8C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137A1214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hA5KM+UR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbfFYLxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:53:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60878 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbfFYLxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:53:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBiEhA023805;
        Tue, 25 Jun 2019 11:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=QS/FwtA7Qs3eEw01dKZNBc0EiiHhw6dRdKdRcwxdSCc=;
 b=hA5KM+URLhz4CXIkZipMXKSXWwR8UB+1zeMa+aU3c7z39J0w/8GNLCH5+ueSPz1VMgT7
 z11/gK2xUHIPJHPVsgx03GWUBKUQjqWmdrYgEZMMWbIW7KFLcBCrSpQvQevu+ows2zpB
 eRTNcsJJfc8DAvk/bL9X4vem+dtHpWncSEqTCV7+loinnQyX64sTMD8pTQ2a+8YAHA0x
 n7OByMjNvIK5Ltrj+QyUl8Hf+GZooHoQ9O9kGuhbDdBvxd5YcwpTg1jULwSnSVQnDjyj
 dYyklFj5Sjcu9zoWyc7L1Qhd/aJjK83y84XIhV1xche4nWw3O3QW24yYLyo/iTOnDpo5 BA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqbtg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:53:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBr5RS125808;
        Tue, 25 Jun 2019 11:53:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f3tyk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:53:06 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5PBr0qZ019970;
        Tue, 25 Jun 2019 11:53:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 04:52:59 -0700
Date:   Tue, 25 Jun 2019 14:52:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabian Krueger <fabian.krueger@fau.de>
Cc:     devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Scheiderer <michael.scheiderer@fau.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] staging: kpc2000: add line breaks
Message-ID: <20190625115251.GA28859@kadam>
References: <20190625112725.10154-1-fabian.krueger@fau.de>
 <20190625112725.10154-2-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625112725.10154-2-fabian.krueger@fau.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:27:12PM +0200, Fabian Krueger wrote:
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index c3e5c1848f53..7ed0fb6b4abb 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -30,18 +30,46 @@
>  #include "kpc.h"
>  
>  static struct mtd_partition p2kr0_spi0_parts[] = {
> -	{ .name = "SLOT_0",	.size = 7798784,		.offset = 0,                },
> -	{ .name = "SLOT_1",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_2",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "SLOT_3",	.size = 7798784,		.offset = MTDPART_OFS_NXTBLK},
> -	{ .name = "CS0_EXTRA",	.size = MTDPART_SIZ_FULL,	.offset = MTDPART_OFS_NXTBLK},
> +	{.name = "SLOT_0",
> +	 .size = 7798784,
> +	 .offset = 0,},
> +
> +	{.name = "SLOT_1",
> +	 .size = 7798784,
> +	 .offset = MTDPART_OFS_NXTBLK},
> +
> +	{.name = "SLOT_2",
> +	 .size = 7798784,
> +	 .offset = MTDPART_OFS_NXTBLK},
> +
> +	{.name = "SLOT_3",
> +	 .size = 7798784,
> +	 .offset = MTDPART_OFS_NXTBLK},
> +
> +	{.name = "CS0_EXTRA",
> +	 .size = MTDPART_SIZ_FULL,
> +	 .offset = MTDPART_OFS_NXTBLK},
>  };

The original is fine/better.

> @@ -215,7 +244,9 @@ kp_spi_txrx_pio(struct spi_device *spidev, struct spi_transfer *transfer)
>  		for (i = 0 ; i < c ; i++) {
>  			char val = *tx++;
>  
> -			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS, KP_SPI_REG_STATUS_TXS) < 0) {
> +			if (kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
> +						    KP_SPI_REG_STATUS_TXS)
> +			    < 0) {

I don't like how the < 0 is on the next line.  It would be better to
introduce an "int ret;"
			ret = kp_spi_wait_for_reg_bit(cs, KP_SPI_REG_STATUS,
						      KP_SPI_REG_STATUS_TXS);
			if (ret < 0)
				goto out;


>  				goto out;
>  			}
>  

> @@ -317,7 +353,8 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>  			dev_dbg(kpspi->dev, "  transfer -EINVAL\n");
>  			return -EINVAL;
>  		}
> -		if (transfer->speed_hz && (transfer->speed_hz < (KP_SPI_CLK >> 15))) {
> +		if (transfer->speed_hz && (transfer->speed_hz <
> +					   (KP_SPI_CLK >> 15))) {


Move the whole conition down:

		if (transfer->speed_hz &&
		    transfer->speed_hz < (KP_SPI_CLK >> 15)) {

regards,
dan carpenter

