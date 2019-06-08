Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8F4C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B83212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Pk6LMajv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfFHKSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 06:18:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48126 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfFHKSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 06:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559989092; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KUQLjrAOvjvJfesX2HDcpdGh78xdgRPto1xLrzipejE=;
        b=Pk6LMajvOH32ftZaRnS5AzfvNtd6TuFdYUv65J4LPYH+nrGIpyCDWm6/0vYypQHkQuEisv
        /P689Sc6YxxPZSyJROO/zrMvgoOPK81buU72w0kD1+L1YgfNX4EabhSoye+WKmfBhjYQf6
        vcrLgM1+EFqVUPuAKQXMxGlymhaCNp4=
Date:   Sat, 08 Jun 2019 12:18:07 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/5] clk: ingenic/jz4740: Fix incorrect dividers for main
 clocks
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me
Message-Id: <1559989087.1815.2@crapouillou.net>
In-Reply-To: <20190607210342.72D45208C0@mail.kernel.org>
References: <20190502212502.24330-1-paul@crapouillou.net>
        <20190502212502.24330-2-paul@crapouillou.net>
        <20190607210342.72D45208C0@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven. 7 juin 2019 =E0 23:03, Stephen Boyd <sboyd@kernel.org> a =E9crit :
> Quoting Paul Cercueil (2019-05-02 14:24:59)
>>  The main clocks (cclk, hclk, pclk, mclk, lcd) were using
>>  incorrect dividers, and thus reported an incorrect rate.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>=20
> Applied to clk-next
>=20
> Did these "Fix" subject patches need a Fixes: tag?

In theory yes, in practice this fix requires patch [1/5] to be
applied as well and there has been a lot of changes made between
the introduction of the file (which introduced the bug) and this
fix, so it wouldn't be easy to handle.

=

