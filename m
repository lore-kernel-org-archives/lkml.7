Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B0AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A917820862
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574791631;
	bh=ukgWnmGQzCzE6sryHIB1yDKl2aQhLn1xmnuj22IBIbc=;
	h=In-Reply-To:References:Subject:Cc:From:To:Date:List-ID:From;
	b=LFpEOCRcYm16IauUcgdB74y4KrOSi+OgiMOIru8Cu9qisQeM9HsGvHXi5gjNVihfa
	 sLxADw0T6x/YWAWqdZGMcfU57Z3mT00+dAtuHckRbc7bIO5tEkWumbqSNbKMFfxTw4
	 1GdvAe9noIRQm7GQIykZ5XbvE8jxF/DXR+IHh3GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKZSHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfKZSHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 13:07:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CB3D20835;
        Tue, 26 Nov 2019 18:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574791628;
        bh=ukgWnmGQzCzE6sryHIB1yDKl2aQhLn1xmnuj22IBIbc=;
        h=In-Reply-To:References:Subject:Cc:From:To:Date:From;
        b=e+owu4vKbRrftjQI1Tv2btHxzhjiZStkM/W42QFM7hc/eO7TI4vORLvWihjezpckP
         DECwd/7g89GID1nT3F7CxNNEZIdUPubLdynfOj6JR5j5DGGP+FFCvj57A7KJ472rlK
         3EcXSja+kBtUUIZl+rHVKGwvLyTPyn/4kwKlO31E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191115162901.17456-7-manivannan.sadhasivam@linaro.org>
References: <20191115162901.17456-1-manivannan.sadhasivam@linaro.org> <20191115162901.17456-7-manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 6/7] clk: Add common clock driver for BM1880 SoC
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mturquette@baylibre.com, robh+dt@kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 26 Nov 2019 10:07:07 -0800
Message-Id: <20191126180708.4CB3D20835@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manivannan Sadhasivam (2019-11-15 08:29:00)
> Add common clock driver for Bitmain BM1880 SoC. The clock controller on
> BM1880 has supplies clocks to all peripherals in the form of gate clocks
> and composite clocks (fixed factor + gate).
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Applied to clk-next

