Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C947C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38359206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YjAyGKug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfDCQST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:18:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40928 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:18:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33G91Vk100645;
        Wed, 3 Apr 2019 16:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=QVl5eYPwopkaehqHCrcK6mby5arKdOv4jvTi5lGHwLg=;
 b=YjAyGKugB4QM8JSgH9+rTT6IziFWuOnbFFT9nVS/rc0DEGOaUKXulFSUZKgGZ4f0pDNM
 Y6juKW8f45ZOV/oDjA+BplzH4hRrWwIXhSY6sZhBagO8vzbbMzef/pk7z74pt60RouSu
 EXQ6CIZiUln3jJruhGyzx6bkTu0NZ6RcaIzSYlwcP36L/Qcn9IUZNFrzngUxcG5YolkG
 q2DJmPrCKhcwFijEfUzBfQLW9+lONbeprRoxW1ebCobE/91+gfSLf2tR9YNyUW0ZRMOf
 f/klOsxC7gUkgxtjXZaeouWa2K8up+GcHXRYL/uaJk1Ot5U6CleiQ24LA98whnvOfEdN jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2rhyvta452-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 16:18:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x33GIAin048519;
        Wed, 3 Apr 2019 16:18:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rm8f56gff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 16:18:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x33GIB62014579;
        Wed, 3 Apr 2019 16:18:13 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Apr 2019 09:18:11 -0700
Date:   Wed, 3 Apr 2019 19:18:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtlwifi: Remove unwanted parentheses
Message-ID: <20190403161803.GE32590@kadam>
References: <20190403160445.11110-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403160445.11110-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904030110
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904030110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 11:04:45AM -0500, Madhumitha Prabakaran wrote:
> Remove unwanted parentheses around right hand side of an assignment to
> make code better and more understandable.
> 
> Issue found by Coccinelle.
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/rtlwifi/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtlwifi/core.c b/drivers/staging/rtlwifi/core.c
> index a9902818ae7e..970343048b69 100644
> --- a/drivers/staging/rtlwifi/core.c
> +++ b/drivers/staging/rtlwifi/core.c
> @@ -341,8 +341,8 @@ static u16 crc16_ccitt(u8 data, u16 crc)
>  	u16 result;
>  
>  	for (i = 0; i < 8; i++) {
> -		crc_bit15 = ((crc & BIT(15)) ? 1 : 0);
> -		data_bit  = (data & (BIT(0) << i) ? 1 : 0);
> +		crc_bit15 = (crc & BIT(15)) ? 1 : 0;
> +		data_bit  = data & (BIT(0) << i) ? 1 : 0;

The original is obviously unhelpful, yes.  And the code works correctly,
true.  But my preferred format would be like this:

		data_bit  = (data & BIT(i)) ? 1 : 0;

Left shifting BIT() is silly.  But I like the extra parentheses around
the bitwise AND operation because that's a hard precedence to remember.

regards,
dan carpenter
