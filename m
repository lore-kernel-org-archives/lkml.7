Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397EBC04AB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BA5208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFGAlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 20:41:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfFGAlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:41:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x570WDhK086483
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 20:41:39 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sya05gbvh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 20:41:38 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 7 Jun 2019 01:41:37 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Jun 2019 01:41:34 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x570fX4S22872512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jun 2019 00:41:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48B69B205F;
        Fri,  7 Jun 2019 00:41:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 097E2B2065;
        Fri,  7 Jun 2019 00:41:31 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.204.144])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jun 2019 00:41:30 +0000 (GMT)
Subject: Re: [PATCH v2] drivers: scsi: remove unnecessary #ifdef MODULE
From:   James Bottomley <jejb@linux.ibm.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     khalid@gonehiking.org, martin.petersen@oracle.com,
        aacraid@microsemi.com, linux-scsi@vger.kernel.org
Date:   Fri, 07 Jun 2019 03:41:29 +0300
In-Reply-To: <1559833471-30534-1-git-send-email-info@metux.net>
References: <1559833471-30534-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060700-0040-0000-0000-000004F9D52A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011225; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01214291; UDB=6.00638289; IPR=6.00995371;
 MB=3.00027213; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-07 00:41:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060700-0041-0000-0000-00000905F536
Message-Id: <1559868089.3233.1.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-06 at 17:04 +0200, Enrico Weigelt, metux IT consult
wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> The MODULE_DEVICE_TABLE() macro already checks for MODULE defined,
> so the extra check here is not necessary.
> 
> Changes v2:
>     * make dptids const to fix warning on unused variable

I don't think this works; in my version of gcc, const does not defeat
the unused variable warning if I try with a test programme:

jejb@jarvis:~> gcc -Wunused-variable -c test1.c
test1.c:3:18: warning: ‘i’ defined but not used [-Wunused-cons
t-variable=]
 static const int i[] = { 1, 2, 3};

James

