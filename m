Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3222C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABD0206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H301ueng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfIWAGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 20:06:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35418 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfIWAGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 20:06:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8N04cKD035584;
        Mon, 23 Sep 2019 00:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=aU7M5LCio0fxm4qTM0vCotZ+jtgfst/hqgJYmzVKKb8=;
 b=H301uengOiZWM3iD+AI26UsGbCCTaV0aJzB6XwsI6/CqI6LULs1SVgsQKMmXnuAFLXaV
 +uYD5WQsbiCutbmjDS14GdMfqOWmnQlGVJ/n9gxukAvQ4TmXXebzBp3+B0bMlm/VU6Gr
 wS0Z5uzi0Nt9+xZV49luN58UWZogRBnfeeHxmgC+GEu1sA+2TBMIy7dUvuhSBbr/ur9E
 ZS4BaUO4fm0sB26XcI6EHUQHBLxFVDasTCm0NVsAZM9PAn4wl4XrPcOXqq8061JxyKWS
 UtK5Uv/sLdj+mzd9p94zfjWE5+ycZkPAWVIeJAp9gUPp55dFhFMJvfMXnTA9Xrm4n6jX YA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v5cgqkpax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 00:06:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8N04HS1155112;
        Mon, 23 Sep 2019 00:06:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2v590ja534-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 00:06:05 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8N05tcG000312;
        Mon, 23 Sep 2019 00:05:56 GMT
Received: from [192.168.86.205] (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 22 Sep 2019 17:05:54 -0700
Subject: Re: [PATCH 2/2] soc: ti: move 2 driver config options into the TI SOC
 drivers menu
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     Olof Johansson <olof@lixom.net>, Nishanth Menon <nm@ti.com>,
        Benjamin Fair <b-fair@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <ae4b494c-9723-1bc2-e471-e0e9f7df6e8f@infradead.org>
 <2f0cd6cf-83c3-f60f-3d72-fd0cec64105e@infradead.org>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <4205a7aa-1f51-23bd-b661-f71f55391c5b@oracle.com>
Date:   Sun, 22 Sep 2019 17:05:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2f0cd6cf-83c3-f60f-3d72-fd0cec64105e@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9388 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=902
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909220257
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9388 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=988 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909220257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/19 1:46 PM, Randy Dunlap wrote:
> Hi Santosh,
> 
> Would you also pick up patch 2/2, which I didn't Cc: you on?    :(
> 
> Do I need to resend it?
> 
Yes please. I don't have your 2/2
