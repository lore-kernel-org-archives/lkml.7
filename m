Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93E6C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B9120850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wk1OHc+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfCSVNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:13:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfCSVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:13:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2JL9JTs006221;
        Tue, 19 Mar 2019 21:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=RyJa92ww4aru1ZB9HtUoa8Bk28Pjh5j0m3RGpjd6YPU=;
 b=Wk1OHc+4PrEBf0vUMhouO/+u2ts0xGR5N2LkbkjO2e0bvARbQYVSexPGuSJVW8r9k5DE
 bC/4qreXTZ2SmZ53OneBZTQrxyNKTFMviTf+FNJWKhxZyXm6ARBsM6tald3Vih8+UX8B
 HdYSqtCwDTJPz2JNx+lYtYaYSPokCkIaK223QTztSCMUrPThJPRmkEq8ZSssgemKAlZE
 aLH3kHIqrTaDiv9KVSuO4fNXAe5pTcPWAkp5smhPqZ/dMfOje6L8dpP60qm2Bx818zTF
 ISVTx4YVqk9UFZ1JfVrR8ZzQ4+Vw/doa7UcPB50n2Bzk6DajCNKEJE0qONuqsxUeaaZb tQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r8ssrf5rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:10:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2JLAB4j030521
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 21:10:11 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2JLABqO015196;
        Tue, 19 Mar 2019 21:10:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Mar 2019 14:10:10 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: atp870u: clean up code style and indentation issues
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190122151030.7007-1-colin.king@canonical.com>
Date:   Tue, 19 Mar 2019 17:10:08 -0400
In-Reply-To: <20190122151030.7007-1-colin.king@canonical.com> (Colin King's
        message of "Tue, 22 Jan 2019 15:10:30 +0000")
Message-ID: <yq15zsed0zz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9200 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=732 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Clean up { brace to fix cppcheck warning. Remove some trailing spaces
> at end of a statement.  Also clean up an indentation issue.

Applied to 5.2/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
