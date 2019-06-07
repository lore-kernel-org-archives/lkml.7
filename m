Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20EC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C832083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5nzzAE25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfFGOTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:19:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfFGOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:19:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57E9ZJ7002817;
        Fri, 7 Jun 2019 14:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fAnhQLoQ1de79AGPdIHISYKoMOoXNvOdtrq91rhemx4=;
 b=5nzzAE25TXPIKKDm9sI8c/7FCG7SMnEKczYNNEelROsZ9IekWDlbqePm+aK9pfPVyRpE
 RUAnrbhTHv9021DbZqzZoUEzL56UxZQYVy6RXjdNqT+CHjICcvgcfBNo3aK86mOrD6cN
 vMsyo1YOMfMVWGl7gJ7djVGiqFWl66VeihV6+H3gUyFf5Oe3eMvb+UksUT/4mPIFJj3I
 lDbDd8mxL5iU3+oZ9PxJ0WfbnmkM0HVQKpUHjpkFoNR5mpM33j5LmQD6MVOP+i+nn4V0
 3+TIyRRXyDUh/ClyLg+kF2zxzR8cZ1WzKAerPvusK2dm+jf/UMc5BuF2YnAZlmNkgaH3 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sugstxhva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 14:19:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57EIoxM150349;
        Fri, 7 Jun 2019 14:19:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2swnhd9kmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 14:19:07 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57EJ7EZ030067;
        Fri, 7 Jun 2019 14:19:07 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 07:19:06 -0700
Date:   Fri, 7 Jun 2019 17:18:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, straube.linux@gmail.com,
        larry.finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        colin.king@canonical.com, valdis.kletnieks@vt.edu,
        tiny.windzz@gmail.com
Subject: Re: [PATCH 2/2] staging: rtl8712: r8712_createbss_cmd(): Change
Message-ID: <20190607141855.GQ31203@kadam>
References: <20190607140658.11932-1-nishkadg.linux@gmail.com>
 <20190607140658.11932-2-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607140658.11932-2-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=636
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=686 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the subject.

On Fri, Jun 07, 2019 at 07:36:58PM +0530, Nishka Dasgupta wrote:
> Change return values of r8712_createbss_cmd from _SUCCESS and _FAIL to 0
> and -ENOMEM respectively.
> Change return type of the function from unsigned to int to reflect this.
> Change call site to check for 0 instead of _SUCCESS.
> (Instead of !=0, simply passing the function output to the conditional
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> will do.)
  ^^^^^^^^^

Remove this line.

Otherwise it looks ok.  Please resend.

regards,
dan carpenter

