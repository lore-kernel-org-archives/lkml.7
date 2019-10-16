Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF3FC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FE020650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EA00SE6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392245AbfJPKJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:09:17 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:43568 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727235AbfJPKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:09:16 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GA51sp009174;
        Wed, 16 Oct 2019 05:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wY7mAvj5F21+V86bnuE18PYzkAjmvRHb8mMHS3hceXQ=;
 b=EA00SE6Z2E3k7SYFmqLaahzFj9XBNXjotsuUm/KPxWHyilfAJAm5KZPxQmDDAJgrJUle
 gnJUdIu3m1gPVluI0VzrM0AX1MdVV/iAOspKE8s/QO1nKSpmsxQkQfyJoUEt4/lXWVew
 LF6SWzPJAJWOR2PKHdG4CaibjbMB8WtQqdgVSmrR41mibmFPlpRucfSj++0eq28ey8OI
 SMP0stSn8afBqt+M1O/iK/mZvq+3iAlZZUfF8bB3guzQMjGxX6mPTHo3W2v/TfMfmhz0
 qZU8xVquIHF32s7/MTVCNiLTmcVXo6jMXqbbLwD2Y03PXK3bCfQXNh10hu5x7koRn8j7 cQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2vkc83dbua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Oct 2019 05:09:06 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 16 Oct
 2019 11:09:04 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 16 Oct 2019 11:09:04 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AB4E92C1;
        Wed, 16 Oct 2019 10:09:04 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:09:04 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/36] ARM: s3c64xx: remove mach/hardware.h
Message-ID: <20191016100904.GC31391@ediswmail.ad.cirrus.com>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-12-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-12-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=942 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910160090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 10:29:56PM +0200, Arnd Bergmann wrote:
> This header is empty and conflicts with the s3c24xx version
> of the same file when we merge the two, so stop including it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
