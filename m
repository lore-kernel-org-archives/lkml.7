Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26731C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080BF2073F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbfIDONC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:13:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbfIDONC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:13:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64A5928;
        Wed,  4 Sep 2019 07:13:01 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FE5A3F59C;
        Wed,  4 Sep 2019 07:12:59 -0700 (PDT)
Date:   Wed, 4 Sep 2019 15:12:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: Add Lenovo Yoga C630
Message-ID: <20190904141257.GB6144@bogus>
References: <20190904121606.17474-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904121606.17474-1-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:16:06PM +0100, Lee Jones wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> The Lenovo Yoga C630 is built on the SDM850 from Qualcomm, but this seem
> to be similar enough to the SDM845 that we can reuse the sdm845.dtsi.
>
> Supported by this patch is: keyboard, battery monitoring, UFS storage,
> USB host and Bluetooth.
>

Just curious to know if the idea of booting using ACPI is completely
dropped as it's extremely difficult(because the firmware is so hacked
up and may violate spec, just my opinion) for whatever reasons.

We just made ACPI table version checking more lenient for this platform
and would be good to know if we continue to run ACPI on that or will
abandon and just use DT.

--
Regards,
Sudeep
