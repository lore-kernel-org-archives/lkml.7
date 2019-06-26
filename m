Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0C5C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37193216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561574091;
	bh=WjGB0eiWQn5FUh3OK8rEyzBNxU/rZ51gQaiaGETiBF8=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=BtJvQs1Np9D25s15tljdKRYkQ2FMNk6v8s6j1zQtbY9ttWgZzHJLf8LlBb/WAmQeh
	 hHp7GbS6D1fw2+/jjd1wDGG2pMUQm5OO/5v6PL737u1xwbYGaPDt5jTH9RPUMVdezb
	 WPeCLJRyeB55Y85wIn+SXSavTIzE74QFfJssWHYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfFZSet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:34:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfFZSet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:34:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C47B216FD;
        Wed, 26 Jun 2019 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561574088;
        bh=WjGB0eiWQn5FUh3OK8rEyzBNxU/rZ51gQaiaGETiBF8=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=lKYo/7yWYJiNUYnbY8N8lmL+9CYor2vU0UmkTOKms3YvPV6/mv47ECbrfziZjqjyX
         yIItidnyt2bxrhZlBBBJ8YBTfwUfp2uWSMxF5Rhc8VytdCnIPhaI6C8+rSpX/Hr6gj
         Qg3eEJkoiwXGhwfpWvnr+xRe0ZSZcJse5Gig/2fA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1558433454-27971-2-git-send-email-claudiu.beznea@microchip.com>
References: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com> <1558433454-27971-2-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 1/4] clk: at91: sckc: sama5d4 has no bypass support
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:34:47 -0700
Message-Id: <20190626183448.2C47B216FD@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2019-05-21 03:11:22)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> The slow clock of SAMA5D4 has no bypass support thus remove it.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

