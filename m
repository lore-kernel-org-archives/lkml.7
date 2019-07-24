Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D0DC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE3220644
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563942482;
	bh=KcvumDtHGTAbiC6t0H1WAMDH8xJ/VH7jZAdfG7AAQBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p1ByBOSMM5IoWURVrsYxzu4AzuacIxjnZE9M0fa07a+dYGSSfMdSyqqq1JWwb1k6w
	 VHIlXaeBzEimofLmvkOQ1xpeYKRmEHLsoazzaM3NqiiOcPg3DuASQVyyCp2ExNPlf/
	 0FPRhYLc9kqkWgH3PAEYDDVGCRv8HWPFJtcfyGgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfGXE2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfGXE17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:27:59 -0400
Received: from localhost (unknown [171.76.105.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F9220644;
        Wed, 24 Jul 2019 04:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563942478;
        bh=KcvumDtHGTAbiC6t0H1WAMDH8xJ/VH7jZAdfG7AAQBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zoNNtjDUONcY4Sphlyp61Nj2+brqPte/LV2VGgFeHpA/TupP81vg3kPtI9IM+8gQi
         8JH7vV1bs5JzIUrc5unHgNDU/HtA3Js6WtkJG5nKlZ8mKQdoziHeQ14p+o2fFpQ052
         Kt3RBikdV57DUYj747KQ+ZOmqaNpEL4PE3wxBINU=
Date:   Wed, 24 Jul 2019 09:56:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     agross@kernel.org, david.brown@linaro.org,
        gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v6 1/5] base: soc: Add serial_number attribute to soc
Message-ID: <20190724042646.GC12733@vkoul-mobl.Dlink>
References: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
 <20190723223515.27839-2-vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723223515.27839-2-vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-19, 04:05, Vaishali Thakkar wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Add new attribute named "serial_number" as a standard interface for
> user space to acquire the serial number of the device.
> 
> For ST-Ericsson SoCs this is exposed by the cryptically named "soc_id"
> attribute, but this provides a human readable standardized name for this
> property.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
