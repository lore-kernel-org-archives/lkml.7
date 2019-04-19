Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B1C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18892183F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555711964;
	bh=a/VXLIklkviYSYE/CQuGoOf16Bek4mcUEHF6y3Cz0j4=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=eOKToBmkXoQhZKi3u+Ecd43nBvozgcKC3MHPXJVU6CE61fjwDovh1Ejy2SOjG/obF
	 tYKnYgoPiSMWF2bk4lHRSFULu11REmMGysJCdF0Lp45N/W+KeL/YDGCboSPdPtvYEz
	 3ttf/E9R89QVlWdul4XD4Oirts893P6AJ08a4uNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfDSWMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 18:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDSWMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 18:12:42 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C46F2217FA;
        Fri, 19 Apr 2019 22:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555711961;
        bh=a/VXLIklkviYSYE/CQuGoOf16Bek4mcUEHF6y3Cz0j4=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=0TtTha0kmCYjUpFfgAdoH27DzPDYeJ8O2nvIfrX7oJr4h0AsiRi7rlPHGy9h1Vup9
         GaCtBdUJIYhgpjEIaQGEeQiMJ/rdsKcwIMZ9r6M5mct8SOV0X+QFVZeN20XarjKknU
         LvXlsfAqdzoqqPdkm65OCFNsrSwZ1vACIM4psE+s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190412183150.102131-4-sboyd@kernel.org>
References: <20190412183150.102131-1-sboyd@kernel.org> <20190412183150.102131-4-sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 3/9] clk: Prepare for clk registration API that uses DT nodes
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Message-ID: <155571196102.15276.2085597206953871576@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 19 Apr 2019 15:12:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-04-12 11:31:44)
> Split out the body of the clk_register() function so it can be shared
> between the different types of registration APIs (DT, device).
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

