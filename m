Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B84B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfDLOrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:47:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34362 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLOrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:47:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEF7D15AB;
        Fri, 12 Apr 2019 07:47:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F2853F557;
        Fri, 12 Apr 2019 07:47:20 -0700 (PDT)
Date:   Fri, 12 Apr 2019 15:47:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        david.brown@linaro.org, robh+dt@kernel.org, lee.jones@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: Add Lenovo Miix 630
Message-ID: <20190412144712.GA7481@lakrids.cambridge.arm.com>
References: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411205144.43557-1-jeffrey.l.hugo@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 01:51:44PM -0700, Jeffrey Hugo wrote:
> This adds the initial DT for the Lenovo Miix 630 laptop.  Supported
> functionality includes USB (host), microSD-card, keyboard, and trackpad.
> 
> Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> ---
> 
> v2:
> -Changed "cls" to "clam" since feedback indicated "cls" is too opaque, but
> "clamshell" is a mouthfull.  "clam" seems to be a happy medium.

Please use "clamshell". The extra 5 characters aren't going to hurt
anyone, and it avoids having yet another short name just confuses
matters further.

[...]

> +	keyboard@3a {
> +		/* QTEC0001 is the ACPI HID, which could be used for quirks */
> +		compatible = "QTEC0001", "hid-over-i2c";

As mentioned last time, please drop the ACPI HID, and allocate a real
compatible string.

Thanks,
Mark.
