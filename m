Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E2CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FD32086D
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389064AbfJVQDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:03:52 -0400
Received: from smtprelay0178.hostedemail.com ([216.40.44.178]:36971 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387746AbfJVQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:03:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 86C3481D6;
        Tue, 22 Oct 2019 16:03:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: soda94_216e47221b22d
X-Filterd-Recvd-Size: 1297
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Oct 2019 16:03:49 +0000 (UTC)
Message-ID: <5db6c53e5c87ca2999c577333d9c6df678b36994.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add reset controller framework keywords
From:   Joe Perches <joe@perches.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Tue, 22 Oct 2019 09:03:48 -0700
In-Reply-To: <20191022123823.4854-1-p.zabel@pengutronix.de>
References: <20191022123823.4854-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-22 at 14:38 +0200, Philipp Zabel wrote:
> Add a regex that matches users of the reset controller API.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -13851,6 +13851,7 @@ F:	include/dt-bindings/reset/
>  F:	include/linux/reset.h
>  F:	include/linux/reset/
>  F:	include/linux/reset-controller.h
> +K:	\b(devm_|of_)?reset_control(ler_[a-z]+|_[a-z_]+)?\b

Please add ?: to each group so no capture is done.
It's a little faster.

K:	\b(?:devm_|of_)?reset_control(?:ler_[a-z]+|_[a-z_]+)?\b


