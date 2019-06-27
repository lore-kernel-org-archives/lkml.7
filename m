Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81031C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51DFF215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561659767;
	bh=guphP16sdjxJw57d0MpWZHYmhSF7auBrRQTkXSawdqA=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=BSijm0zTJlhWNLS/o9UCtpgh9JAoGND05WguwtgoAmyiy1fvhjLOPhDfVvqJqbH6D
	 BOq0F8yDYba9t6zNBN39h0dVeQUKSCa0lAH2ubInSSQuw4/Q+ryoO32fcgTYrqQJjF
	 SCJfAJN4DQzESpwZcI7FSGSHL4JGrX5Ns923XSP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfF0SWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfF0SWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:22:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A072220B7C;
        Thu, 27 Jun 2019 18:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561659763;
        bh=guphP16sdjxJw57d0MpWZHYmhSF7auBrRQTkXSawdqA=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=HP4rllCr8QS4YXZ+7FghOiOP6+dk8qbD79JzOi6bCCJwNLuiepHTOf29btroY2M0R
         FD/vnSvVhhSz1uMxaqAjlauOLUUCpgVqErpmbr+M48RMweoIvIudaqCVSTw96lkg9d
         OhVIEO9xqDdF5htam48bsBMDwosaeBqedFrUawcA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561650825-11213-4-git-send-email-claudiu.beznea@microchip.com>
References: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com> <1561650825-11213-4-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 3/7] clk: at91: sckc: add support to free slow clock osclillator
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 11:22:42 -0700
Message-Id: <20190627182243.A072220B7C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2019-06-27 08:53:41)
> Add support to free slow clock oscillator resources.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

