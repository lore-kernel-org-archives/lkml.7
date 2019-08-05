Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3492DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D76216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2amIr1FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbfHEOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 10:36:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39738 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbfHEOgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 10:36:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75EXgbA102870;
        Mon, 5 Aug 2019 14:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=T44fzXldQtXj1k7hrU+hv3UxmypRdG1zOcXmSdw6sbk=;
 b=2amIr1FVQH6dlAQi6DxGrIjwHhgFPNRDE2Y9r0qGi52q3jWkZF6o0KKT4QpWoWfjIpP5
 HeIqpPhRdDUVUZ66O750Z5pjgk+R5HutSNwkh2GAGzVnLxrWOdqotUKJhjyr0dOVYTdq
 k2d/BuUDJ7hY5tKwwF96Ef6lQ5ykO5/yta8MSK9hNAZlOP2FTV7LHSsfbl4l+M+UjhnS
 zIIgVohbUVSIAIuQf1+wGZ+olIxD4G2wKgJtDFz2BMG8Tj5RNMgd+8SNezZJ6fQsBwgX
 mvMDJA7UghYlKytyIaBrPXQd5kPtQgHzZIc3N8kLdy8VxyJY443ECj/CBGOSJ1TWYkdz SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u52wqykkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 14:36:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75EWfP2170089;
        Mon, 5 Aug 2019 14:36:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u51kmgfb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 14:36:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x75Eanw3026122;
        Mon, 5 Aug 2019 14:36:49 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 07:36:48 -0700
Date:   Mon, 5 Aug 2019 17:36:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Giridhar Prasath R <cristianoprasath@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433 line over 80 characters in multiple places
Message-ID: <20190805143642.GD1974@kadam>
References: <20190805000248.4902-1-cristianoprasath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805000248.4902-1-cristianoprasath@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908050162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject needs a colon after "pi433:" but also this change isn't
really an improvement so far as readability goes.

regards,
dan carpenter

