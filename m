Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBE2C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DDE217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561574100;
	bh=XLEnNoUAsGUJ0QBlPQtENLCW/6HuN5q7wUSOYGLoZl4=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=XxlvdVaMWtDKVvXTnv6IyxokYxbAwxzB5sd2MDDxKZIVu9egL+u55RbHImIvUg653
	 wf8WOJ3TmfRv/XDZ2t138u8v+MGyX66xEiglG9zR6oWEruUhQse9ebQdEuJDU51t7B
	 5RU3nOEMES/6bP2GSsFpxvRpwjOGmGuoGqzPXR8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfFZSe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:34:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbfFZSe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:34:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F641217D9;
        Wed, 26 Jun 2019 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561574096;
        bh=XLEnNoUAsGUJ0QBlPQtENLCW/6HuN5q7wUSOYGLoZl4=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=s8DXmLRaw2CnrqC/dqK6kKixGaRtktUDwD5ge5T7cBRfW0NLt1zDaop4bAQiWSpUB
         w1wRP5GfYpzAlBfw0p6Ckj1KoSHvrMNHZOkKDGqmkYO0Q7nl2IvurhzvjYm57G+aTx
         Iyu/2wbaiCpW6iMtb7B/rF2RxId9IjXqMoVUw6FA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1558433454-27971-4-git-send-email-claudiu.beznea@microchip.com>
References: <1558433454-27971-1-git-send-email-claudiu.beznea@microchip.com> <1558433454-27971-4-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: clk: at91: add bindings for SAM9X60's slow clock controller
To:     Claudiu.Beznea@microchip.com, Ludovic.Desroches@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu.Beznea@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 26 Jun 2019 11:34:55 -0700
Message-Id: <20190626183456.0F641217D9@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu.Beznea@microchip.com (2019-05-21 03:11:29)
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Add bindings for SAM9X60's slow clock controller.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

