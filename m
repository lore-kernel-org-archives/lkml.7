Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED5C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9D020578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217816;
	bh=FF+5jRiHj8SitZvdG3ozQrEl3t+FqJqaGRLYGa4pPVU=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=qttpk76FAwLEwzooXpMyZDGZPgc9ZFjBg5qYXUnJ1f/3fYIGEabwxrm0trJ6xl2Xs
	 ZsXoF7N/XGhuEWxa7jMqFJ2rRRKxPenoI45m4eqJYuNsEjZPsi2LB/SPicr2+eJb+H
	 LROSSxF4azw1JwhMUj0bb7hXVZ6dM51uWFM5Uc6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfDYSne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYSnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:43:32 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C347020878;
        Thu, 25 Apr 2019 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556217812;
        bh=FF+5jRiHj8SitZvdG3ozQrEl3t+FqJqaGRLYGa4pPVU=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=JvFtD7JQ7Wp+bzkYsEZQg2cRPYsBxXVz5HagtjAkAf4lzlpCUl+VFukrrKOSZgnjT
         hxwpwR2OtpV79+SNHIojnJvdQVqVEHtiojGKfyF/RV72IBVryeti8IQxZmUbXxumij
         3mThWa14KLQ6bYoKtLfuXpYbV4z31d0Nq3lzowgQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190219170200.3608-4-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com> <20190219170200.3608-4-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 3/7] clk: at91: sckc: handle different RC startup time
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155621781143.15276.4599145179300992228@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:43:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-02-19 09:01:56)
> The sama5d3 slow RC oscillator as a different startup time than all the
> previous SoCs. Handle that using its own compatible.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

