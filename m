Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C116CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B502070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfCZLdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:33:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41351 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZLdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:33:14 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h8kKL-0003WE-0G; Tue, 26 Mar 2019 12:33:09 +0100
Message-ID: <1553599988.6854.5.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: meson-g12a: Add missing USB2 PHY
 resets
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Mar 2019 12:33:08 +0100
In-Reply-To: <7hbm2234i3.fsf@baylibre.com>
References: <20190304104916.3937-1-narmstrong@baylibre.com>
         <1553078122.7071.6.camel@pengutronix.de> <7hbm2234i3.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, 2019-03-22 at 15:53 -0700, Kevin Hilman wrote:
[...]
> Could ou make a immtable tag for this in your tree?  This is needed for
> some upcoming DT users we'd like to queue for the next cycle.

I have just sent a reset/fixes pull request including this patch.
Once that gets merged, you can either wait for the next -rc that
includes it or pull in 
    git://git.pengutronix.de/pza/linux reset/meson-g12a
which is just the first patch of the two.

regards
Philipp
