Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB91C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C5121734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAFJTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:19:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36541 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAFJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:19:38 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ioOXx-0004Zk-C1; Mon, 06 Jan 2020 10:19:37 +0100
Message-ID: <12b992550e8fa7d3e7cbfa7930bba8f9fd5d01f8.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] reset: Add Broadcom STB RESCAL reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 06 Jan 2020 10:19:35 +0100
In-Reply-To: <20200103190429.1847-1-f.fainelli@gmail.com>
References: <20200103190429.1847-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Fri, 2020-01-03 at 11:04 -0800, Florian Fainelli wrote:
> Hi Philipp,
> 
> This patch series adds support for the BCM7216 RESCAL reset controller
> which is necessary to initialize SATA and PCIe0/1 on that chip.
> 
> Please let us know if you have any comments. Thanks!
> 
> Changes in v3:
> 
> - indented "base" variable with a space
> - return ret directly out of readl_poll_timeout()
> - removed additional register read after write, not necessary
> - removed call to platform_set_drvdata, unnecessary either
> - corrected Jim's email in Signed-off-by in patch #2

Thank you, both applied to reset/next.

regards
Philipp

