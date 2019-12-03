Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216662068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 06:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfLCGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 01:11:52 -0500
Received: from mx.socionext.com ([202.248.49.38]:9963 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfLCGLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 01:11:52 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 03 Dec 2019 15:11:50 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id C34CB18010B;
        Tue,  3 Dec 2019 15:11:50 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Tue, 3 Dec 2019 15:12:15 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 569C840361;
        Tue,  3 Dec 2019 15:11:50 +0900 (JST)
Received: from [10.213.132.48] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 2AB0B12044A;
        Tue,  3 Dec 2019 15:11:50 +0900 (JST)
Date:   Tue, 03 Dec 2019 15:11:50 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier: Add SCSSI reset control for each channel
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <12f11e521a41d9f1e0e916fcbe413f6d0390bb3c.camel@pengutronix.de>
References: <1575001159-19648-1-git-send-email-hayashi.kunihiko@socionext.com> <12f11e521a41d9f1e0e916fcbe413f6d0390bb3c.camel@pengutronix.de>
Message-Id: <20191203151149.52A8.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Mon, 2 Dec 2019 14:06:20 +0100 <p.zabel@pengutronix.de> wrote:

> On Fri, 2019-11-29 at 13:19 +0900, Kunihiko Hayashi wrote:
> > SCSSI has reset controls for each channel in the SoCs newer than Pro4,
> > so this adds missing reset controls for channel 1, 2 and 3. And more, this
> > moves MCSSI reset ID after SCSSI.
> 
> Just to be sure, there are no device trees in circulation that already
> use the MCSSI reset?

Yes, currently no device trees refer to MCSSI reset,
so I think MCSSI reset ID can be moved.

Thank you,

---
Best Regards,
Kunihiko Hayashi

