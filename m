Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8100AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0652083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="In7nvxLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfDJGuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:50:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49374 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfDJGuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:50:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A6moqY097803;
        Wed, 10 Apr 2019 06:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bZFFYFhrrsh/UZbJP3dI4wnvdJrP9QUJydMnRSFCeBk=;
 b=In7nvxLjpxlrRReLibscj9V1Osn4yhzbVTwdMexGJfG2A+xAIIJyhAyB/l7bR23uGm/O
 ZYOuGNQ7WGt1f2h60QYJ6cpbElSRO8KRlNfWn8kZnH4Nlx+scVtepAC0eoUDYwQs2JRV
 H21yL/nBg/bCUFiFvR3p79DEsWJHaNjFLfZm0dBOrcD4rHippVh1rYRcV7I+KqMYg3rx
 ACJjlZFI1MuIr9DIrQtt92eVqFiGJbSXe8TAsG0kDr7YRmvqUBaQUQCZfvsUiVdHk5Q0
 0a+DKeb+yt3DgswDbfYgOVz3gmOrPfU0yk8uvsbCjEQky4EHoVkQBAyfby3EIw5HpHNB tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2rphmeh9qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:50:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3A6nsuK132112;
        Wed, 10 Apr 2019 06:50:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2rpkejr0wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Apr 2019 06:50:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3A6o48t025789;
        Wed, 10 Apr 2019 06:50:04 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Apr 2019 23:50:03 -0700
Date:   Wed, 10 Apr 2019 09:49:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Remove typedef in struct sdio_data
Message-ID: <20190410064954.GE6095@kadam>
References: <20190409161617.29871-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409161617.29871-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904100049
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9222 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904100049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:16:17AM -0500, Madhumitha Prabakaran wrote:
> diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
> index bafb2c30e7fb..b0623c936940 100644
> --- a/drivers/staging/rtl8723bs/include/drv_types.h
> +++ b/drivers/staging/rtl8723bs/include/drv_types.h
> @@ -220,7 +220,7 @@ struct registry_priv
>  #define BSSID_SZ(field)   sizeof(((struct wlan_bssid_ex *) 0)->field)
>  
>  #include <drv_types_sdio.h>
> -#define INTF_DATA SDIO_DATA
> +#define INTF_DATA struct sdio_data
>  

Just get rid of INTF_DATA data as well.  It's only used once a bit lower
in the file.  (Get rid of the ifdef around it).

regards,
dan carpenter



