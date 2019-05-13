Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1EBC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BAB21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 10:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lRjdIELE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfEMKti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 06:49:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35390 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfEMKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:49:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DAnTsU186490;
        Mon, 13 May 2019 10:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=2eb0nR7R6o6VwOIhmIYODzWz2Q8fnGjorIb+eHS2QGs=;
 b=lRjdIELEgyW8qAwDOew/Ghpe8/IdLNYe7dK4l2vNxbbGnw4ouDMUwS/rm8ZsJjYB/vpg
 S0zzDL6nldHY0f5GtWb9VYRPOm2aP/sA7uPvHRIdM2Xz1yB44rK9J6aTTkM2ZmQHFs7q
 Vz57ZrF6MOSc3QfMc2iiwSgBnK5fi5+tHBTHc+q2Ml+b9WlrSLb3R9AWbYAs8AgwvhwK
 s1s4E04ByD6BNaWmnKiKtze99vwDA2Qunjls87Zm6s9wrXisYBcSYR4vpcQikJnF1/hT
 wDyfsI+bsssJH46Td94q6cnbQsBk5nYuI7CMB0NUrmLhngnsZFI0RjC3cjBUCKmvqF5Q Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sdq1q5ya6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 10:49:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DAlrdH023834;
        Mon, 13 May 2019 10:49:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sdnqhvvcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 10:49:29 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4DAnSFb009867;
        Mon, 13 May 2019 10:49:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 May 2019 03:49:27 -0700
Date:   Mon, 13 May 2019 13:49:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vandana BN <bnvandana@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v3 1/8] Staging: kpc2000: kpc_dma: Resolve trailing
 whitespace error reported by checkpatch
Message-ID: <20190513104920.GI18105@kadam>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190513102622.22398-1-bnvandana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513102622.22398-1-bnvandana@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9255 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130078
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9255 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 03:56:15PM +0530, Vandana BN wrote:
> Resolve trailing whitespace error from checkpatch.pl
> ERROR: trailing whitespace
> ---
> v2-split changes to multiple patches
> v3 - edit commit message
> ---
> 
> Signed-off-by: Vandana BN <bnvandana@gmail.com>
> ---

The Signed off by has to be before the first --- cut off line.
Everything after the cut off is removed from the commit message.

>  drivers/staging/kpc2000/kpc_dma/dma.c         |  86 ++++++-------
>  drivers/staging/kpc2000/kpc_dma/fileops.c     | 114 +++++++++---------
>  .../staging/kpc2000/kpc_dma/kpc_dma_driver.c  |  46 +++----
>  .../staging/kpc2000/kpc_dma/kpc_dma_driver.h  |  16 +--
>  4 files changed, 131 insertions(+), 131 deletions(-)
> 


regards,
dan carpenter

