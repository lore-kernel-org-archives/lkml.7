Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F43C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C459B20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217807;
	bh=deKls0fQBdhJFs54K06sUljJUzYFoPp0QAKvKNZBw1I=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=NfdWlMeHOE7ZOxOrps7mgrYvYuJKwLuLnUyODJ5/gKsoPuP9lBFmfAILlUZr33M8h
	 pVfQaR35si+EFyVXsbDLTvhwMPz5yiD43MuB2xw2iEqFghlfbw48s+FSO7kqsgx1uR
	 opWbPZwY91kcj5pWTgunWXYVT2aksoze5LyqrxkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfDYSn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYSnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:43:25 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C2220578;
        Thu, 25 Apr 2019 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556217805;
        bh=deKls0fQBdhJFs54K06sUljJUzYFoPp0QAKvKNZBw1I=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=k0CZKjOx0ZmOeCN7RTSMSj5hqk7iC+J79r1n1kmEenL4JXYn5xnAw6Wvan4jqrdpE
         EMrzqdAJipVL4L+//hdSu6gSuqnS/1olr+BF4C/lRvRzalm5nRiAjCABvRs8wTV4T1
         9XflyEnC4tMmdvyJ43MTiuSawvuClxssz1ytV28I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190219170200.3608-2-alexandre.belloni@bootlin.com>
References: <20190219170200.3608-1-alexandre.belloni@bootlin.com> <20190219170200.3608-2-alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/7] dt-bindings: clock: at91: new sckc bindings
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Message-ID: <155621780413.15276.1640957113449819563@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 11:43:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-02-19 09:01:54)
> Remove the need for child nodes in the sckc binding to be able to remove
> dtc warnings and have a more modern binding.
>=20
> Also document optional properties.
>=20
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

