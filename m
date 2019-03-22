Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A652070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d/TkN+cg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfCVKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:01:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42208 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfCVKB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:01:59 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2M9ws2R137348;
        Fri, 22 Mar 2019 10:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kJNYdPSyjKtT68d0MsO29Cufc/qNtsdefQKX1pxlzdM=;
 b=d/TkN+cglkiKJxKyssZtDT82XHfJLpsZGY61hK6Jf4LssjdvOe2K1KKVmtN3sKFWSIZ7
 1MwIp6XvKwiaEnJtLv2oKqMA2F861+mtfu+0Nt7WDk7uf57it3y9qmRLEkWRLxb4hHo5
 U09pcc3kR/ImpH4NPP/7myP2AbMIWHlv+AlOfTBRsnAqCkDBK4SfR2H6pX9cnjJhXgPW
 Tkp+KCiPcuifwcRziLGbW0xRWZRfTDw8GPwaG8CMO8G1HhkLPoYOAyydZuaUy+miQ8iL
 +v2ie+IqxgzX2i+J8JVJewsR3SdFKYLFrN8JDg3JSoC+KuAosburyDQtjmLhSi/RnSh7 sQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r8pnf5bjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 10:01:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2MA1o5h013151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 10:01:51 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2MA1o9t002073;
        Fri, 22 Mar 2019 10:01:50 GMT
Received: from kadam (/41.202.241.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Mar 2019 03:01:49 -0700
Date:   Fri, 22 Mar 2019 13:01:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     gregkh@linuxfoundation.org, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Change uint32_t to u32
Message-ID: <20190322100140.GL2202@kadam>
References: <20190321192502.GA11144@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321192502.GA11144@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9202 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 12:55:02AM +0530, Bharath Vedartham wrote:
> This is a follow up on my previous patch. Change occurences of the
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Put this sort of information under the --- cut off below the Sign off.

> stdint type uint32_t to its shortened type u32. This fixed the checkpatch.pl warning: "Prefer u32 over uint32_t".

This line is too long.  Limit it to 72 characters.

> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
  ^^^

regards,
dan carpenter

