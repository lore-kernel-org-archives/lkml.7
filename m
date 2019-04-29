Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8181FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E552075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 22:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556578762;
	bh=/wNr8VsiG03XlgiYJ3PW0ej3WrLq3I5p2va/dtfT1eQ=;
	h=In-Reply-To:References:From:Subject:To:Cc:Date:List-ID:From;
	b=DtJe9BDIhNfE8H98c7cxlbPnJTi1/XTKqso1myuSl/fzF/gUrON6IL9FWORb65sit
	 /nCDVTdV/o0El1CxcwvURhCHAdstMPlxD8w1cDp6qTZd39ZFozkx33wat4Q8qlejRs
	 Ucqa9RdjfDno1ufX5hW8GrI4fDTpIBlJ2lgyzdGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfD2W7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 18:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729603AbfD2W7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:59:20 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9852075E;
        Mon, 29 Apr 2019 22:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556578760;
        bh=/wNr8VsiG03XlgiYJ3PW0ej3WrLq3I5p2va/dtfT1eQ=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=zvnvOknTP6/WjClt+yysNR0aev+4bazA60BfGQcM0sRt0xjk74yCtqqLWPOGHBtpR
         Ja/+pbEHNUeKO9gNPv97yG6aoIBPvMh1z7w/WJarvG/ijOh8yWOIjSVW/OA/SyKbNJ
         UWTWI6aw72jedO4rwzggGY5nqWhq/G1ZV/sXOa9o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556571191.1721.0@crapouillou.net>
References: <20190417112420.3034-1-paul@crapouillou.net> <155562472561.15276.17918796624287416345@swboyd.mtv.corp.google.com> <1556571191.1721.0@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ingenic/jz4725b: Fix parent of pixel clock
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-ID: <155657875909.168659.9064792203031956186@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 29 Apr 2019 15:59:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-04-29 13:53:11)
> Hi Stephen,
>=20
> Le jeu. 18 avril 2019 =C3=A0 23:58, Stephen Boyd <sboyd@kernel.org> a=20
> =C3=A9crit :
> > Quoting Paul Cercueil (2019-04-17 04:24:20)
> >>  The pixel clock is directly connected to the output of the PLL, and=20
> >> not
> >>  to the /2 divider.
> >>=20
> >>  Cc: stable@vger.kernel.org
> >>  Fixes: 226dfa4726eb ("clk: Add Ingenic jz4725b CGU driver")
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >=20
> > Applied to clk-next
>=20
> Could you drop this patch?
>=20
> It turns out it is wrong and the pixel clock is really connected to the=20
> "pll half"
> clock. The real bug was elsewhere: the "pll half" clock does not report=20
> the correct
> rate. I will send a patch for this one later.
>=20

Ok. No problem.

