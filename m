Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F7C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B786A208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q9aLYSX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfEVJmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:42:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53064 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfEVJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:42:00 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M9Xw2P182658;
        Wed, 22 May 2019 09:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=zZ+23WAC+xWeLYEUrAQqPhhuOmQueNCocAu2ZzFiRcc=;
 b=q9aLYSX5dxiLR/NzgCIqpiRXmIyc0PQ1bpm9535qagnRhzYBYji88yKNr/E8s93tux4q
 7A7NZ/fS3gik9VSm9fIEzJHnCEm0g+aJwCJesQy/MFH9YTVGxO3LhNRA60V/vsSVJKOh
 POKP/obvhrVhBpTl1JoGCfR9q5dcETPR+09YHHuZjAxb1dEz87vqKFUovdMXCH/YU/DB
 s21HTxUp1S94H8g/o22E/SZphnUQQ/J3/sYrhuYn639hWA4Po6IDiy0LtCtrLfM3W82U
 NNgiBKkIjKPbfVoPkyttQviZhv/uN9YyILygUlKdFLVoSV2uamfoDoOu7wvqnz+hG014 Lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2smsk5ahqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 09:41:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4M9fgmw146851;
        Wed, 22 May 2019 09:41:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2smsgurgmm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 May 2019 09:41:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4M9fcpC015233;
        Wed, 22 May 2019 09:41:38 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 May 2019 09:41:37 +0000
Date:   Wed, 22 May 2019 12:41:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Fabio Lima <fabiolima39@gmail.com>
Cc:     gregkh@linuxfoundation.org, jeremy@azazel.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: rtl8723bs: Add missing blank lines
Message-ID: <20190522094130.GS31203@kadam>
References: <20190522004655.20138-1-fabiolima39@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522004655.20138-1-fabiolima39@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905220070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905220070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 09:46:55PM -0300, Fabio Lima wrote:
> This patch resolves the following warning from checkpatch.pl
> WARNING: Missing a blank line after declarations
> 
> Signed-off-by: Fabio Lima <fabiolima39@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_debug.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
> index 9f8446ccf..853362381 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_debug.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
> @@ -382,6 +382,7 @@ ssize_t proc_set_roam_tgt_addr(struct file *file, const char __user *buffer, siz
>  	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
>  
>  		int num = sscanf(tmp, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", addr, addr+1, addr+2, addr+3, addr+4, addr+5);
> +
>  		if (num == 6)
>  			memcpy(adapter->mlmepriv.roam_tgt_addr, addr, ETH_ALEN);
>  

I'm sorry but this function is really such nonsense.  Can you send a
patch to re-write it instead?

drivers/staging/rtl8723bs/core/rtw_debug.c
   371  ssize_t proc_set_roam_tgt_addr(struct file *file, const char __user *buffer, size_t count, loff_t *pos, void *data)
   372  {
   373          struct net_device *dev = data;
   374          struct adapter *adapter = (struct adapter *)rtw_netdev_priv(dev);
   375  
   376          char tmp[32];
   377          u8 addr[ETH_ALEN];
   378  
   379          if (count < 1)

This check is silly.  I guess the safest thing is to change it to:
		if (count < sizeof(tmp))

   380                  return -EFAULT;

It should be return -EINVAL;

   381  
   382          if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {

Remove the check for if the user passes a NULL buffer, because that's
already handled in copy_from_user().  Return -EFAULT if copy_from_user()
fails.

	if (copy_from_user(tmp, buffer, sizeof(tmp)))
		return -EFAULT;


   383  

Extra blank line.

   384                  int num = sscanf(tmp, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", addr, addr+1, addr+2, addr+3, addr+4, addr+5);

You will need to move the num declaration to the start of the function.

   385                  if (num == 6)
   386                          memcpy(adapter->mlmepriv.roam_tgt_addr, addr, ETH_ALEN);

If num != 6 then return -EINVAL;

   387  
   388                  DBG_871X("set roam_tgt_addr to "MAC_FMT"\n", MAC_ARG(adapter->mlmepriv.roam_tgt_addr));
   389          }
   390  
   391          return count;
   392  }

regards,
dan carpenter
