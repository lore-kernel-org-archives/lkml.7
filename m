Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3AC00523
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB3F2085B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578208484;
	bh=kOXrx1wqEa/YU4lIH0OxdprB9v8RhMxQwy9bb/pK0gQ=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=OFpgRYCdf+0qPWcKjcp9REZ1QeRq2Dvzw4tZicTz8LMa6iywvLDdQHYsne69FqfRM
	 f59V2Wbl+6C6yG3uQCWAS8L9ZHxLm0oj2X9nbgnrFkUeZHT/IJ4QK1vmoDE01DhKbU
	 CdmoJLwH4G32sEyO4LPtRrfgYnu32d1olUrI095A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgAEHOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 02:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgAEHOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 02:14:39 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10452085B;
        Sun,  5 Jan 2020 07:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578208479;
        bh=kOXrx1wqEa/YU4lIH0OxdprB9v8RhMxQwy9bb/pK0gQ=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=H0FIKvn+Ai1x5HOYaGq5OBIo0Viyoj+P5TcI/toM3CSQQhWJ1/3rKDYZEP3yWOivZ
         HQnh7gXUzshpQ9o46RicBifMTSe6rnJcJQBphR2UqnzmsU7S2yrev5MTvWYxVunLL7
         m6ytha2jaet8zQT6A0bZm+kk9MFEck3iAM0UqYGk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1577410925-22021-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1577410925-22021-1-git-send-email-hayashi.kunihiko@socionext.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v2] clk: uniphier: Add SCSSI clock gate for each channel
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sat, 04 Jan 2020 23:14:38 -0800
Message-Id: <20200105071438.F10452085B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kunihiko Hayashi (2019-12-26 17:42:05)
> SCSSI has clock gates for each channel in the SoCs newer than Pro4,
> so this adds missing clock gates for channel 1, 2 and 3. And more, this
> moves MCSSI clock ID after SCSSI.
>=20
> Fixes: ff388ee36516 ("clk: uniphier: add clock frequency support for SPI")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to clk-next

