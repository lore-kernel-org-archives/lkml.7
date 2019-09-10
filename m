Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09BAC49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E1C2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568127209;
	bh=pUryn9WqGUSNogBctTeoXa0sx1NkQRLY6uysdLw32VE=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=uefz00WitWedongLksyeEp0hsd61ahv9DUt8XqLwXUoiyZJLGOSXdSUtbK6CGa3u4
	 NE0G5F+7Wel+jq1/9EngRGV8b/UUdfzJGQIyOvCeu0o3cLFhZSU/w0E6nbWnVQpvib
	 ovkS6gGwjGxAU7zUE0vZYPJdFdbXIcvEfJhvjbYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393726AbfIJOx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393693AbfIJOx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:53:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946A621479;
        Tue, 10 Sep 2019 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568127206;
        bh=pUryn9WqGUSNogBctTeoXa0sx1NkQRLY6uysdLw32VE=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=IlqPaKo38YOb2bnVgeiWP3n/6PBesSjcaF3Ce3yIjfRwyOS7TENRbKaIcHPgVcXYY
         PtXdZb8ZfSNUjQteNvvXvH941h5CcXAK+feuiNSlBOmVbzrxmxop0lPnVaHDtCQw9j
         3CoQO6FteCUAU+89CWR1bJcwP916ja1Nx1pCdyo4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566206502-4347-11-git-send-email-mars.cheng@mediatek.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com> <1566206502-4347-11-git-send-email-mars.cheng@mediatek.com>
Cc:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        mtk01761 <wendell.lin@mediatek.com>, linux-clk@vger.kernel.org
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Sean Wang <sean.wang@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 10/11] clk: mediatek: Add MT6779 clock support
User-Agent: alot/0.8.1
Date:   Tue, 10 Sep 2019 07:53:25 -0700
Message-Id: <20190910145326.946A621479@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mars Cheng (2019-08-19 02:21:41)
> From: mtk01761 <wendell.lin@mediatek.com>
>=20
> Add MT6779 clock support, include topckgen, apmixedsys,
> infracfg, and subsystem clocks.
>=20
> Signed-off-by: mtk01761 <wendell.lin@mediatek.com>
> ---

Applied to clk-next

