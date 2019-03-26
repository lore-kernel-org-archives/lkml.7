Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA063C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA23420866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YTxdSEI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfCZImt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:42:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41128 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbfCZIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:42:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q8Xs9U146552;
        Tue, 26 Mar 2019 08:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6Zh8IShO7F9+5MLAstnm3abgMRPLgLvouf0CsK0OHNQ=;
 b=YTxdSEI4YQhFP7CtXQ+f5CKTxeO0Pr1KctzkesdjfwoeOt2ZJzPCIPpWIjrAQYABQ4Y4
 IT1aCyto/cHAElnPoex5U4i5v6U5jpVTj1+vY110tZmpSNJ7gSiFjftDRGi9t0sgJMAG
 n9hSsRaJtZK+6MHC/UU4CH2YYchcKOO57USRiLAvMTAUGbKQFKTPih2dbihL9psAo4Gy
 QEj88a6nqEZ8DnXjRizi4Wx3WWz0gXi/gRjCMxoBjQWFK6Mn2sps/T8cOMY4EJ2vqE9k
 mLG/owWxUttio7s7vmFzoyFv0hvbY/v6/NZjJt7C9KRGAA+JfjkiKiyNt+2OV2jrw9Ym Tw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2re6g10vta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:42:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8ggV3017853
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 08:42:43 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q8gg2I025653;
        Tue, 26 Mar 2019 08:42:42 GMT
Received: from kadam (/197.157.0.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Mar 2019 01:42:41 -0700
Date:   Tue, 26 Mar 2019 11:42:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "William J. Cunningham" <wjcunningham7@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20190326084233.GB32590@kadam>
References: <20190323171738.GA26736@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323171738.GA26736@titus.pi.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=914 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 01:17:38PM -0400, William J. Cunningham wrote:
> >From bb04b0ca982b7042902fffe1377e0e38e83b402b Mon Sep 17 00:00:00 2001
> From: Will Cunningham <wjcunningham7@gmail.com>
> Date: Sat, 23 Mar 2019 12:54:34 -0400
> Subject: [PATCH] Staging: emxx_udc: emxx_udc: Fixed a coding style error
> 
> Removed unnecessary parentheses.
> 
> Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>

Please fix up the headers and resend.

regards,
dan carpenter

