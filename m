Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC4C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E594620679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbfG3Swo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:52:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388066AbfG3Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:52:42 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6UIqHkx069707;
        Tue, 30 Jul 2019 14:52:20 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u2ug104w0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 14:52:20 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6UIoX14012934;
        Tue, 30 Jul 2019 18:52:19 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 2u0e86fyqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 18:52:19 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6UIqE8X49938730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 18:52:14 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5EFF6E052;
        Tue, 30 Jul 2019 18:52:14 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A09C6E04E;
        Tue, 30 Jul 2019 18:52:14 +0000 (GMT)
Received: from p8tul1-build.aus.stglabs.ibm.com (unknown [9.3.141.206])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 30 Jul 2019 18:52:13 +0000 (GMT)
Date:   Tue, 30 Jul 2019 13:52:13 -0500
From:   "Matthew R. Ochs" <mrochs@linux.ibm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Manoj N. Kumar" <manoj@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] scsi: cxlflash: Mark expected switch fall-throughs
Message-ID: <20190730185213.GA10811@p8tul1-build.aus.stglabs.ibm.com>
References: <20190729002119.GA25068@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729002119.GA25068@embeddedor>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907300192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 07:21:19PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/scsi/cxlflash/main.c: In function 'send_afu_cmd':
> drivers/scsi/cxlflash/main.c:2347:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (rc) {
>       ^
> drivers/scsi/cxlflash/main.c:2357:2: note: here
>   case -EAGAIN:
>   ^~~~
> drivers/scsi/cxlflash/main.c: In function 'term_intr':
> drivers/scsi/cxlflash/main.c:754:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (index == PRIMARY_HWQ)
>       ^
> drivers/scsi/cxlflash/main.c:756:2: note: here
>   case UNMAP_TWO:
>   ^~~~
> drivers/scsi/cxlflash/main.c:757:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 2, hwq);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:758:2: note: here
>   case UNMAP_ONE:
>   ^~~~
> drivers/scsi/cxlflash/main.c:759:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cfg->ops->unmap_afu_irq(hwq->ctx_cookie, 1, hwq);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:760:2: note: here
>   case FREE_IRQ:
>   ^~~~
> drivers/scsi/cxlflash/main.c: In function 'cxlflash_remove':
> drivers/scsi/cxlflash/main.c:975:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cxlflash_release_chrdev(cfg);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:976:2: note: here
>   case INIT_STATE_SCSI:
>   ^~~~
> drivers/scsi/cxlflash/main.c:978:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    scsi_remove_host(cfg->host);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:979:2: note: here
>   case INIT_STATE_AFU:
>   ^~~~
> drivers/scsi/cxlflash/main.c:980:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    term_afu(cfg);
>    ^~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:981:2: note: here
>   case INIT_STATE_PCI:
>   ^~~~
> drivers/scsi/cxlflash/main.c:983:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    pci_disable_device(pdev);
>    ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/cxlflash/main.c:984:2: note: here
>   case INIT_STATE_NONE:
>   ^~~~
> drivers/scsi/cxlflash/main.c: In function 'num_hwqs_store':
> drivers/scsi/cxlflash/main.c:3018:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (cfg->state == STATE_NORMAL)
>       ^
> drivers/scsi/cxlflash/main.c:3020:2: note: here
>   default:
>   ^~~~~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Matthew R. Ochs <mrochs@linux.ibm.com>

