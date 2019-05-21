Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE3C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871E221773
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558426287;
	bh=R/j36jSLiHEXOJzBJjaloAyDWROilV/KiZzl4mM07a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aH54FQKXAPXujZ+7tR+w4L7jaG/Mwzmvez72WP7WhvQGFgQU+5shyBmM2XzrvfWMg
	 Xfy6XdypEdh1XZgYYOqdS4O7bWv90WKCpkDGq82dF5y6ACWTxirGYY4ZMXShm7Nb2/
	 CY5MZXRwMF2OSLVkjxASYMVO5ohsiu32XA8moZkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfEUIL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUIL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:11:26 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147EA2173E;
        Tue, 21 May 2019 08:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558426285;
        bh=R/j36jSLiHEXOJzBJjaloAyDWROilV/KiZzl4mM07a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P8vEul29sPIfyx86SKdJcCNLlbSiqiT7O9SgaqlAk+k88va2mDO6SZvtNhTTAmCnY
         10v9oDtekAuqNtj3kE5T55uQ5zgqfM1OSJo6Kzl86ahfCdhTX/3R/D5yjQxJGESfID
         4s0IkGvxjRwSEqw+rFmMUXBcQk7ILVGdMYMi0U04=
Date:   Tue, 21 May 2019 16:10:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mq: Remove unnecessary blank lines
Message-ID: <20190521081025.GD15856@dragon>
References: <1557813807-3919-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557813807-3919-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 06:08:29AM +0000, Anson Huang wrote:
> Unnecessary blank lines do NOT help readability, so remove them.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
