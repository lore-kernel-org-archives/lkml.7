Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922A0C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C60A20825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M2f07Et4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfDONeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:34:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56194 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfDONeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:34:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FDY1Sm107265;
        Mon, 15 Apr 2019 13:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=cuT7jisv3fATtTHhvZF5cChcLoP2kJua7V5PMCULd+A=;
 b=M2f07Et4NHJdlubKp6TKsV7syb8vXQNhIrPR6hCGnjNcEGvyGv+NYXNdqpLRdF2mLc7a
 YUg74TapBrHuEFilYBcnXZihlksDNwpSL0EQiCOo4C0egVJh5QSEnH6pqLIu+yc1CUIN
 TYtD9jtOSCr53E4JeSJShLCOiLoRMB6cYlI2FYYcFJlfViSD0BL55npR26a8ZTkjRWco
 WqCRero9oeywfSWOeE7KlX8odC6ZJK7lZxbztnYFp93RIwu+C0RWV8z7dBj5qt3Mybsp
 PQhGl4TVPl7IZCFUGaIhEiYqnjCOStBTDWuV76zY1HZt1TzRxy/ZYaNamY8Hu2Qk0Ygb Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2ru59cxt1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 13:34:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FDWKUd193678;
        Mon, 15 Apr 2019 13:34:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2rubq5ra6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 13:34:07 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3FDY5wv012985;
        Mon, 15 Apr 2019 13:34:05 GMT
Received: from kadam (/41.210.147.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 06:34:05 -0700
Date:   Mon, 15 Apr 2019 16:33:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        devel@driverdev.osuosl.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] Staging: greybus: Cleanup in header file control.h
Message-ID: <20190415133357.GP6095@kadam>
References: <20190405201437.3689-1-madhumithabiw@gmail.com>
 <20190415131002.GC775@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415131002.GC775@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150093
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:10:02PM +0200, Johan Hovold wrote:
> On Fri, Apr 05, 2019 at 03:14:37PM -0500, Madhumitha Prabakaran wrote:
> > Fix a blank line after function/struct/union/enum
> > declarations. Also, convert to_gb_control()  macro into an inline
> > function in order to maintain Linux kernel coding style based
> > on which the inline function is preferable over the macro.
> 
> There are about 1200 macros wrapping container_of() in the kernel, so
> this is a common pattern which does not need to be changed (by contrast,
> only a handful container_of are wrapped by functions).
> 

A handful?

$ git grep "return container_of" | wc -l
1856

I'm like Donald Trump because I must have really small hands compared
to the rest of y'all.

I would prefer to apply these sorts of patches unless it causes an
issue...  Functions *are* better than macros.  It's a minor improvement,
but this is staging and we make tons minor style changes.  It's part of
the blessing and curse of being in staging...

regards,
dan carpenter

