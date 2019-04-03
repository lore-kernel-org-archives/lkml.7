Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33DCC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788C221473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554282892;
	bh=GJB+gVTbTg05re/OdMC/st+WTlhT765qsRoqYLMhxhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ir+iKuneOvp9+xz+7BIZxAUBxsIED4g0Mna54PDkdRneXzsXEKymAYat3XS/kQeTP
	 Aud7LAPMiPG22xB2VvEZlxj9boVhdB4cxdtHyd3qlrnN1SBWeWC2MY3P+qRjyGY6Cf
	 66sg3uKgrrUfRweb1/zRsAh4HF6SL2g84MNuVmu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfDCJOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfDCJOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:14:51 -0400
Received: from X250 (unknown [147.50.13.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1690220830;
        Wed,  3 Apr 2019 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554282890;
        bh=GJB+gVTbTg05re/OdMC/st+WTlhT765qsRoqYLMhxhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzSgJkEKZZRdvSgP0MhqVJ0krI1o0vtZCmb45PJFjJHu3TrnVbLlAjLoDh65T10wO
         g+BSVlZ6+cJ+6coGRbR1p2JEnRi/S0Hnh5Tgr/yyx9sCiQkJV9pzCc5Hl4pdbbnbqv
         uyzo2TLwfvrrQE2n74EdIhjieShHUANx2Uu/mMEo=
Date:   Wed, 3 Apr 2019 16:14:42 +0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH v2 0/2] clk: imx5: Fix i.MX50 clock registers
Message-ID: <20190403091440.GB7932@X250>
References: <20190326182258.21945-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326182258.21945-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:22:56PM +0100, Jonathan Neuschäfer wrote:
> There are a few differences between the i.MX50 clock tree and those of
> i.MX51 and i.MX53 that are not yet handled in clk-imx51-imx53.c.  This
> series handles two of them.
> 
> Jonathan Neuschäfer (2):
>   clk: imx5: Fix i.MX50 mainbus clock registers
>   clk: imx5: Fix i.MX50 ESDHC clock registers

Applied both, thanks.
