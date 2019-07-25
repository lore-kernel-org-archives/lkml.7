Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD05C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C489320657
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564088781;
	bh=p9mkR+Gdya905GgF0OyxisK0iTc8hQ7GlRutorMJ5pE=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=Wfr0IxF6y4Yk9P6Zmqwfv0iBVgAwO4Pjlm5eBP2pJrJqiTlnzfY6X4BT1pf3ny+La
	 VpHt/dS8RVTwigEyuvhHyrMHQEyRnLR1JRM3WRwgbTRVUDKKjxv93alu9Agaxuc8Mt
	 ysJaaIxLr717Um4AF+oLoCZEzl1Lpkrvsh3+f0f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGYVGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfGYVGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:06:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB94218D4;
        Thu, 25 Jul 2019 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564088779;
        bh=p9mkR+Gdya905GgF0OyxisK0iTc8hQ7GlRutorMJ5pE=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=pKTUTK6hmPaKykMz9Qjb8U43546SkjbmPc8Q6/eBQjtMDjax1X3BgKkVh1OGf2uBB
         bLwg+IEEm2nsJbEBbIH1w4cuy9y6AFZnNfggnKbgp8lBEp6NiVnlVoV2kSfu8bzt0i
         QWs9zgZrowICLTcVp8pEaREIz4IFTntCfQqjBS1Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190725020551.27034-1-Anson.Huang@nxp.com>
References: <20190725020551.27034-1-Anson.Huang@nxp.com>
Subject: Re: [PATCH] dt-bindings: clock: imx8mn: Fix tab indentation for yaml file
To:     Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Cc:     Linux-imx@nxp.com
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 25 Jul 2019 14:06:18 -0700
Message-Id: <20190725210619.5EB94218D4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson.Huang@nxp.com (2019-07-24 19:05:51)
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> YAML file can NOT contain tab as indentation, fix it.
>=20

Would be nice if checkpatch could check for this.

> Fixes: 6d6062553e3d ("dt-bindings: imx: Add clock binding doc for i.MX8MN=
")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Stephen Boyd <sboyd@kernel.org>

