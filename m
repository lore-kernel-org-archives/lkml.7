Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA141C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E32053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JeFk7xcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732111AbfEOLqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:46:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59972 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731686AbfEOLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:46:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4FBk9X7066201;
        Wed, 15 May 2019 06:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1557920769;
        bh=ErZPSnkvpW1ltnGA1FPiw4W2WDwUubKfvtcFuldMMbo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JeFk7xcC5uF8iif4I2oxfzx5DC25I04BKsRowLeWGNJiOLKwhsC9BszWU9wc2hyhQ
         tmocg2hT+SJRAtzTALA3XtvHx+8ofLS4OlrR5xYHTThVMrti7e6vOhmHWmdoQOVKP1
         KGS+N7F+oBTZVQUNX7E3U2vBnMv5dM14Wt8DGKpM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4FBk9UR066924
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 May 2019 06:46:09 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 15
 May 2019 06:46:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 15 May 2019 06:46:09 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4FBk4qH020658;
        Wed, 15 May 2019 06:46:05 -0500
Subject: Re: [PATCH] clk: Remove io.h from clk-provider.h
To:     Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Tero Kristo <t-kristo@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Crispin <john@phrozen.org>,
        Heiko Stuebner <heiko@sntech.de>
References: <20190514170931.56312-1-sboyd@kernel.org>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <7d38658e-02f5-d6f4-ca66-5fdb57fb0352@ti.com>
Date:   Wed, 15 May 2019 17:16:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514170931.56312-1-sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/19 10:39 PM, Stephen Boyd wrote:
> Now that we've gotten rid of clk_readl() we can remove io.h from the
> clk-provider header and push out the io.h include to any code that isn't
> already including the io.h header but using things like readl/writel,
> etc.

For mach-davinci and drivers/clk/davinci

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
