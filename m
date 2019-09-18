Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A8C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579B3218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 05:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568782843;
	bh=E3gLt8qy6bKN/iocSp2f2JOPT5gytsrkMuVkTEdMOw0=;
	h=In-Reply-To:References:Cc:To:From:Subject:Date:List-ID:From;
	b=q5lp7ja4FUThPQgVOeSiqKsPZm7MhAuFHZjJUytFCnWEvjW+rgz09PVgQAznOYd/G
	 QZo2TSE3t2OsGrHU4UTRc+IwtofPR/o7rvO31yVzNmaZfsDdaYT7usBX8jWHBWhnbC
	 eqeu4VKCfrt02Q+i/lThb+cmeKm/IXNTjsIDXM1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfIRFAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 01:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfIRFAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 01:00:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9387218AE;
        Wed, 18 Sep 2019 05:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568782841;
        bh=E3gLt8qy6bKN/iocSp2f2JOPT5gytsrkMuVkTEdMOw0=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=waAJ9pg/NbDoVo7cpYvXZNLttKJQHLqdoJlfBLTH+2IIspcr/e7dM8nsW4T+kguuX
         LBSuIdfoqS1WkWXrJlTje0Olfmmk/8qFmJi4jGUou3KugeR0EsY45EMoYDRG+xUFAn
         j8SqKrHdlZi+9wZrE+nkCTtKqapeTmtu6VuQW5+g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
References: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
Cc:     Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com
To:     Eugen.Hristev@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
User-Agent: alot/0.8.1
Date:   Tue, 17 Sep 2019 22:00:40 -0700
Message-Id: <20190918050041.A9387218AE@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugen.Hristev@microchip.com (2019-09-10 23:39:20)
> From: Eugen Hristev <eugen.hristev@microchip.com>
>=20
> The PLL input range needs to be able to allow 24 Mhz crystal as input
> Update the range accordingly in plla characteristics struct
>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---

Applied to clk-next

