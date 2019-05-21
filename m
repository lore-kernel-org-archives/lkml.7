Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD13C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA73217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558463700;
	bh=h6QMBPaQJ9YaytqpgsgQE/jdYbpm7zZS+J6xihNl3uc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=a7KMbJXSZQGVQG2ca6Sucbi8jc+RCYms81usuFVYI5PvYeUMp/+DcUHHmRCD+jWYI
	 MUvZoeXvTPtQLGMV6bksblkOrxKiTOYsiiwsPExBy6ygdvweWm8CLUUO0MFOuHBpW0
	 c3nSlOxhdMvu+GyvJrQR9lL2lyBDJ9jw7J5n6nZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfEUSfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 14:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfEUSe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:34:59 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031D22173E;
        Tue, 21 May 2019 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558463699;
        bh=h6QMBPaQJ9YaytqpgsgQE/jdYbpm7zZS+J6xihNl3uc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sjLGkhCL+6CNctT+nhppZVHDDEgcqXJhArozSlipyDH2C+UGfFJOeUJONbchPrrY8
         NnZc0hEFDhjUWchObZB1iK02IZGnHKzuzz28tdEqIK9x9HCkiglnIwWuBCPWHjlo87
         xUH2qf4/zRl92Gqfbg1BllN7kb1qmZXCE6tCZOoE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190513213001.23956-1-paul.walmsley@sifive.com>
References: <20190513213001.23956-1-paul.walmsley@sifive.com>
Subject: Re: [PATCH v2] clk: sifive: restrict Kconfig scope for the FU540 PRCI driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>, mturquette@baylibre.com,
        pavel@ucw.cz
User-Agent: alot/0.8.1
Date:   Tue, 21 May 2019 11:34:58 -0700
Message-Id: <20190521183459.031D22173E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Walmsley (2019-05-13 14:30:04)
> Restrict Kconfig scope for SiFive clock and reset IP block drivers
> such that they won't appear on most configurations that are unlikely
> to support them.  This is based on a suggestion from Pavel Machek
> <pavel@ucw.cz>.  Ideally this should be dependent on
> CONFIG_ARCH_SIFIVE, but since that Kconfig directive does not yet
> exist, add dependencies on RISCV or COMPILE_TEST for now.
>=20
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-fixes

