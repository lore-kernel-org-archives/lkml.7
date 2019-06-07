Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A9BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A473D208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 21:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559941428;
	bh=XptPgWM7duzib3Y8SMoyPoEGICDgeSCiM9TaPIq/I0s=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=y0xEDzWrOXnhIKsbm6sDUhZCjcJcp5XZBe6QrzIf8TdnmnABlYlJtvKgAt3SBdi9J
	 SXUkpup9gscvZZVyn4f0IrydNRrUJgFpxQdFxMEMd5XMbbZ45JntklZz1ec5bWJDPl
	 svMCucUXFOqyy2rGgdUp8haIbcPASJSTIqAe+2y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfFGVDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 17:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfFGVDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 17:03:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEF8208E3;
        Fri,  7 Jun 2019 21:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559941426;
        bh=XptPgWM7duzib3Y8SMoyPoEGICDgeSCiM9TaPIq/I0s=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=ZwftnHt4YClXvuvg7KTqfunPT/Mj4L6RX5KRDb5MQOXzKddQzLV2u87xzJAE7lilx
         glNdzoIRnJLWQT1OBx9DsOwYf54EUZuYk3ciuKYD3fr/Rx8nM/okgfCr/rEfwMrLcA
         7v3VADTlUVNOAwlZM1yLUJnwXGt1Sal0H6BUeAw4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190502212502.24330-1-paul@crapouillou.net>
References: <20190502212502.24330-1-paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/5] clk: ingenic: Add support for divider tables
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 14:03:45 -0700
Message-Id: <20190607210346.5EEF8208E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-05-02 14:24:58)
> Some clocks provided on Ingenic SoCs have dividers, whose hardware value
> as written in the register cannot be expressed as an affine function
> to the actual divider value.
>=20
> For instance, for the CPU clock on the JZ4770, the dividers are coded as
> follows:
>=20
>     ------------------

Applied to clk-next

