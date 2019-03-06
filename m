Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36750C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C588D206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8JwL2yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbfCFJoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:44:16 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:33388 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:44:16 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x269i5wd178554;
        Wed, 6 Mar 2019 09:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=Ta2O7DF2/9sJVKubh+k6nXiTfVoZACDiA2PHCH49IPI=;
 b=i8JwL2yVjtY3nbaJfOkHpuZZqqbEnDoZuL9jVH5TymH/qibTUUF760TmpB2LtVPk0AGH
 fIBrsOvPtWiyiV1tOqiSQslp3Zl5CaRF8ge0PT0BPI48moyolfqlQlFHwOROSu3GL1Rr
 kvxtOR09Ab5dz9smV9x/HjKT0s3ys3yOs4ffHxdCIGD/KUDW/dBXkLo5vYhBfXNe3Yzg
 bmxGuRNczS8MzmBmjqJ+1rYSTCbTk/NV88YuEoe8Ox7Hwi5F4MlgHyvzvnR9qxDnteUi
 1Q/+3wwZKDDBFk2JVdlAxZwKxOhV07j3nX9FOZc4nukP+Hm5CvLJk96k/8V/cwbU1zui fw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2qyfbeb11p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Mar 2019 09:44:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x269i7cm018805
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Mar 2019 09:44:08 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x269i6XL028425;
        Wed, 6 Mar 2019 09:44:06 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Mar 2019 01:44:06 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.2\))
Subject: Re: [PATCH] mm/filemap: fix minor typo
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190304155240.19215-1-ldufour@linux.ibm.com>
Date:   Wed, 6 Mar 2019 02:44:06 -0700
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D730117D-A44D-4380-8E58-E809A86BD245@oracle.com>
References: <20190304155240.19215-1-ldufour@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9186 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903060067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
> mm/filemap.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/filemap.c b/mm/filemap.c
> index cace3eb8069f..377cedaa3ae5 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1440,7 +1440,7 @@ pgoff_t page_cache_next_miss(struct =
address_space *mapping,
> EXPORT_SYMBOL(page_cache_next_miss);
>=20
> /**
> - * page_cache_prev_miss() - Find the next gap in the page cache.
> + * page_cache_prev_miss() - Find the previous gap in the page cache.
>  * @mapping: Mapping.
>  * @index: Index.
>  * @max_scan: Maximum range to search.
> --=20
> 2.21.0
>=20

Reviewed-by: William Kucharski <william.kucharski@oracle.com>
