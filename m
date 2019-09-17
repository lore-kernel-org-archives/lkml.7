Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697D62171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568741272;
	bh=pWYWNjrafaEka3By8melCVwnYdQavo9zhE9xnRSmIVk=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=hLNf8GX3hsm4HYgyKBC+o6N3DrlqN/LnIN0q3u0ecMvHXdkdRGsWBsJMj2e9ecwaa
	 BR6mZc/5RABbwFftnvPU1UJR2yRpzUWTLcam7CDIAMnVRyrU6pa+8GlszCQGKbWNCT
	 FKG9r2kWbybpYlotCqYWMr5y6UsUO0N1EOEOjRoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfIQR1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbfIQR1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:27:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B20472171F;
        Tue, 17 Sep 2019 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568741270;
        bh=pWYWNjrafaEka3By8melCVwnYdQavo9zhE9xnRSmIVk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=G2Jj+/t30a67gfE+Kg/xxIZ2Aq4hyC/HJlnECTbsVXHqdcHC4Ay0hqkmAGy/jleRr
         jpB8fTxdORg5ggqS+QdpyiEkDZPKBg/qZlme0PyC+m7yxdiFClYNCCnVMBoGuFhz5u
         dUz/CYFGC99a4ErBP92E6xXWZ7Z3EPBbUA3HG0Hs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190820030536.1181-1-yamada.masahiro@socionext.com>
References: <20190820030536.1181-1-yamada.masahiro@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: add include guard to clk-conf.h
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 10:27:49 -0700
Message-Id: <20190917172750.B20472171F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Masahiro Yamada (2019-08-19 20:05:36)
> Add a header include guard just in case.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

