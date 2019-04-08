Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748AFC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F4E208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfDHLDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:03:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfDHLDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:03:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33A25168F;
        Mon,  8 Apr 2019 04:03:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88CED3F718;
        Mon,  8 Apr 2019 04:03:51 -0700 (PDT)
Date:   Mon, 8 Apr 2019 12:03:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, lee.jones@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: Add Lenovo Miix 630
Message-ID: <20190408110348.GF6139@lakrids.cambridge.arm.com>
References: <20190326185525.20781-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326185525.20781-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:55:25AM -0700, Jeffrey Hugo wrote:
> This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> functionality includes USB (host), microSD-card, keyboard, and trackpad.

I was under the impression that the Miix 630 came with Windows, and the
firmware therefore provided (as least a simulacrum of) ACPI. Why do we
need a DT?

[...]

> +++ b/arch/arm64/boot/dts/qcom/msm8998-cls.dtsi
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2019, Jeffrey Hugo. All rights reserved. */
> +
> +/*
> + * Common include for MSM8998 clamshell (cls) devices, ie the Lenovo Miix 630,
> + * Asus NovaGo TP370QL, and HP Envy x2.  All three devices are basically the
> + * same, with differences in peripherals.
> + */

I think it would be better to consistently use "clamshell" (e.g. rename
this to msm8998-clamshell.dtsi), and mention the "cls" terminology in
the comment if that's necessary.

[...]

> +	keyboard@3a {
> +		/* QTEC0001 is the ACPI HID, which could be used for quirks */
> +		compatible = "QTEC0001", "hid-over-i2c";

Please give this a real compatible string rather than forcing the ACPI
HID in.

Thanks,
Mark.
