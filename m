Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3317C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B75120862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kosd0lCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEOI7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:59:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46402 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOI7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:59:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4F8x9if014833;
        Wed, 15 May 2019 03:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557910749;
        bh=BacRUcskBltX/i52n+AsRzYrFd9sD+yl78NxjnBclHI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kosd0lCiXD8DfciWJXgCLGiMS3sPUTeM9UTJb7F+LGGGDWrRIhWRO52LCSzguBNxS
         b85NOQ30jcnHydbCZGnp0jGVCQGu7xqAaO7XpBTr1+2h6UGLIot4TIik4aTSdOVIMG
         HF1nzvt3kzN5eLChYNMwXGwVWVULMtyRjoK6Bp5g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4F8x8A8010345
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 May 2019 03:59:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 15
 May 2019 03:59:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 15 May 2019 03:59:08 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4F8x2MI071131;
        Wed, 15 May 2019 03:59:04 -0500
Subject: Re: [PATCH] clk: Remove io.h from clk-provider.h
To:     Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Crispin <john@phrozen.org>,
        Heiko Stuebner <heiko@sntech.de>
References: <20190514170931.56312-1-sboyd@kernel.org>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <a3aecc47-aa1e-bc12-2170-4c55b491f891@ti.com>
Date:   Wed, 15 May 2019 11:58:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514170931.56312-1-sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2019 20:09, Stephen Boyd wrote:
> Now that we've gotten rid of clk_readl() we can remove io.h from the
> clk-provider header and push out the io.h include to any code that isn't
> already including the io.h header but using things like readl/writel,
> etc.
> 

For drivers/clk/ti portions:

Acked-by: Tero Kristo <t-kristo@ti.com>
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
