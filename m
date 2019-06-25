Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9EFC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AD72086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561499438;
	bh=GwgZoYHEjDqDV6/GDo7hMDaoiuZJidjKMue8bkbmYQw=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=T/itSG9+Fh+HuRpeNWY7gdsmUNP9nTnG/LbnANZElGvFCwcIzAAavmsEGUo9xNlZs
	 HvrxFWxMIvw2vrHEOSYOb2OijRTmBMr/d1JYDMiHTZuO825cDdz9EAPXCFBpQxkbz8
	 Sh5wLlzbv4cz7oa3bcd9WTt131yHDqiZpN2+6deQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfFYVuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFYVug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:50:36 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0698D2085A;
        Tue, 25 Jun 2019 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561499436;
        bh=GwgZoYHEjDqDV6/GDo7hMDaoiuZJidjKMue8bkbmYQw=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=cw7hMuw8Yh7yn6pgURC7S9h226i5Ed/QVj0CiLsHuJCLgxGNA+xUTPDlB0P36Hh/2
         fAwssMDQ2dDffRd2gl4wf3kSHL4EU+fZYrTZD2eV2/bLArpswzX2GIPimr1cI8YqXs
         VttiYWrTNS/BFhdymu+WJulhOByKWtCH5+hqLpP0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190617120248.9590-1-geert+renesas@glider.be>
References: <20190617120248.9590-1-geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Simplify clk_core_can_round()
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
User-Agent: alot/0.8.1
Date:   Tue, 25 Jun 2019 14:50:35 -0700
Message-Id: <20190625215036.0698D2085A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-06-17 05:02:48)
> A boolean expression already evaluates to true or false, so there is no
> need to check the result and return true or false explicitly.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next

