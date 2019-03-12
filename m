Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B66C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E76F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WMOwULbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfCLN7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:59:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58466 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:59:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2CDvUmC124541;
        Tue, 12 Mar 2019 13:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4ZMOItDFTh1XM3CjXjtxCCu74z5TNsFK2Hx8PSjO5W0=;
 b=WMOwULbJ5OAaymHHf1NW2GtgBx4yNyJCUcPDMGKc7W7xcQ6lTU4jCjzV1RqZUfolZWOJ
 zxOWNVYcwgaOrvq6f0VXQdrwckLdOEl1W6gpGZGpL0Jthh2oIQxKUr/t+8d6B56QszWz
 vIfr1m4lUUyOjU0KrQ7qtrmW9nUOsTIWs4M3qQswori95BRSHtgx9Pzl/4Z2Ey3MNQ9v
 nQUp03TMuPu2QGEcj7+HwdkMqLQ+Zppg3RiV5dmvATZiN3YMeryt7HvBL4urGtycUu3d
 VHWYGEIGFAPx2L3T6HQdRV2QZ12NDEGVbuvM428cP5n0ss5ypMRWhB9G70XGSGg9MoPZ Gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r44wu4sgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 13:58:56 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2CDwtSQ010468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 13:58:55 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2CDwrSe025273;
        Tue, 12 Mar 2019 13:58:53 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 06:58:53 -0700
Subject: Re: [PATCH] mm: remove unused variable
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190312132852.20115-1-brgl@bgdev.pl>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <c86234af-a83a-712a-8dc8-0ec2a5dad103@oracle.com>
Date:   Tue, 12 Mar 2019 07:58:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312132852.20115-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/19 7:28 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> The mm variable is set but unused. Remove it.

It is used. Look further down for calls to set_pte_at().

--
Khalid

>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  mm/mprotect.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 028c724dcb1a..130dac3ad04f 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -39,7 +39,6 @@ static unsigned long change_pte_range(struct vm_area_=
struct *vma, pmd_t *pmd,
>  		unsigned long addr, unsigned long end, pgprot_t newprot,
>  		int dirty_accountable, int prot_numa)
>  {
> -	struct mm_struct *mm =3D vma->vm_mm;
>  	pte_t *pte, oldpte;
>  	spinlock_t *ptl;
>  	unsigned long pages =3D 0;
>=20


