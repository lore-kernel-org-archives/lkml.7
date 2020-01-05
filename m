Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFAC33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F532077B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 20:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578255172;
	bh=kspJUmG3uKOHAmWNzjXVVVINFU1WGAkYf7qWDFigURU=;
	h=In-Reply-To:References:Cc:To:Subject:From:Date:List-ID:From;
	b=U49KB68bAmHSWmFvRBTTEYEzEc4rWvgw6Cjo8r6GqgndPguTVJprcK20ukwniVpGU
	 OavNUJTDohv8W70rFYLfazbooyVSSdPVUpS3ATSZIqPDfiNWdm+szOyHnBwMPs49US
	 EnggH9Km4y7LlPXYE5R1jFVoPx5iOJlt6kiXXRBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgAEUMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 15:12:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgAEUMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 15:12:50 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 572A22077B;
        Sun,  5 Jan 2020 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578255169;
        bh=kspJUmG3uKOHAmWNzjXVVVINFU1WGAkYf7qWDFigURU=;
        h=In-Reply-To:References:Cc:To:Subject:From:Date:From;
        b=KMuUhqtMcR+5j124aR7O2dwCooi9jFeKFtCQS8gh7cO0k6lmZrPTy3g4lKVrG2l4Q
         C9dNvuUmsiMi26gdU2fGo2MWZ/2FuAPuHIb0UUohWeaQUQSTrfHJenWr1rFLMzwRLm
         tQ+EsmRgI3dFuFk+BPMsW20ZC8l3CvdBefV9ha6g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191128144450.24094-1-info@metux.net>
References: <20191128144450.24094-1-info@metux.net>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] drivers: clk: unexport clk_register_gpio_gate()
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Sun, 05 Jan 2020 12:12:48 -0800
Message-Id: <20200105201249.572A22077B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Enrico Weigelt, metux IT consult (2019-11-28 06:44:44)
> The function clk_register_gpio_gate() doesn't seem to have any users
> outside clk-gpio.c, thus unexport and make it static.
>=20
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---

Is any of this patch series relevant when [1] is applied? I think I will
just apply that patch instead.

[1] https://lkml.kernel.org/r/20190830150923.259497-2-sboyd@kernel.org

