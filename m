Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2E9C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C4C21D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573231079;
	bh=3Ekq/7qhTajQzrnHDXb+dW7Ske8+PbaGqH7NAXiJj0M=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=UQXs5+/hfnOFC84Iq7dVRqDK9vdE4/pWZYh5eh3M+aXBuiYqfVnBixxLI38JsvBQH
	 y8YD8fEH/1ngqOyS2qrHpJQs/TsJLphpstPvbrlepd/FP6K1Tvz4jTPgMxYDun17Bo
	 gEETM940UDYyAwVjIIW/+oDr93qD+ZjFUwl87pKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKHQh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHQh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:37:58 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7975821848;
        Fri,  8 Nov 2019 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573231077;
        bh=3Ekq/7qhTajQzrnHDXb+dW7Ske8+PbaGqH7NAXiJj0M=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=qx2pGn3PVAENYMQIU5/T7iaG7oVzvxYdKj2zLc8G1xVjv3vjwwhH9LmWxr3Id+g1c
         KtawCl8faKhNCCpM9mQpYK/K6nNl4cy5Tbqo2hPf0ri6u7Hx0RUc77h3WiDyyI8QYE
         wsbXkNRmVMvVclhPIYd/HRJC2HkdVoWW86/osHDw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190927185110.29897-1-steve@sk2.org>
References: <20190927185110.29897-1-steve@sk2.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Stephen Kitt <steve@sk2.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH] drivers/clk: convert VL struct to struct_size
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 08:37:56 -0800
Message-Id: <20191108163757.7975821848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2019-09-27 11:51:10)
> There are a few manually-calculated variable-length struct allocations
> left, this converts them to use struct_size.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Applied to clk-next

