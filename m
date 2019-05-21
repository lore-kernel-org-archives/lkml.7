Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EFFC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3132208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mP1boTbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfEUPCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:02:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57302 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbfEUPCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:02:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LF1m6I087549;
        Tue, 21 May 2019 15:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vcLtAHq/nTW9Yr4n2tyGyq7/C1yAHMDyYIV67B4ge5M=;
 b=mP1boTbkaPg4Pg7WpNzllBau8SVyylI+z1Sty74BQMcfqMJnPdjAR2zGLYIUSYwFjM2T
 j02fQdhsgK5LtR4W9C0IhqLjELJ4z7h9V0kiM4SPWZhftu3azQccgMeFjgxy0l1kd5k4
 XOL8BMmaAcn4ncy2CvJsQfWzOm4po+HedslB8xd0KI7z8Xvd1DGnfvuXA585wcryzGCE
 ttgdp7K5mdO4rqglDH27XerVDuCij+HuAACzjmSTglGTccgRvOSc7rgRq/EAsmsJ0sDs
 Oyvdhr/BysiM/cZmjwCSVttoYIMEPkLQ/hFKU54lqvPuruM8GASLslXzrvUMbwBw5vGf kw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sj9fte2gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:02:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LF1UbY077208;
        Tue, 21 May 2019 15:02:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2sks1y8j2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:02:01 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LF20Fm002830;
        Tue, 21 May 2019 15:02:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 15:01:59 +0000
Date:   Tue, 21 May 2019 18:01:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] orangefs: remove redundant assignment to variable
 buffer_index
Message-ID: <20190521150152.GK31203@kadam>
References: <20190511132700.4862-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190511132700.4862-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 02:27:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable buffer_index is being initialized however this is never
> read and later it is being reassigned to a new value. The initialization
> is redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused Value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/orangefs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
> index a35c17017210..80f06ee794c5 100644
> --- a/fs/orangefs/file.c
> +++ b/fs/orangefs/file.c
> @@ -52,7 +52,7 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
>  	struct orangefs_inode_s *orangefs_inode = ORANGEFS_I(inode);
>  	struct orangefs_khandle *handle = &orangefs_inode->refn.khandle;
>  	struct orangefs_kernel_op_s *new_op = NULL;
> -	int buffer_index = -1;
> +	int buffer_index;
>  	ssize_t ret;
>  	size_t copy_amount;
>  

There is a second pointless assignment at the end of the function as
well:

   247  
   248          ret = new_op->downcall.resp.io.amt_complete;
   249  
   250  out:
   251          if (buffer_index >= 0) {
   252                  if ((readahead_size) && (type == ORANGEFS_IO_READ)) {
   253                          /* readpage */
   254                          *index_return = buffer_index;
   255                          gossip_debug(GOSSIP_FILE_DEBUG,
   256                                  "%s: hold on to buffer_index :%d:\n",
   257                                  __func__, buffer_index);
   258                  } else {
   259                          /* O_DIRECT */
   260                          orangefs_bufmap_put(buffer_index);
   261                          gossip_debug(GOSSIP_FILE_DEBUG,
   262                                  "%s(%pU): PUT buffer_index %d\n",
   263                                  __func__, handle, buffer_index);
   264                  }
   265                  buffer_index = -1;
                        ^^^^^^^^^^^^^^^^^

   266          }
   267          op_release(new_op);
   268          return ret;
   269  }

You often send these patches before they hit linux-next so I had skipped
reviewing this one when you sent it.  I'm coming back to work today
after the flu so I was going through my inbox reviewing old unread
messages...

regards,
dan carpenter
