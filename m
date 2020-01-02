Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C6AC2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59712467F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 19:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgABTeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 14:34:03 -0500
Received: from muru.com ([72.249.23.125]:49954 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgABTeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 14:34:03 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B42DE8087;
        Thu,  2 Jan 2020 19:34:43 +0000 (UTC)
Date:   Thu, 2 Jan 2020 11:33:59 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?QW5kcsOp?= Hentschel <nerv@dawncrow.de>
Cc:     linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com,
        bcousson@baylibre.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ARM: dts: Move interconnect target module for
 omap3 sgx to separate dtsi files
Message-ID: <20200102193359.GE16702@atomide.com>
References: <20191230202037.28836-1-nerv@dawncrow.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191230202037.28836-1-nerv@dawncrow.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* André Hentschel <nerv@dawncrow.de> [191230 20:22]:
> Only dm3730 and am3715 come with SGX support

AFAIK dm3730 is just a marketing name for a catalog version of
omap3630. So using omap36xx.dtsi is correct and we should not
change that.

Can you please just add a minimal dm3725.dtsi that your board dts
can include and avoid disabling sgx in the board specific file?
That is assuming you have dm3725 with dsp and isp but no sgx.

You can read the detected SoC with:

# cat /sys/bus/soc/devices/soc0/machine

This avoids somebody (probably me again) patching all over the
board specific files trying to guess which SoC the device might
have.

Regards,

Tony
