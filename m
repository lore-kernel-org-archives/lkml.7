Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD5DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD682183F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561574095;
	bh=6drANE0jdBR8TSbXn+6m0cELmaHGSwlfyabSGJEiOlQ=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=gOYYcE2AS+IT1ENp/UFs+ZZxZ9yNa1zvhfbgnw+NutvRtv0ISq45BBku/UQxhWgST
	 7NFsNYLQh+WGhuYsnG8/QtKLW3v220Bl75F8NQq/yXmrVBVQ2FImhx2Tacn075cQHK
	 dnmVLeAeR7kwYZHvqwK03MYGUIuN3gQoTm/gpO3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfFZSey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfFZSew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:34:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33B421738;
        Wed, 26 Jun 2019 18:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561574092;
        bh=6drANE0jdBR8TSbXn+6m0cELmaHGSwlfyabSGJEiOlQ=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=00ltJhESB5AzYaorZMI4UZtPZH5m2wTzAfVNf2PPYL+faguz48AA/v8MZt1AR5HD9
         O34DLXDK9wKigvsvXQAAWgzUdMlUv68sFIvjOO9QDz/PhR1dRned2rajKG9Cgw8jLB
         UCwakFRS43+p/KtQPtwHN07sfxESgsNQA6BdzmZ8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1558433454-27971-3-git-send-email-claudiu.beznea@microchip.com>
References: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com> <1558433454-27971-3-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 2/4] clk: at91: sckc: add support to specify registers bit offsets
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:34:51 -0700
Message-Id: <20190626183451.F33B421738@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2019-05-21 03:11:26)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Different IPs uses different bit offsets in registers for the same
> functionality, thus adapt the driver to support this.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next

