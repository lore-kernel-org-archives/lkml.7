Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E83C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A412075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TEwFTWb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfDOOlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:41:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46020 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOOk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:40:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FEchpP164639;
        Mon, 15 Apr 2019 14:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=Rqu3t+StshgC0iHzQioipMk01kLa+SdGai1fnj0ULRM=;
 b=TEwFTWb/3738xWTXrj896UgIClekOvA23UjQaDRx6wBfU0S+AIqf4/yxD6DNCV8JOyBF
 OKykhca+v44K9iEWxU30cWhU4Qyjv/PAWzTXBCsuMYrh7KsB39gUkB/J/UVDPPVfRz3i
 jaB5EAHcmGI+skpMpAhg1VZI4m9CPCq+XAidHFAErTqmJLK/8RTuYVDco1PdmSqneZcF
 J4P6+YX3hNcE0A04Rv14aB2Ha3fJxD7GxwlSdgnYWRx9NPWbRSRS30CcrZzGDVFyibKa
 buDnzg5IuDinFD+2xeLdDAM5YgiIWRYlfh1v4+X7wbaSZQWEN4fABwxqrGwkGyindYoo mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ru76t72s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 14:40:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3FEeKlT179003;
        Mon, 15 Apr 2019 14:40:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2rubq5sers-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 14:40:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3FEeo4t019732;
        Mon, 15 Apr 2019 14:40:50 GMT
Received: from kadam (/41.210.147.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 07:40:49 -0700
Date:   Mon, 15 Apr 2019 17:40:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] Staging: greybus: Cleanup in header file control.h
Message-ID: <20190415144015.GB22423@kadam>
References: <20190405201437.3689-1-madhumithabiw@gmail.com>
 <20190415131002.GC775@localhost>
 <20190415133357.GP6095@kadam>
 <20190415141201.GD775@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415141201.GD775@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=863
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150101
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904150101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What I'm saying is that if we just apply it then we avoid the long
discussion forever.  The macro is OK, sure, but it's not like anyone is
going to come back later and argue that macros are better or preferred.

regards,
dan carpenter

