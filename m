Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32500C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35E32186A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013784;
	bh=mRAtumr2P7rdLJ1lOMzEBoLNKvE+b5PIYcMk60mOUYs=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=dUwBmL5PIes4oTb8UhFLAPPyDRK81szPQGw4yGY/YRhMfv/PH4V3K4pYda6sbPaWk
	 bRKajtHg9a79FGtoBRNHAb6r0CetZATDD7pCZhGzW5Swo96PDjEnMhxoDLRLAmRKUR
	 9EVSp3ccOjkOjeSbq0uA93+DMDINgrBWGnCaRQsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDKUQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbfDKUQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:16:21 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C052E20850;
        Thu, 11 Apr 2019 20:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555013780;
        bh=mRAtumr2P7rdLJ1lOMzEBoLNKvE+b5PIYcMk60mOUYs=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=FI3BFwBozTe4SoaU5U/LCJTcZH2YXCiPs+AIIYSMp+ZaAyvB424iUhpNaYilxPtcx
         g46L5GH/S2QOXiUtP1/0Einv5PzzKUJgKj0wsFthm5bGTedupEgdbprfjiqlsCBpW0
         mi1a1O5i9DvbAE+BhMtX1JpWjDbdbqZJeScC4kt0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190305050546.23431-4-weiyi.lu@mediatek.com>
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-4-weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 2/9] clk: mediatek: Add new clkmux register API
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Message-ID: <155501377988.20095.3921794940086690412@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:16:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-03-04 21:05:39)
> From: Owen Chen <owen.chen@mediatek.com>
>=20
> On both MT8183 & MT6765, there add "set/clr" register for
> each clkmux setting, and one update register to trigger value change.
> It is designed to prevent read-modify-write racing issue.
> The sw design need to add a new API to handle this hw change with
> a new mtk_clk_mux/mtk_mux struct in new file "clk-mux.c", "clk-mux.h".
>=20
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next

