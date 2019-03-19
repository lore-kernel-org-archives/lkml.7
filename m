Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80703C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444AA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YfHG/IWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfCSS3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:29:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47176 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:29:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JISndH099439;
        Tue, 19 Mar 2019 18:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8pAoR+lDL/U8hN6MMy66pVJj908vca3PghUKzT0HLGc=;
 b=YfHG/IWZWKjtzhNzoM0cfLBViWQKz68Su5u4tNVR56QOL+yRxs4cU0VmliDF7MJ8Gmwa
 +aLON0oQ+bapYHWgDRtUptBTZT77EaQpVBp9PCa0ve/5mEI6ICOesr1yx/jHKa663S1A
 EQwGZB7Q399hdcRA12CGqnFFedvicee+kDKjCpyC7oIhUWnBMZTzNuI5bnLG3d3o1qXt
 VzNRTsv7oX708FJKWKou/EnvBKexaqfVFxYBFbxxfQTsALTRzw014KmLUFpy1iBAJ/l2
 Fkwj1ZPyy6+6+xCkwHXXmyV+JI7ctr81f+BnfbFag+OWQvGt7iQwALYd5Romr/i+dm0W yQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2r8pneps0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:29:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2JIT8Pc030695
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 18:29:08 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2JIT54G011593;
        Tue, 19 Mar 2019 18:29:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 11:29:05 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Jack Wang <jinpu.wang@profitbricks.com>, lindar_liu@usish.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: pm8001: clean up various indentation issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190317181532.27477-1-colin.king@canonical.com>
Date:   Tue, 19 Mar 2019 14:29:03 -0400
In-Reply-To: <20190317181532.27477-1-colin.king@canonical.com> (Colin King's
        message of "Sun, 17 Mar 2019 18:15:32 +0000")
Message-ID: <yq17ecuen0w.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=790 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There are several lines of code where the indentation is at an
> incorrect level; fix these.

Applied to 5.2/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
