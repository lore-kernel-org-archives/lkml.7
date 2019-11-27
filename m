Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16990C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AE42080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfK0V1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:27:03 -0500
Received: from smtprelay0110.hostedemail.com ([216.40.44.110]:50874 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730978AbfK0U75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:59:57 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 794C21802587B;
        Wed, 27 Nov 2019 20:59:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: goose47_391d3abea6950
X-Filterd-Recvd-Size: 2157
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Nov 2019 20:59:52 +0000 (UTC)
Message-ID: <ae40eb808f420f5de4a140b8757dfbc426a8cf90.camel@perches.com>
Subject: Re: [PATCH 4/5] pinctrl: sh-pfc: Use the correct style for SPDX
 License Identifier
From:   Joe Perches <joe@perches.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Nov 2019 12:59:25 -0800
In-Reply-To: <9bacc7d9-6bd9-0b7c-18cd-d614796397dd@suse.de>
References: <cover.1574871463.git.nishadkamdar@gmail.com>
         <5a7ed2e4b58ba7ff2f0638a2435a3a1e1c62c9f6.1574871463.git.nishadkamdar@gmail.com>
         <CAMuHMdUqfRioTBV27AKx9zv9YuSqEod6x+A4aguf=h20TDXr6w@mail.gmail.com>
         <9bacc7d9-6bd9-0b7c-18cd-d614796397dd@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-11-27 at 21:55 +0100, Andreas Färber wrote:
> However, if we're touching these lines anyway, shouldn't we be updating
> the SPDX Identifier to GPL-2.0-only while at it?

Probably better to do that with a treewide script one day.

https://lkml.org/lkml/2018/8/16/487


