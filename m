Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A931BC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D5F20644
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 01:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfGaBm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 21:42:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725209AbfGaBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 21:42:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V1g9Yw114786;
        Tue, 30 Jul 2019 21:42:10 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u2xpgdhd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jul 2019 21:42:09 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6V1eY6d012373;
        Wed, 31 Jul 2019 01:41:57 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 2u0e86txuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 01:41:57 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6V1furp62128528
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 01:41:56 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96DD2C6057;
        Wed, 31 Jul 2019 01:41:56 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A750DC605F;
        Wed, 31 Jul 2019 01:41:54 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.80.208.54])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 31 Jul 2019 01:41:54 +0000 (GMT)
Subject: Re: [PATCH] scsi: ibmvfc: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20190729002608.GA25263@embeddedor>
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
Message-ID: <58a4f287-8311-31ee-f403-16b0adcf0271@linux.ibm.com>
Date:   Tue, 30 Jul 2019 18:41:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729002608.GA25263@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/19 5:26 PM, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/scsi/ibmvscsi/ibmvfc.c: In function 'ibmvfc_npiv_login_done':
> drivers/scsi/ibmvscsi/ibmvfc.c:4022:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    ibmvfc_retry_host_init(vhost);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:4023:2: note: here
>   case IBMVFC_MAD_DRIVER_FAILED:
>   ^~~~
> drivers/scsi/ibmvscsi/ibmvfc.c: In function 'ibmvfc_bsg_request':
> drivers/scsi/ibmvscsi/ibmvfc.c:1830:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    port_id = (bsg_request->rqst_data.h_els.port_id[0] << 16) |
>    ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     (bsg_request->rqst_data.h_els.port_id[1] << 8) |
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     bsg_request->rqst_data.h_els.port_id[2];
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:1833:2: note: here
>   case FC_BSG_RPT_ELS:
>   ^~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:1838:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    port_id = (bsg_request->rqst_data.h_ct.port_id[0] << 16) |
>    ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     (bsg_request->rqst_data.h_ct.port_id[1] << 8) |
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     bsg_request->rqst_data.h_ct.port_id[2];
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvfc.c:1841:2: note: here
>   case FC_BSG_RPT_CT:
>   ^~~~
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>
