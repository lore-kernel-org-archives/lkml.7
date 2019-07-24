Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84464C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572992253D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NFEdfk7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGXCQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:16:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44834 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfGXCQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:16:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2E7kM040712;
        Wed, 24 Jul 2019 02:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=rUv0YQCGN4Yjy9DAKG3maMFZAVARFAxo8LQNt8Z+J7w=;
 b=NFEdfk7w1dH9cZgPs5IedVJrxYAD/+64Lgqaag4NgEcGyrmo/CWMiVslFSsRFVi2IlKK
 0i3cr+psl+ohN+lZ77lv9rT0J89yzSiHsKeaAzJz7swPcJQVdoWHOM9MRpxASRNQAIrs
 LzmzNg967Cc2kvqvPQo5Wa7qM2vq4D+SQYLQF0yUSHV1gPWKotKtx1RGqGMY2CRBuT/m
 +ZtOzIZfwK3lFRfDNr5Y4/Q/66ZIoQVhkeuyofvv9zqkYpbIsvMFs5YW59y2q2Y5Ige3
 QyJ34SZQ+knuIJB9O5jJoDmZJmo7VWgxb4UGSNYK3lquJsN6T7g2rOR3eYWyR/ua4/Xw xA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tx61bt7ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:16:28 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O2CssB112236;
        Wed, 24 Jul 2019 02:16:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tx60xd0qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 02:16:27 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6O2GQ3E002907;
        Wed, 24 Jul 2019 02:16:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 19:16:26 -0700
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: fcoe: fix a typo
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190721125039.13268-1-christophe.jaillet@wanadoo.fr>
Date:   Tue, 23 Jul 2019 22:16:24 -0400
In-Reply-To: <20190721125039.13268-1-christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sun, 21 Jul 2019 14:50:39 +0200")
Message-ID: <yq1o91kqirr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=720
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=786 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> #define relative to FCOE CTLR start with FCOE_CTLR, except
> FCOE_CTRL_SOL_TOV.
>
> This is likely a typo and CTRL should be CTLR here as well.

Applied to 5.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
