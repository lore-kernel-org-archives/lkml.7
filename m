Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18456C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81142075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 12:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bax0dq5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbfDDMcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 08:32:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36942 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDMcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 08:32:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34CNjbc071171;
        Thu, 4 Apr 2019 12:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=gZDsPgT54iopIB/5RFZJdDu4VB62KWX4j1imZ+6IIlg=;
 b=bax0dq5nz+zCq5Hh7heAKm3Gbajh0ndp+yIi20Cow+AmZ+Lr7DaGACQ7H8tgSPqHisfT
 ETobWq7+yda4aVXVZ06xWALV2SuByLIvVjYn2aAhXnB+KC4R6/ddKCr7ywZ6rJFj7p2v
 bhVnWVBHmDccGgfSKUreKrdCd5H7Z+jg2Rp3fP9j9MOC5as9iN9F8Qhm7t5vw+BbPLKD
 U+TSFv2R5j8/h1Pvz74I6kp91birLPir3o15lbzFw1xDtn0ASLHUbAcVbyXMpvhMH7aP
 LYfedp9l4sJG6gJgP+qXAO96Jn3p5QElwbmsPNKRlWJStxokMwFotPB4+SgcyEAHkFil PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rhyvtet9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 12:32:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x34CVP7L092445;
        Thu, 4 Apr 2019 12:32:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rm9mjkea0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 12:32:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x34CWL3L024622;
        Thu, 4 Apr 2019 12:32:21 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 05:32:21 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] mm/gup.c: fix the wrong comments
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20190404072347.3440-1-sjhuang@iluvatar.ai>
Date:   Thu, 4 Apr 2019 06:32:20 -0600
Cc:     akpm@linux-foundation.org, ira.weiny@intel.com,
        sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <3D9A544A-D447-4FD2-87A5-211588D6F3E5@oracle.com>
References: <20190404072347.3440-1-sjhuang@iluvatar.ai>
To:     Huang Shijie <sjhuang@iluvatar.ai>
X-Mailer: Apple Mail (2.3445.104.8)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=590
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040083
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=650 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 4, 2019, at 1:23 AM, Huang Shijie <sjhuang@iluvatar.ai> wrote:
> 
> 
> + * This function is different from the get_user_pages_unlocked():
> + *      The @pages may has different page order with the result
> + *      got by get_user_pages_unlocked().
> + *

I suggest a slight rewrite of the comment, something like:

* Note this routine may fill the pages array with entries in a
* different order than get_user_pages_unlocked(), which may cause
* issues for callers expecting the routines to be equivalent.
