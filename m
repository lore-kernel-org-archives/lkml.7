Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53680C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E9D2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HXNuIAKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbfGZPAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:00:20 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:11782 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387530AbfGZPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:00:19 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QEx3P4031869;
        Fri, 26 Jul 2019 10:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=dRRSsXGnIRgrscQY5hnX1hmurACLpUp0UvIiA6j6gws=;
 b=HXNuIAKausDBi+eimXW1feKfkh2Nx82Uf3xGhCVXAcEMuyegzOUnAPrhJFdnuX17Sib1
 HZVOW6lmUiiKZFgIPe0+/4eyo8MmcMvrLYxp8rf94LTkCvoqphx3qzPOkSDBviTIryap
 HejzjJJLIJznXRIYcjD7RKrp7eJD3gu/RulquYwufSc/jexLiLWGtP7/PHe/AEP/eCz6
 8ZxIwN9amKIMdHCnXjPlACAhzPmnKDoU2OJW/Ut+5cs7iYqi+J2OHpsNmbiN0DmooDWM
 PUTfc9wO5NH7m3AOqPLSHAW7u6Es1etEPpp9xgYb/dHLynSagYlH8zSt0h++pqY5TAXD EA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2tx61nn3gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Jul 2019 10:00:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 26 Jul
 2019 16:00:07 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 26 Jul 2019 16:00:07 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D057A2DD;
        Fri, 26 Jul 2019 16:00:07 +0100 (BST)
Date:   Fri, 26 Jul 2019 16:00:07 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] irqchip: madera: Fixup SPDX headers
Message-ID: <20190726150007.GD54126@ediswmail.ad.cirrus.com>
References: <20190625154717.28640-1-ckeepax@opensource.cirrus.com>
 <861rycoqli.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <861rycoqli.wl-maz@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1907260185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 02:47:05PM +0100, Marc Zyngier wrote:
> On Tue, 25 Jun 2019 16:47:17 +0100,
> Charles Keepax <ckeepax@opensource.cirrus.com> wrote:
> > diff --git a/include/linux/irqchip/irq-madera.h b/include/linux/irqchip/irq-madera.h
> > index 1160fa3769ae6..3a46cadd38654 100644
> > --- a/include/linux/irqchip/irq-madera.h
> > +++ b/include/linux/irqchip/irq-madera.h
> > @@ -1,4 +1,4 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> 
> I'm not sure this changes anything. LICENSES/preferred/GPL-2.0 doesn't
> seem to distinguish the two tags.
> 
> Thomas, what do you think?
> 

I have no objection to dropping the patch if this makes no
difference, just realised all the recent SPDX patches had been
using the -only version and assumed that was the preferred
version for v2 only.

Thanks,
Charles
