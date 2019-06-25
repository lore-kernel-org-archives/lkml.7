Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E39C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5754120644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NbZj+VaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfFYLzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:55:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfFYLzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:55:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBsEOe023717;
        Tue, 25 Jun 2019 11:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zxia2UWTrmJ0NM6/vqz+FRPrAE1TVvsDKT1CuCbcN+8=;
 b=NbZj+VaA3xOyAc50835140CeawHoGO0Q6aQomi3NuCvOeuHg5Cohu2mChCsmH7G7Qvpf
 t5gUyMWOJjBLYbwPgz4FrZ1SYl2yjr1CNr1rPuPhQ7DpHR6zLof3ckDIdRTxd7FpfTID
 ty/m44yj0gE4hoUD5KutrfuRc4sv9BlnvzGSBSKp6gfUNhtccVnPXTjI9/V1ZPui6qZ4
 mwuuj7NpbrrAQspeSkf5+Q11QRLFcAswa+EmUqVDufhJb4pI0CW32i7d/tw4Mw/LgStf
 YX6lgzhpAy5oHa6A28Afg/M1q+uUc/VUrLxq93gOOUZ0h21VGK0wNUdJfHJhkCjaWiKO 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brt3wmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:55:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5PBtWDl056576;
        Tue, 25 Jun 2019 11:55:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acc2ew4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 11:55:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5PBtVps025151;
        Tue, 25 Jun 2019 11:55:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 04:55:29 -0700
Date:   Tue, 25 Jun 2019 14:55:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabian Krueger <fabian.krueger@fau.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Scheiderer <michael.scheiderer@fau.de>
Subject: Re: [PATCH 6/8] staging: kpc2000: introduce 'unsigned int'
Message-ID: <20190625115522.GC28859@kadam>
References: <20190625112725.10154-1-fabian.krueger@fau.de>
 <20190625112725.10154-7-fabian.krueger@fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625112725.10154-7-fabian.krueger@fau.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 01:27:17PM +0200, Fabian Krueger wrote:
> Replaced 'unsigned' with it's equivalent 'unsigned int' to reduce
> confusion while reading the code.
> 
> Signed-off-by: Fabian Krueger <fabian.krueger@fau.de>
> Signed-off-by: Michael Scheiderer <michael.scheiderer@fau.de>
> ---
>  drivers/staging/kpc2000/kpc2000_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
> index 79d7c44315e8..732254e9b261 100644
> --- a/drivers/staging/kpc2000/kpc2000_spi.c
> +++ b/drivers/staging/kpc2000/kpc2000_spi.c
> @@ -337,7 +337,7 @@ kp_spi_transfer_one_message(struct spi_master *master, struct spi_message *m)
>  	list_for_each_entry(transfer, &m->transfers, transfer_list) {
>  		const void *tx_buf = transfer->tx_buf;
>  		void       *rx_buf = transfer->rx_buf;
> -		unsigned    len = transfer->len;
> +		unsigned int   len = transfer->len;
                            ^^^^
This white space isn't correct.

regards,
dan carpenter

