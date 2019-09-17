Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56935C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8DB20640
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568740997;
	bh=1nkPyDmw3M1xYDQWHb5QNUaZfBwrP0Luz7WD0s9GULA=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=ecib8afdfEQvdNSaLHH2qvd9ktysHe6VkHoXId1Xp0KTdqlTCd6Egvd4N0+1nHC79
	 h9EDBhBAzS9sTmhzs8ej+bWi35dymmKkGmX9kzQOwQGdpSBJiJJWpb02r+9ST+tXQt
	 bWpAkK5VIrixjvU6ckL33XEqHQHcn0emF9gPZ0yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfIQRXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 13:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfIQRXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:23:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2765214AF;
        Tue, 17 Sep 2019 17:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568740994;
        bh=1nkPyDmw3M1xYDQWHb5QNUaZfBwrP0Luz7WD0s9GULA=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=bDAnYw3nkBrEZndtfMdLUcO2bf5o52dcBnEkQxZ5Pv1zGEEPPbLK9R6d7RnCzb39U
         c7gPNh5gBUV4tTajhym0rdxLnJ/F3FReZ3ScYeekkHyTl7lkO33qof8aPtXC76Lugv
         c1gKIbd6ysUW+B+32ZWATm6nO5Q2908ffjcuk0sQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1567414859-3244-3-git-send-email-weiyi.lu@mediatek.com>
References: <1567414859-3244-1-git-send-email-weiyi.lu@mediatek.com> <1567414859-3244-3-git-send-email-weiyi.lu@mediatek.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>, Weiyi Lu <weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RESEND PATCH v1 2/3] clk: mediatek: Runtime PM support for MT8183 mcucfg clock provider
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 10:23:14 -0700
Message-Id: <20190917172314.D2765214AF@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2019-09-02 02:00:58)
> Enable the runtime PM support and forward the struct device pointer for
> registration of MT8183 mcucfg clocks.
>=20
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Applied to clk-next

