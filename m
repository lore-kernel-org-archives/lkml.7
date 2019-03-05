Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB29C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DEF206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfCEOR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:17:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727659AbfCEOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:17:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x25EENul003665
        for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2019 09:17:56 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r1tdfhad3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 09:17:55 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <oberpar@linux.ibm.com>;
        Tue, 5 Mar 2019 14:07:46 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 5 Mar 2019 14:07:42 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x25E7fwI59965606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Mar 2019 14:07:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A62D0A405F;
        Tue,  5 Mar 2019 14:07:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58254A405B;
        Tue,  5 Mar 2019 14:07:41 +0000 (GMT)
Received: from [9.152.212.90] (unknown [9.152.212.90])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Mar 2019 14:07:41 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] gcov: docs: add a note on GCC vs Clang differences
To:     Tri Vo <trong@android.com>
Cc:     ghackmann@android.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        yamada.masahiro@socionext.com
References: <20190122233749.42220-1-trong@android.com>
 <20190122233749.42220-4-trong@android.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Date:   Tue, 5 Mar 2019 15:07:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190122233749.42220-4-trong@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19030514-0008-0000-0000-000002C8CCF3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030514-0009-0000-0000-00002234D399
Message-Id: <018fe29b-bad5-e789-1fe7-73f42a90a65e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903050096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.2019 00:37, Tri Vo wrote:
> Document some things of note to gcov users:
> 1. GCC gcov and Clang llvm-cov tools are not compatible.
> 2. The use of GCC vs Clang is transparent at build-time.

For completeness sake please also add something like the following to
the commit message:

Also adjust the documentation to account for the removal of config
symbol CONFIG_GCOV_FORMAT_AUTODETECT by commit 6a61b70b43c9
("gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT").

> 
> Signed-off-by: Tri Vo <trong@android.com>
> ---
>  Documentation/dev-tools/gcov.rst | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>

-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

