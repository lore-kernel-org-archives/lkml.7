Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE53C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34352173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZlCO6Zlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfC1HyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:54:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60290 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfC1HyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:54:10 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4005C1EC0229;
        Thu, 28 Mar 2019 08:54:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553759649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6HnfRN/bKdOpb3oMSu3Emlmk5ZXRtddauuhBvskztAk=;
        b=ZlCO6ZlbsMD9LtdyPHnO2YpmwGCWheJrRqh8xMszJH4ZmFMx+0tDBXqtVHPYeqyfPmBwg7
        ad7Wgf9sEfVDO3iLvQHmubj48VvWsElCEIiwhSR/j6fhxbIGNf7JbpAmZ8JFTYv46pTGgx
        CyTVxkqCub5FtBt6GnMaQLE9oexqf7U=
Date:   Thu, 28 Mar 2019 08:54:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/9] EDAC drivers for Armada XP L2 and DDR
Message-ID: <20190328075411.GB22720@zn.tnic>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
 <ddd4d4738bf2484e8d13e6bc59cec6d8@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddd4d4738bf2484e8d13e6bc59cec6d8@svr-chch-ex1.atlnz.lc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:05:45PM +0000, Chris Packham wrote:
> Hi Borislav, Russell,
> 
> This seems to have fallen off the radar. Is there anything stopping this 
> series from being merged?

I was told this is not going through my tree and so I gave Reviewed-by's
for the EDAC bits.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
