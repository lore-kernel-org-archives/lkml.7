Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A09FC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA8520B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 00:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEGAY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 20:24:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:13209 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbfEGAYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 20:24:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 17:24:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,439,1549958400"; 
   d="scan'208";a="171510161"
Received: from unknown (HELO [10.255.29.152]) ([10.255.29.152])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2019 17:24:23 -0700
Message-ID: <1557188662.5080.1.camel@intel.com>
Subject: Re: Missing patches for thermal for 5.2
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Date:   Tue, 07 May 2019 08:24:22 +0800
In-Reply-To: <b3fbf910-d073-1dd9-649c-eea370ae71f7@linaro.org>
References: <b3fbf910-d073-1dd9-649c-eea370ae71f7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 一, 2019-05-06 at 15:17 +0200, Daniel Lezcano wrote:
> Hi Eduardo, Zhang,
> 
> AFAICS, the following patches are missing for 5.2:
> 
> 
> [PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m
> 
This one is already in my tree.
https://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git/commit
/?h=next&id=980d43f24d59491aa1c5552171454ac25fb86ea2

And I think the below patches should go through Eduardo' tree.

thanks,
rui

> [PATCH v3 1/3] thermal: rockchip: fix up the tsadc pinctrl setting
> error
> 
> [PATCH v3 2/3] dt-bindings: rockchip-thermal: Support the PX30 SoC
> compatible
> 
> [PATCH v3 3/3] thermal: rockchip: Support the PX30 SoC in thermal
> driver
> 
> [PATCH] thermal: cpu_cooling: Actually trace CPU load in
> thermal_power_cpu_get_power
> 
> [PATCH] thermal/drivers/cpu_cooling: Remove pointless test in
> power2state()
> 
> [PATCH - resend] thermal/drivers/cpu_cooling: Fixup the header and
> copyright
> 
> [PATCH - resend 2/3] thermal/drivers/cpu_cooling: Add Software
> Package
> Data Exchange (SPDX)
> 
> [PATCH - resend 3/3] thermal/drivers/cpu_cooling: Remove pointless
> field
> 
> 
> 
> This one is pending:
> 
> [PATCH] thermal/drivers/of: Add a get_temp_id callback function
> 
> The series [PATCH v3 00/13] QorIQ TMU multi-sensor and HWMON support
> depends on it.
> 
> Hope that helps.
> 
>   -- Daniel
> 
> 
> 
