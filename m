Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6C1C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5CC20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDBVFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:05:51 -0400
Received: from mga01.intel.com ([192.55.52.88]:61983 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfDBVFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:05:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 14:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,302,1549958400"; 
   d="scan'208";a="147488993"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.149]) ([10.7.153.149])
  by orsmga002.jf.intel.com with ESMTP; 02 Apr 2019 14:05:49 -0700
Subject: Re: [PATCH 3/5] media: dt-bindings: aspeed-video: Add missing
 memory-region property
To:     Eddie James <eajames@linux.ibm.com>, linux-media@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
        mchehab@kernel.org, linux-clk@vger.kernel.org
References: <1554229504-5661-1-git-send-email-eajames@linux.ibm.com>
 <1554229504-5661-4-git-send-email-eajames@linux.ibm.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <c715fe6d-d443-c9b4-0a58-29941e0ed539@linux.intel.com>
Date:   Tue, 2 Apr 2019 14:05:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1554229504-5661-4-git-send-email-eajames@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

On 4/2/2019 11:25 AM, Eddie James wrote:
> Missed documenting this property in the initial commit.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   Documentation/devicetree/bindings/media/aspeed-video.txt | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/aspeed-video.txt b/Documentation/devicetree/bindings/media/aspeed-video.txt
> index 78b464a..346c2d3 100644
> --- a/Documentation/devicetree/bindings/media/aspeed-video.txt
> +++ b/Documentation/devicetree/bindings/media/aspeed-video.txt
> @@ -14,6 +14,11 @@ Required properties:
>   			the VE
>    - interrupts:		the interrupt associated with the VE on this platform
>   
> +Optional properties:
> + - memory-region:
> +	phandle to a memory region to allocate from, as defined in
> +	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +
>   Example:
>   
>   video-engine@1e700000 {
> @@ -23,4 +28,5 @@ video-engine@1e700000 {
>       clock-names = "vclk", "eclk";
>       resets = <&syscon ASPEED_RESET_VIDEO>;
>       interrupts = <7>;
> +    memory-region = <&video_engine_memory>

nit: a semicolon at the end of the line.

>   };
> 
