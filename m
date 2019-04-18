Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A50C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDA4217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555624728;
	bh=lNzdAAlC/4nnO4StMTccs0mg9KayI+qevMsRh4hYaQs=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=QtcOPDQlFDzZ/3ZbOEaxwXcaUTkryWGIVLzSjZf2pKDltQJKJlEsBjBUXkpeBVxn/
	 J6d1qgbeZn+jJC0PotTrRsxGAPwnKp/4OT6jNc8+0MLvmLA2HgLrO70hG3L8k9gySB
	 BvsSMFmJ4PLWehMnx3pCMu/kZ0r0CwoKSrp4XeIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfDRV6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfDRV6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:58:47 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4B3205ED;
        Thu, 18 Apr 2019 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555624726;
        bh=lNzdAAlC/4nnO4StMTccs0mg9KayI+qevMsRh4hYaQs=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=r5iKYhKUrNjqqs6oLxvDFXGS/nDMsX2Zi07BM1C4oa4QSUQsbVuHEpSjnJ/7wjtAE
         I7UuFgpBsvhFUDfWPO436nYi4AEL9h/LDSvqZ1kNsOoHAPHj8ibgjJy9S9NNLVT/xw
         WqpcoiU0xXzFNgQQnP43ngMLnpNCbT4iMKrjRX9A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190417112420.3034-1-paul@crapouillou.net>
References: <20190417112420.3034-1-paul@crapouillou.net>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>, stable@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: ingenic/jz4725b: Fix parent of pixel clock
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Message-ID: <155562472561.15276.17918796624287416345@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 18 Apr 2019 14:58:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2019-04-17 04:24:20)
> The pixel clock is directly connected to the output of the PLL, and not
> to the /2 divider.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 226dfa4726eb ("clk: Add Ingenic jz4725b CGU driver")
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next

