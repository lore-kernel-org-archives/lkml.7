Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161C2C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FD821670
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568127196;
	bh=ntFjl67nxoRyK8Sdto19vdllPdxmhbm0zE2ozFdj2D0=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=iAVNXwDMA63UirHfE9JitRyp0RmQkU+2gXhPx0UxAznOOiFMEarHTKA4gj2yGPj7x
	 f4Kqt41UmtygGMt/MOv37sH+mjTs/RTtsjrTRcvV1GbCzML7mXiGbvhF3iuRUkV9pw
	 lvKIBphVIJSrKdQSxLZHHagTJWdXBkksY7zPk7GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393670AbfIJOxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732106AbfIJOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:53:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1209E216F4;
        Tue, 10 Sep 2019 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568127195;
        bh=ntFjl67nxoRyK8Sdto19vdllPdxmhbm0zE2ozFdj2D0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=OQVRXs6Yol30TirIuzbeEzizXtcskMTz5Y3EZcqXs0JoyWTBFGJsaycxXx5pM188I
         j2Wtt2fib1CwZ+qmXl38NE4x1J+Ne6VqTYgu21MOP9ui84dHLe8+8z53k2ourCAPiq
         ejxfWbW5S6wfsIvAZ/sjMh0Hvzvb5QtR/2OSip84=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1566206502-4347-10-git-send-email-mars.cheng@mediatek.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com> <1566206502-4347-10-git-send-email-mars.cheng@mediatek.com>
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
Subject: Re: [PATCH v2 09/11] clk: mediatek: Add dt-bindings for MT6779 clocks
User-Agent: alot/0.8.1
Date:   Tue, 10 Sep 2019 07:53:14 -0700
Message-Id: <20190910145315.1209E216F4@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mars Cheng (2019-08-19 02:21:40)
> From: mtk01761 <wendell.lin@mediatek.com>
>=20
> Add MT6779 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, and subsystem clocks.
>=20
> Signed-off-by: mtk01761 <wendell.lin@mediatek.com>
> ---

Applied to clk-next

