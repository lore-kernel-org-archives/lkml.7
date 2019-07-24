Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E03C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8009227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Cmnujeva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGXIjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:39:21 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57034 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbfGXIjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:39:21 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6O8XmpJ020457;
        Wed, 24 Jul 2019 03:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=kq12ssq+svftp3GaCiDd/DAWyCN0IaOqRChAjOHdgDY=;
 b=Cmnujevayfe5Qmqny6wB9tF9BcjpfKA9FbE9wTjBP2tDWYwbkVhKMR1r7Harb/grcH53
 fk/MZd63Sbas/stidiuv+7LrVbmgRgoT8n/zPdF+N+qlY13bZPR4WKbxjoEyxjMxOPfk
 4DXekrBvlSBfDtFfNb7Hw2Jw1Dd6Q1McHe9+clJPxrNHDDgCQTOK6RgUtE5cBY3v9kYL
 nbohTHedhstZv170oqjBTmCr3GVYtbXQBPX5kfu8kdIOIgJXZr1Taf/o74reXiXLjK+8
 aHgiBcxFbo2Hg9JH9zo6j6ta4M4TkS12yAUDVKEHsBGiJYrs+R7dXdfJ7mkfV2kMcv86 ZQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2tx61s13ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Jul 2019 03:38:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 24 Jul
 2019 09:38:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 24 Jul 2019 09:38:14 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 73DFC45;
        Wed, 24 Jul 2019 09:38:14 +0100 (BST)
Date:   Wed, 24 Jul 2019 09:38:14 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <gustavo@embeddedor.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8955: Fix a typo in 'wm8995_pll_factors()'
 function name
Message-ID: <20190724083814.GS54126@ediswmail.ad.cirrus.com>
References: <20190724052632.30476-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190724052632.30476-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=845 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1907240096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 07:26:32AM +0200, Christophe JAILLET wrote:
> This should be 'wm8955_pll_factors()' instead.
> Fix it and use it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
