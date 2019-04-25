Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80C1C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD43F205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556221043;
	bh=cK18oAzkW03Dfnk0ipy3tKF9lDvMKwlPmGujzTq3TFI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=RbPhO8zCSDdWmwEZEgFxSoMbJmw7eIvcI83sPPRRB/RK2UeS+Udn1UAEO9wPjm+x/
	 OnRJNOU3SFXfXho+NuY6uJ7fw9Li401D/gwBmCK6Vs8O75k0bqlxun6Up5mDDkyOSe
	 yWCdtYJ0dlFepYqGroWoYLsMNAgaZBdaw+euUugk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfDYThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfDYThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:37:21 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58D6205ED;
        Thu, 25 Apr 2019 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556221041;
        bh=cK18oAzkW03Dfnk0ipy3tKF9lDvMKwlPmGujzTq3TFI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=nKFuZARbiu9So8E+BxyiF+ccVyZUW9KhXLLwObpO2HkmfedZRS6SizrIdip5OMlkq
         r7BpxwRCZOMjIgW+0ugPmjZ8moGsYtNnht1JgCYIOJUwmRfiZv1f7E9SzswXKt6vvD
         vZf6o0OIQ42Sv9nUQp6pTCq3lCVvbGx2k3EllDqg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190402125056.21509-5-alexandre.belloni@bootlin.com>
References: <20190402125056.21509-1-alexandre.belloni@bootlin.com> <20190402125056.21509-5-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 4/7] clk: at91: master: Add sam9x60 support
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155622103991.15276.10665554788013885872@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 12:37:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-04-02 05:50:53)
> The sam9x60 cpu clock is located at a different offset but is otherwise
> similar to the master clock.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

