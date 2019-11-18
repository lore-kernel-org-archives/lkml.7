Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC1C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8AA22309
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WDSqF+Tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfKRTDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:03:42 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfKRTDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:03:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIIx11A038796;
        Mon, 18 Nov 2019 19:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=i6LaNW7WMQqK56JkmDqqLpA59fZ3vDebVpzWRdgrgaw=;
 b=WDSqF+TpKiNH5FwTaRjglyihwZeFyW1/okhznb0TZ25WMAknb73+Ny8pmR9Q/yT4ytrn
 dP6uGl/VJjRqog7iKPPgcl1hnbpO+paYWZdXlzlJSt2soXRWdGE4tuUNSXyKIVyF4tHG
 9B1iXVHD4PdwpbcaPZVjen9DjA9won5pVjPa4l4RPkKEDtv8FS2isuteguTVcmZyvZsb
 CvvKnIdo3BPMGUNyvb+Ed8cSsqUBOieF93dtKF7txG5jMc6zGRGB+128YsAKFvb1Frdv
 dxMbBhZbPFGEYZDKEuY2obDDoG8+NU+qlnwzbRHssVrwLThJEY3u9Y6vVoJee4KMs7Wv 8w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2wa9rqa6cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 19:03:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIIwOQm106979;
        Mon, 18 Nov 2019 19:03:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wbxgb8ceu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 19:03:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIJ3Jlm016806;
        Mon, 18 Nov 2019 19:03:19 GMT
Received: from kadam (/41.210.141.115)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 11:03:18 -0800
Date:   Mon, 18 Nov 2019 22:01:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Giovanni Gherdovich <bobdc9664@seznam.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] staging: octeon: indent with tabs instead of spaces
Message-ID: <20191118190018.GA5604@kadam>
References: <20191118183852.3699-1-bobdc9664@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118183852.3699-1-bobdc9664@seznam.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=870
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=936 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 07:38:52PM +0100, Giovanni Gherdovich wrote:
> Remove a coding style error from the Octeon driver's tree and keep
> checkpatch.pl a little quieter.
> 
> Being a white-spaces patch the chances of breakage are minimal; we don't
> have the hardware to run this driver so we built it with COMPILE_TEST
> enabled on an x86 machine.

Next time put this sort of comment under the --- cut off line so that we
sound like we're bursting with confidence in the permanent git log.  ;)

> 
> Signed-off-by: Giovanni Gherdovich <bobdc9664@seznam.cz>
> ---
  ^^^

>  drivers/staging/octeon/octeon-stubs.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Anyway, looks good.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter
