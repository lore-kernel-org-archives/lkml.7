Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32EC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D77420872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 23:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559777600;
	bh=Z3tddQB2KosKS8slNYJZDj6XrnlD8q21sPK71MNMMsk=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=Bi4mjU5HmpZ6cIf+8YwyfGjXmvze2Nuuy3N8I3dpyUodSXeCJv8MPdPaSr3Xn+zKy
	 i/XQWpkvNbrSXXwzJBJwBaxZD99xT3YVe/7/5Drgq5pPR0/bqY2s6VvQNZk+iJrUdS
	 /id+3alLKTcD0iQPYYOYAKjkYmeI3/ZhK588ZmOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfFEXdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 19:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbfFEXdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 19:33:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06CE62083E;
        Wed,  5 Jun 2019 23:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559777599;
        bh=Z3tddQB2KosKS8slNYJZDj6XrnlD8q21sPK71MNMMsk=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=tPZr8Ui7o0n3eqomnLmPN3LKzIgBLT939aDKAzBV/YX19ItuCL8Dx9Yq6IeoEj1PK
         hCXYqWjBSoia4X1vANS7sLgrpOrpNfbU/q/42gitpFSMITnKrLtYpuAXp1D1WdfVhH
         Q2kldMWUVIvEsMA3p2mzFiYEiePFTu9fhqXn/HVw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190604015928.23157-1-Anson.Huang@nxp.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com>
Cc:     Linux-imx@nxp.com
To:     Anson.Huang@nxp.com, abel.vesa@nxp.com, aisheng.dong@nxp.com,
        bjorn.andersson@linaro.org, catalin.marinas@arm.com,
        devicetree@vger.kernel.org, dinguyen@kernel.org,
        enric.balletbo@collabora.com, festevam@gmail.com,
        horms+renesas@verge.net.au, jagan@amarulasolutions.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        mturquette@baylibre.com, olof@lixom.net, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org,
        will.deacon@arm.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH V3 1/4] dt-bindings: imx: Add clock binding doc for i.MX8MN
User-Agent: alot/0.8.1
Date:   Wed, 05 Jun 2019 16:33:18 -0700
Message-Id: <20190605233319.06CE62083E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson.Huang@nxp.com (2019-06-03 18:59:25)
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> Add the clock binding doc for i.MX8MN.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  .../devicetree/bindings/clock/imx8mn-clock.txt     |  29 +++

Can this be yaml?

>  include/dt-bindings/clock/imx8mn-clock.h           | 215 +++++++++++++++=
++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/imx8mn-clock.=
txt
>  create mode 100644 include/dt-bindings/clock/imx8mn-clock.h
>=20
