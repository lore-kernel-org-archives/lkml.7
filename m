Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B27E2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s5z1g5m9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLNRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:17:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38836 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfCLNRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:17:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2CD8pLL077593;
        Tue, 12 Mar 2019 13:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qFOffKMVPcv/YuN+HsoAb3qzANxioKMhh3KIzlNjHck=;
 b=s5z1g5m9hgfNhBxFPeO4vi2DcSywT6yVyY+n7veZtVUu5rMxqwrH6wpGQufmCBEEi/qW
 omOyBRYDo1YP+kP6Jj0NJSoyQsbKzltHRxeZY3LcaeLECXDWH1EmPyq8kUkfdmJlRox8
 EFlOhDjcozGo4KZ6ooSQgXLRWIx1X8MAIwutAci6MP5KetEKSoJv8DgpIrgmsV6B0s7k
 xWYJBS5kJf7/shb6OLq5CTi7LqAcqNtHlbtJSNjFLU26SQhUM9IFivnWQyqeJQctCiQp
 77WFqfYseF/AAIP+Pipj3GwBzRWxfJ+13+gxaK70U92cPugvRCSKfGNAOJ4GnTWTOVgG 4A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r44wu4h6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 13:17:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2CDHQ3H016762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 13:17:26 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2CDHOwL021703;
        Tue, 12 Mar 2019 13:17:25 GMT
Received: from kadam (/197.157.0.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Mar 2019 06:17:24 -0700
Date:   Tue, 12 Mar 2019 16:17:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Milan P. Gandhi" <mgandhi@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        julia.lawall@lip6.fr
Subject: Re: [PATCH 0/2] scsi: qla2xxx: Fix for a formatting issue and typo
 in qla_bsg.c
Message-ID: <20190312131716.GJ2412@kadam>
References: <20190312124937.GA13922@machine1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312124937.GA13922@machine1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=681 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.  It might take a while for the maintainers to get around to
this because the merge window is open and it's a low priority cleanup.

regards,
dan carpenter

