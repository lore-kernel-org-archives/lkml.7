Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A95C74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55820872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfGKNxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:53:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30826 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfGKNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:53:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BDllJP017025
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 09:52:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tp6a1g7tv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 09:52:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Thu, 11 Jul 2019 14:52:54 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Jul 2019 14:52:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6BDqoBj27525506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 13:52:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 387404C052;
        Thu, 11 Jul 2019 13:52:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F09524C046;
        Thu, 11 Jul 2019 13:52:49 +0000 (GMT)
Received: from localhost (unknown [9.152.212.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 11 Jul 2019 13:52:49 +0000 (GMT)
Date:   Thu, 11 Jul 2019 15:52:48 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/zcrypt: remove the exporting of
 ap_query_configuration
References: <20190709122507.11158-1-efremov@linux.com>
 <a71450e5-892c-3841-22d6-9f5c7b2d4ca4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a71450e5-892c-3841-22d6-9f5c7b2d4ca4@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19071113-0028-0000-0000-000003837603
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071113-0029-0000-0000-000024438A74
Message-Id: <your-ad-here.call-01562853168-ext-7276@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 08:44:53AM +0200, Harald Freudenberger wrote:
> On 09.07.19 14:25, Denis Efremov wrote:
> > The function ap_query_configuration is declared static and marked
> > EXPORT_SYMBOL, which is at best an odd combination. Because the
> > function is not used outside of the drivers/s390/crypto/ap_bus.c
> > file it is defined in, this commit removes the EXPORT_SYMBOL() marking.
> >
> > Fixes: f1b0a4343c41 ("s390/zcrypt: Integrate ap_asm.h into include/asm/ap.h.")
> > Fixes: 050349b5b71d ("s390/zcrypt: externalize AP config info query")
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > ---
> >  drivers/s390/crypto/ap_bus.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
> > index b9fc502c58c2..379e43b79006 100644
> > --- a/drivers/s390/crypto/ap_bus.c
> > +++ b/drivers/s390/crypto/ap_bus.c
> > @@ -208,7 +208,6 @@ static inline int ap_query_configuration(struct ap_config_info *info)
> >  		return -EINVAL;
> >  	return ap_qci(info);
> >  }
> > -EXPORT_SYMBOL(ap_query_configuration);
> >  
> >  /**
> >   * ap_init_configuration(): Allocate and query configuration array.
> This function was exported a while ago for KVM code. However, never used.
> So removing the export is the right thing. Thanks Denis
> 
> Heiko/Vasily will you pick this patch please?
> 
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> 

Applied, thanks.

