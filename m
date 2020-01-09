Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD87CC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ABF2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578561493;
	bh=SptgEpC6uBoCgIiwV8qQCok3tqCD2QV/W7Pb1LSHw4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DsUmP3hvkPjKc5qCerMGLeGbDpHmjt97XONlZSPmjbaxeEZr5YEA49kSr/N1F1caS
	 3cb3KlHP7ug0goa6akD+UleBi/Nq16Ww4aooW/dcORSNF4HSilg5oSm9bBlPexMXCk
	 jw+maA7+cfi3YiZdHDEuxJAZ/0SEcIYlIQdkZiWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgAIJSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgAIJSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:18:12 -0500
Received: from T480 (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDAC206ED;
        Thu,  9 Jan 2020 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578561491;
        bh=SptgEpC6uBoCgIiwV8qQCok3tqCD2QV/W7Pb1LSHw4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQ/5B9lgXSzYjka9B4bj6vKedRzeeydEOcjwX9NXHRKjsE6taNt9sGg5YYlY/NxMK
         QDGKoGxdmrsirdwC9qeE+OsStInPBdnQz04lKZpUfrkV793gmc0Rk1veZhWTRFThHF
         VUgz83tCglEcNJXdYuS0eQ79VlUG46uck9wDLXB8=
Date:   Thu, 9 Jan 2020 17:18:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joris Offouga <offougajoris@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] ARM: dts: imx7d-pico: Add LCD support
Message-ID: <20200109091800.GL4456@T480>
References: <20200101235719.21466-1-offougajoris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101235719.21466-1-offougajoris@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2020 at 12:57:18AM +0100, Joris Offouga wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> Add support for the VXT VL050-8048NT-C01 panel connected through
> the 24 bit parallel LCDIF interface.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Signed-off-by: Joris Offouga <offougajoris@gmail.com>

Applied, thanks.
