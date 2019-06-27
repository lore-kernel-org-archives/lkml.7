Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D6C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFDC2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561659780;
	bh=Y0Fl2Nxpsu4kj3e7DJFj+miEUh5oLQ4rbqFOGlMLKck=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=nbw+SNjOYV3y/nrLdreacT2Ghekv9ZfsRHslWs95WSIHP53F4yinwrpmuKpprsasC
	 FdIUeuivCnomdMtegStjeYggdP3hTMpaDd75PtrfvNodo4M+bWeIUjVxrJdGGQwb81
	 7Ohqf/83lJWK8iVrAQUVgnVGRSqhmHnDUvOsmwCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfF0SW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfF0SW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:22:57 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADFE2146E;
        Thu, 27 Jun 2019 18:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561659776;
        bh=Y0Fl2Nxpsu4kj3e7DJFj+miEUh5oLQ4rbqFOGlMLKck=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=xuylJauEltJrNFG1eEF535RvIctAo5FKK0y9Z4xYP407i2hXIvpOoDqGUbhKOVvSP
         nnWZs+Sucmior1JpKmksL2+AYIfezrROHHQcfvLvPxFusSk5kNbeYwGmt58rm9zr2Q
         rS7QRlrzvyNh8MOBvfOIHLwBQyi8teWhDdEWBhtY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1561650825-11213-8-git-send-email-claudiu.beznea@microchip.com>
References: <1561650825-11213-1-git-send-email-claudiu.beznea@microchip.com> <1561650825-11213-8-git-send-email-claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 7/7] clk: at91: sckc: use dedicated functions to unregister clock
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
User-Agent: alot/0.8.1
Date:   Thu, 27 Jun 2019 11:22:55 -0700
Message-Id: <20190627182256.6ADFE2146E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2019-06-27 08:53:45)
> Use at91 specific functions to free all resources in case of error.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

