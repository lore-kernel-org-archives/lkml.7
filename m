Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4DAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6541221920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cZmrGisy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbfJJJDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:03:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55504 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbfJJJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:03:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A91cR3151143;
        Thu, 10 Oct 2019 09:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=1cw9oEH7ZCs2HBUY1nZ4KMAQ/HcXcPqu2GOx+IY6xHk=;
 b=cZmrGisygrGJvpWx+UEHZkW6tZu3t3Nd3AwP5usb1NAjPek5krF5fYXukRoeNRqyBkxS
 2WmNnoY6kKFdPcdCBjZnxGvL8lcLk8ed6/Xmw55hS6OgMbRiNQohk0iwuV4EqhmJT95c
 TL7Dj0R0hvtLpqLjGXqOnX2JxyUNjb1VNreyazNmXba0r7X/A7x0AngQlG2mDncqYbjv
 MKL7MJahO7kX+N6DOwab2YQCdJAebAqkMM889B1ptbhpozqx5xAFcNOv1bfIXVOPXnLD
 HOM3OC9CKYj7YvvzNEu3+iUWezrmS7qIyZ2nhDMIkFUBVjVWOzlfn+N3mOeVU3kwGDa7 Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vek4qst9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:03:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9A8qnRm078254;
        Thu, 10 Oct 2019 09:03:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vhrxd95p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Oct 2019 09:03:33 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9A93WcV021873;
        Thu, 10 Oct 2019 09:03:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Oct 2019 02:03:31 -0700
Date:   Thu, 10 Oct 2019 12:03:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: rtl8723bs: Style clean-up in rtw_mlme.c
Message-ID: <20191010090323.GE20470@kadam>
References: <cover.1570682635.git.wambui.karugax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570682635.git.wambui.karugax@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=693
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910100082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9405 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=791 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910100082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 07:49:04AM +0300, Wambui Karuga wrote:
> This patchset addresses multiple style and formatting issues reported by
> checkpatch.pl in drivers/staging/rtl8723bs/core/rtw_mlme.c
> 
> PATCH v2 of the series corrects the "patchest" mispelling in the
> original cover letter and provides a clearer subject line.

The cover letter isn't stored in the git log so spelling is not
important.  The original subjects were fine as well.

regards,
dan carpenter

