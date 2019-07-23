Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995D4C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B9223A1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563868992;
	bh=NzZJIzqSuCySKVu8QSAWnsLQ14sMCDdVbIeGxQTQNRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NKHAw9G+kCRS3n69ZPDvb/konP5gSqL0J1Y0oZqIX5FtCkHVlBOEAhBaCacw8nqir
	 /+8lh6mYUpIIYmeZS3WdOqJpHpTpeNYHJNyAjDAdKi1AeZNn5KN8Ibw5yGtRbyBfKK
	 yY2+x7w+3Xh/QZQ4KrhvTsYETjwC/e8AhPewT1Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfGWIDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbfGWIDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:03:10 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C503D2070B;
        Tue, 23 Jul 2019 08:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563868989;
        bh=NzZJIzqSuCySKVu8QSAWnsLQ14sMCDdVbIeGxQTQNRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mi3vYfKaXr5oRK/kshsr8aZ5LrMQ/AeIld8NL4LT9AuE1yJKJDDB179X7XCXTTokE
         XjUDMTO2L6Ng9NXLwtYvBjMXK4hApAtF433+cEZov/Wn8FGHWxkrBoUEEeTVWpuIpP
         3c94I8tQNLPOKKEsoXfHcmIxnJ1NqJIOhxUNqAzM=
Date:   Tue, 23 Jul 2019 16:02:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Gilles DOFFE <gilles.doffe@savoirfairelinux.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        s.hauer@pengutronix.de, rennes@savoirfairelinux.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        jerome.oufella@savoirfairelinux.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm: dts: imx6qdl: add gpio expander pca9535
Message-ID: <20190723080234.GO15632@dragon>
References: <20190719104615.5329-1-gilles.doffe@savoirfairelinux.com>
 <20190722075341.e4ve45rneusiogtk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722075341.e4ve45rneusiogtk@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:53:41AM +0200, Marco Felsch wrote:
> Hi Gilles,
> 
> can you adapt the patch title, I assumed that the base dtsi is adding a
> gpio-expander which makes no sense.

More specifically, the prefix should be something like:

  'ARM: dts: imx6qdl-rex: ...'

Shawn
