Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F0C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217B821848
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qViWhYJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfHZNeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:34:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34872 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfHZNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:34:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7QDYRNM079246;
        Mon, 26 Aug 2019 08:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566826467;
        bh=tFtUvrneNrSqbCFtE8usIztfzaxK1LraQM5WctMkqTA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qViWhYJz73w0k2FAsMDL8ujwbOcYASgp3m1GuBVMPh1uZiEzi0UJJnhvIVlHCm8Ee
         jCNW+M3etAIjU1plruUGUd852YtG6WVqOcFJh8Jn/DpZ8jAGKpwDaMQWLZZFAFCg+Q
         fW+mnfGNcXN/IzBWLAdeBivW/vcVwbJRTGDR18zU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7QDYRIn107581
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Aug 2019 08:34:27 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 26
 Aug 2019 08:34:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 26 Aug 2019 08:34:27 -0500
Received: from [172.24.145.97] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7QDYOCH066831;
        Mon, 26 Aug 2019 08:34:25 -0500
Subject: Re: [PATCH] ARM: davinci: dm646x: Fix a typo in the comment
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        <bgolaszewski@baylibre.com>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20190722213657.27175-1-christophe.jaillet@wanadoo.fr>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <7f2fb9c1-cc6f-0244-1945-13a2b05080b8@ti.com>
Date:   Mon, 26 Aug 2019 19:04:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722213657.27175-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/19 3:06 AM, Christophe JAILLET wrote:
> The driver is dedicated to DM646x. So update the description in the top
> most comment accordingly.
> 
> It must have been derived from dm644x.c, but looks DM646 speecific now.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to my v5.4/soc branch.

Thanks,
Sekhar
