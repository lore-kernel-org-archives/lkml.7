Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E2FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FA720854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yaPyH6x3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCSJc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:32:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCSJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:32:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J9NkwT157652;
        Tue, 19 Mar 2019 09:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Hj1oBNh9dfc5D/uVx5TUhTCoSX2HTt+XaXsG30sxQQc=;
 b=yaPyH6x3R4HJD0+ey30v28sztfqxnSwDh5Bx1J/83Jf0kmyg4m9mzXZzUfLTB5Rdehn6
 4NQnIDQfMCiXGTRSy4zinCTrrRVxTANCsWcXljHK3jhTSuQTibwZcl3HotLu/e2FblgT
 3o7DEKcnKT1PtBHDSI60RdPhvMYZXr7PhdRkhp04V1S0UtKkf8VT9bTKTbBCPRgUqVO4
 vkvQKRgzmEoyHIMUFoL/tZ6dammDcVCwftlLKWRuXCRhF+mGmoYmHG7NuSosH1oicaAe
 puhVGR74lQGdNNZSFKYbae/IMUQs+LWxkFevlqAaYjZ/nEaeH+aYPd/HG8s9k3iMA7/j 7Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r8rjukgt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 09:32:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2J9WklZ030556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 09:32:46 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J9WkHq016793;
        Tue, 19 Mar 2019 09:32:46 GMT
Received: from kadam (/197.157.0.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 02:32:45 -0700
Date:   Tue, 19 Mar 2019 12:32:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 05/10] staging: rtl8723bs: Remove unreachable Code in
 core/rtw_cmd.c
Message-ID: <20190319093237.GO2227@kadam>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
 <20190317183115.32393-5-benniciemanuel78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317183115.32393-5-benniciemanuel78@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 07:31:08PM +0100, Emanuel Bennici wrote:
> The `case INTEl_WIDI_WK_CID`-Statement in Function `u8 rtw_drvextra_cmd_hdl`
> wouldn't be used because of CONFIG_INTEL_WIDI.
> 
> Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_cmd.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> index 91520ca3bbad..6c6ddf461590 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
> @@ -2007,11 +2007,6 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
>  	case CHECK_HIQ_WK_CID:
>  		rtw_chk_hi_queue_hdl(padapter);
>  		break;
> -#ifdef CONFIG_INTEL_WIDI
> -	case INTEl_WIDI_WK_CID:
> -		intel_widi_wk_hdl(padapter, pdrvextra_cmd->type, pdrvextra_cmd->pbuf);
> -		break;
> -#endif /* CONFIG_INTEL_WIDI */

Could you just remove all the CONFIG_INTEL_WIDI at once?  That would be
easier to review.

(I don't know where the other patches from this series are.  Maybe gmail
ate them).

regards,
dan carpenter

