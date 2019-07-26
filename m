Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C70FC76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2780D22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564177028;
	bh=CYH+0u4ay4mcNfJRo5I8rigGJXkfv7dQBLwaCsxvPEk=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=ZukfGvF0FFBDsOWG78Wz7lErtwZ3HdicMrGbkrPlBJxk+BnHOlSt+voPtc+SZw2t1
	 xsY8QcNvBjYBMTb1Tym5ZlZkBO2UShAuDL+uTupUeLvo3fpBCUDlULb0dmBrLV5TQB
	 Fk1++J2Llx64wfbDQgzQ+cz0YnZfgthD2ivRhkbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfGZVhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:37:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfGZVhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:37:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A24D21842;
        Fri, 26 Jul 2019 21:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564177026;
        bh=CYH+0u4ay4mcNfJRo5I8rigGJXkfv7dQBLwaCsxvPEk=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=yhsjAxMSDMSRcd819Q/CZPFuMxoGEF/4tt19x3SKqBOiwxa/t67cdVvAWMkQXVXIB
         ubtHL9gbJ+e6DgNUOq2ge2eWivA0wPL/kB1G0Td8dXYvu0HOIZ+rqON2x4NNcvoqps
         18b4Fgh+NLv73D7P6wxTnlfIGUqVViC8I4MPvK7g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190723060905.GA15632@dragon>
References: <1562682003-20951-1-git-send-email-abel.vesa@nxp.com> <20190723060905.GA15632@dragon>
Subject: Re: [PATCH v2] clk: imx8mm: Switch to platform driver
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Fri, 26 Jul 2019 14:37:05 -0700
Message-Id: <20190726213706.3A24D21842@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2019-07-22 23:09:06)
> On Tue, Jul 09, 2019 at 05:20:03PM +0300, Abel Vesa wrote:
> > There is no strong reason for this to use CLK_OF_DECLARE instead
> > of being a platform driver. Plus, this will now be aligned with the
> > other i.MX8M clock drivers which are platform drivers.
> >=20
> > In order to make the clock provider a platform driver
> > all the data and code needs to be outside of .init section.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >=20
> > Changes since v1:
> >  * Switched to platform driver memory mapping API
> >  * Removed extra newline
> >  * Added an explanation of why this change is done
> >    in the commit message
>=20
> Hi Stephen,
>=20
> Are you fine with this version?
>=20

Sure.

Acked-by: Stephen Boyd <sboyd@kernel.org>

