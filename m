Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D162084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfDITJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:09:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:5808 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDITJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:09:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 12:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,330,1549958400"; 
   d="scan'208";a="221976133"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga001.jf.intel.com with ESMTP; 09 Apr 2019 12:09:41 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [RESEND PATCHv3 0/3] Update Stratix10 EDAC Bindings
To:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     mchehab@kernel.org, james.morse@arm.com,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <fa5b2837-9cb0-517c-c491-9b5d3ae0a3a5@linux.intel.com>
Date:   Tue, 9 Apr 2019 14:11:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554388597-28019-1-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 4/4/19 9:36 AM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> This patch series makes the Stratix10 EDAC Bindings
> specific to the Stratix10 ARM64 architecture.
> 
> Instead of using the Arria10 (ARM32) EDAC bindings for
> Stratix10 (ARM64), create Stratix10 specific EDAC bindings
> to capture architecture differences between ARM32 and ARM64.
> This requires fixing the previous Stratix10 bindings.
> Also add the peripheral bindings for the Stratix10.
> 
> V2: Remove Stratix10 compatible check.
> 
> V3: Remove patches not related to EDAC bindings so that
>      this patchset is targeted toward the bindings.
>      Improve the Stratix10 specific binding description by
>      adding in descriptions of ARM64 differences.
> 
> Resend: Add Reviewed-by and Acked-by from bindings and
>      socfpga device tree maintainers. I'd like this to go
>      through the EDAC tree since future patches will have
>      a dependency on these bindings and device tree.
> 
> Thor Thayer (3):
>    Documentation: dt: edac: Fix Stratix10 IRQ bindings
>    Documentation: dt: edac: Add Stratix10 Peripheral bindings
>    arm64: dts: stratix10: Use new Stratix10 EDAC bindings
> 
>   .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 135 +++++++++++++++++++--
>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  25 ++--
>   2 files changed, 138 insertions(+), 22 deletions(-)
> 

If possible, I'd like this series to go through the EDAC tree since 
future patches will follow this format.

Regards,

Thor
