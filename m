Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99446C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556043910;
	bh=mUob3HIl3gndsyR1iLcVzKL4U93DGYlMUnnCuNGylyY=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=C17SuCQqRpYW6ePj6YqnSwJFlu7dt8b4tCI1wDPY2m8pGANPzpNVNwCenHuDvOny2
	 Cn/MGbHInsLE7LAF26+A2b9qcADQo+u7fCven2pXMPUwR7ublH/X8+/zG19looYm/r
	 A0WPgYtuR+CPlTUAPLBCicbVDfKRiGRuvHUxXrmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfDWSZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWSZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:25:08 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE776208E4;
        Tue, 23 Apr 2019 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556043908;
        bh=mUob3HIl3gndsyR1iLcVzKL4U93DGYlMUnnCuNGylyY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=zcYFIFI1I2s8fZg3JyG3iueGgqtwdECfgGu4Wd9Bqy04UasCOf2zzxu33lMY+X/W0
         iRdX0bM7n3zJHSM5DYLxLgJnMJKY5yMDKYA5B2GUDMGeWbQ4hMiBgYm/rCpkowYXI2
         aNRW9Osrp2khw8vEE5pXULiBEizqtBneWpX1R408=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190423091503.10847-4-narmstrong@baylibre.com>
References: <20190423091503.10847-1-narmstrong@baylibre.com> <20190423091503.10847-4-narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 3/6] clk: meson: g12a: mark fclk_div3 as critical
To:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        khilman@baylibre.com
Message-ID: <155604390724.15276.2042141881910266821@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 23 Apr 2019 11:25:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2019-04-23 02:15:00)
> On Amlogic Meson G12b platform, the fclk_div3 seems to be necessary for
> the system to operate correctly.
>=20
> Disabling it cause the entire system to freeze, including peripherals.
>=20
> This patch patch marks this clock as critical, fixing boot on G12b platfo=
rms.

s/patch//

Usually we don't say "This patch" because the voice should be
imperative. From submitting-patches.rst:

 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
 instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
 its behaviour.

