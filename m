Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10544C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D526F2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 19:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dzHKy6Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfGITlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 15:41:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53404 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfGITlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 15:41:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69Jcv4t008200;
        Tue, 9 Jul 2019 19:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=v6JzwxNhW7bzgko99Kwfof0K7Ueo5gVuWW0ORG1AJkg=;
 b=dzHKy6Ne73WcCP34Pi6pY66/wNwOc0ZljHClEm9srnlpyrD0hPl/+8eZDfM7ybreidcn
 pFuDUvZcAnQDLfkFfInOu6UMDENN9/p+OvdpBlnHWPfn2KkZVLKEHC+z04CqlrKSFUQ/
 a3+JUj9z/JQnogG6fBGJdcCvc0YYmEZ0UGHp5KXttyLKAbJwecFbBc/Xo9hDgm5zB03N
 2zET2gf5UiQlEEIf5P8TKv7eqO37Lhhcuva4ey4rb2TP4cglypBFAre8eeoDzL9LvwvS
 a10w0fupQcu0tp5MmqHvtZHaCKyhJaYKhUhCVg6lmdoD4kOP/6OrYfRrLp6KmV1nIGwm vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tjk2tpatw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 19:41:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69JcQbo079467;
        Tue, 9 Jul 2019 19:39:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2tjgru9s1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 19:39:20 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x69JdJfg029512;
        Tue, 9 Jul 2019 19:39:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jul 2019 12:39:18 -0700
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.2+ merge window
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1562699693.3362.93.camel@HansenPartnership.com>
Date:   Tue, 09 Jul 2019 15:39:16 -0400
In-Reply-To: <1562699693.3362.93.camel@HansenPartnership.com> (James
        Bottomley's message of "Tue, 09 Jul 2019 12:14:53 -0700")
Message-ID: <yq1lfx7c80r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=808
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090233
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=864 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James,

> This is mostly update of the usual drivers: qla2xxx, hpsa, lpfc, ufs,
> mpt3sas, ibmvscsi, megaraid_sas, bnx2fc and hisi_sas as well as the
> removal of the osst driver (I heard from Willem privately that he would
> like the driver removed because all his test hardware has
> failed).  Plus number of minor changes, spelling fixes and other
> trivia.

Looks like you forgot to pull in the scatterlist topic branch.

-- 
Martin K. Petersen	Oracle Linux Engineering
