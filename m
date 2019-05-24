Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02F0C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8950F206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n9nTLIsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbfEXHEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:04:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41156 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfEXHEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:04:33 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O6xFKO001526;
        Fri, 24 May 2019 07:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fQH7QNMBskDMhw+9r7IsyO7ajPNTo8pdYGoJVhRHFJE=;
 b=n9nTLIsAkRwFqbdQ/X9aCYNUW3hRnA5/n5sYbVYpT6WLhYA6pl49rmnzUKOw+uehBKUv
 CvirWgW/mxh58IEhHMdhkjZIMu4MHG96TOtoEdks2RLq6d2GLQIaGgYyqILmu2OUOBJu
 Ii7JeUfONgLHwt1udOdZvOXiEeTH7R5CdsJfrDXhUGg+G21rbjP/h0qGZT9rG+bYiK5f
 olHhoUW6i6FX842if3Ka0JgBOe05UkQeWxVy85GgakpoTm1NeO0ywtJpzRDkuQttZhq5
 y4CYmMBeGeS12eEGroj2VoOH98HvNnRx9J9p79x/Uro6LNAUgyu3iTFs2QA6Lbitrmsl Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2smsk5q1px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 07:04:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4O73lsX095996;
        Fri, 24 May 2019 07:04:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2smsgvxq8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 07:04:17 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4O74FpU014669;
        Fri, 24 May 2019 07:04:15 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 May 2019 07:04:14 +0000
Date:   Fri, 24 May 2019 10:04:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, colin.king@canonical.com,
        herbert@gondor.apana.org.au, qader.aymen@gmail.com,
        sergio.paracuellos@gmail.com, bhanusreemahesh@gmail.com,
        mattmccoy110@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ks7010: Remove initialisation
Message-ID: <20190524070404.GV31203@kadam>
References: <20190524055238.3581-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524055238.3581-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905240048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9266 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905240048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:22:38AM +0530, Nishka Dasgupta wrote:
> The initial value of return variable ret is never used, so it can be
> removed.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index e089366ed02a..3775fd4b89ae 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -1067,7 +1067,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
>  	unsigned int length = 0;
>  	struct hostif_data_request *pp;
>  	unsigned char *p;
> -	int result = 0;
> +	int result;

You should get rid of the result variable completely and just use "ret"
instead.  No need for two variables.

regards,
dan carpenter

