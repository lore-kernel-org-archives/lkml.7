Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F0720818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uBIcTNy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDIBqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:46:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40512 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfDIBqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:46:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391hSPR079446;
        Tue, 9 Apr 2019 01:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vDlKOHKr/irYFI0ulYTL9UpmIpgnDcEs+4qwzhwAU6g=;
 b=uBIcTNy1lI44YkqbglkxJBNeX3jSjhUl1Bs5tjjOHVdnZREC2fIECUxJ+f6LgLs9EruR
 BUpMBvsXJiQcnAd2BBpzegswiByTWSgmyirGaJAEZ271wpj2uAbC3JD3Fet+P224uxuT
 U9dul+WoBGUvTqHSoJ4IekuP++C/7eSfn3WWUos9jHDZSpYsE4VfnXrNC8nk7zi+bsKz
 Xpg5ItpO/Jt1OQ+Jgtr/jCxh0vvANRDXEKWiefirllWW0LSaXZYyCtikA7hZXYXpMh5v
 UO5C12JQXAzBDd07QtGFwKsoTwPP4BXiD9pcfY11bOW1NTv3Itp3TUVpJHdfz2SXKbSA pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmea4eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:46:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x391jg6n157232;
        Tue, 9 Apr 2019 01:46:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rpj5a9snc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 01:46:28 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x391kRIV024104;
        Tue, 9 Apr 2019 01:46:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 18:46:27 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     qla2xxx-upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: qla2xxx: fix spelling mistake "alredy" -> "already"
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190408082014.1354-1-colin.king@canonical.com>
Date:   Mon, 08 Apr 2019 21:46:24 -0400
In-Reply-To: <20190408082014.1354-1-colin.king@canonical.com> (Colin King's
        message of "Mon, 8 Apr 2019 09:20:14 +0100")
Message-ID: <yq1ef6cosr3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=762
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090010
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=802 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> There is a spelling mistake in a ql_log message. Fix it.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
