Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1667C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8FC2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559843718;
	bh=UIIZUNstg8kbM37txNcDzUQLjNklk5K0SFR0hwXSG1U=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=iHHXiNdmksiF3jlyFOo/zLPqx3plvDOGUGpBXyhxz3H3fn/vAm+ksQ9u9T1FY4OV5
	 YGfsdia13irPa+C7uKyAwjRAijpxVXBs4VC5dZwVcUBcqTaqjkyY7VGafku8KpLnoa
	 hv21nHFGG/epQfMrKbA1ddc4sEEhs20qAn0aBZRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfFFRzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:55:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfFFRzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:55:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5AB22083E;
        Thu,  6 Jun 2019 17:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559843716;
        bh=UIIZUNstg8kbM37txNcDzUQLjNklk5K0SFR0hwXSG1U=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=VfXKqQhMGKAY5/W6lEfL1Nf44ezQkWcS2B6eelQK/HNZ6PZ4TvtIk9WCGScyX260Y
         qZ+PA/xXhPvjuOS9LbJZQb9TYd8SGjL0saRxgq9mgb53XXlyN026gnIfXTSMGxFDhX
         jeoeL1A+PLf3AVO5m+sx3zN30bmGVf0mH+cQFA/w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <VI1PR07MB44324648C54773C24E4B186AFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
References: <VI1PR07MB44324648C54773C24E4B186AFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: Remove unused variable
Cc:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 10:55:15 -0700
Message-Id: <20190606175516.A5AB22083E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philippe Mazenauer (2019-05-21 05:16:14)
> Variable 'ddrphycfg_parents' is defined static and initialized, but not
> used in the file.
>=20
> ../drivers/clk/mediatek/clk-mt8516.c:234:27: warning: =E2=80=98ddrphycfg_=
parents=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  static const char * const ddrphycfg_parents[] __initconst =3D {
>                            ^~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---

Applied to clk-next

