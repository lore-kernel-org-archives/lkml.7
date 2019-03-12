Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE0720693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uLZ2ncDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCLPKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:10:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55168 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:10:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2CF9Nn5006061;
        Tue, 12 Mar 2019 15:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dNLOfNZyGmUSXXYjulawWH4f01+j/2C5vMRTLOM1Hag=;
 b=uLZ2ncDI978S6kt9OLk3uwXoYXUSvwDqvSa7+80aLDgAM0axgLMcSrF3koiS8jDJZ9zw
 YV2/PCUYwjWr8NTVQi8zTwwWAzdi8PSlqNTlj+jJzDIr+w+/tBDioJ9dFOlE73xyB9wU
 PWedWgHWXVvwTgDrJyGnPqv+VH6dito1jj0DwANLDPTpNwRHAl5frR8Sm86LtLUKP0Ok
 SYT9l6AGhUC8/reY6f41pjnRDmkrBeextoNi8A1/9bpJY7eDGXEL7jNVe8+Xt7KBeE/6
 UyXdbmZKTiM9NnZTQvGfIQHE/IDI3LrpF3YcBkoOn5jilMeDPx3Lhbl27qv1WwOhW2aG gg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r464rd89p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 15:10:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2CFAhrJ001908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 15:10:43 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2CFAg6U006242;
        Tue, 12 Mar 2019 15:10:43 GMT
Received: from kadam (/197.157.0.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 08:10:42 -0700
Date:   Tue, 12 Mar 2019 18:10:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Guilherme T Maeoka <gui.mspace@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Guilherme T Maeoka <gui.maeoka@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Staging: rtl8723bs: os_dep: Fix several coding style
 errors
Message-ID: <20190312151034.GA2202@kadam>
References: <20190312143914.4471-1-gui.mspace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312143914.4471-1-gui.mspace@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=991 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 11:39:13AM -0300, Guilherme T Maeoka wrote:
> From: Guilherme T Maeoka <gui.maeoka@gmail.com>
> 
> Fix coding style errors and warns complained by checkpatck.pl. To list:
> 
> 	- remove braces for single statements blocks,
> 	- add space required around operators,
> 	- replace spaces with tabs to indent,
> 	- add blank line after declarations,
> 	- fix braces and 'else' poistions in selection statements.
> 

I'm sorry you're going to have to break this up into multiple patches.
Probably one for each item on your list.

regards,
dan carpenter

