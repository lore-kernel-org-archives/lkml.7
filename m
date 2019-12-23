Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFD2C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 04:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A69207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 04:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577076300;
	bh=LhjIg4WZNPsnnra5trcrEQpZecG9BSH6bVukeQv/Z6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5/z9Az5uZQIkRPdpWg3oqHwgymGoeQ69t+DM6XO7xW2SBYONMc7paR7FpmXU9Zyq
	 kzAZmuC3CD455Hi4wrEWwjVh04QrXrL2yOiZq8oNJ5glF4BalglO5HaCfyJzG/oBPm
	 7KjyfA1PNmmNEN+muzY3QuvNy78kVQ7MiUKQyOrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLWEo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 23:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfLWEo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 23:44:59 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68D720409;
        Mon, 23 Dec 2019 04:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577076298;
        bh=LhjIg4WZNPsnnra5trcrEQpZecG9BSH6bVukeQv/Z6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rs8TSHPpYxxMsjCz/jrkHpVZBhoJNHNbBGrso+nMv4dKephYRCGz8ro5HYAs8+63i
         S3y+XIrZ8fX9JsV4ZEc/50o9EVAfvtd0zKdjKqVJDleNLE8bfPBD+8GyvEEbWZplzq
         QdnWWHc5W4VPexPjGjml67mSM9RFAYuhX0h8iFUE=
Date:   Mon, 23 Dec 2019 10:14:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable ATH10K_SNOC
Message-ID: <20191223044454.GT2536@vkoul-mobl>
References: <20191028171837.3907550-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028171837.3907550-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-19, 10:18, Bjorn Andersson wrote:
> The ath10k snoc is found on the Qualcomm QCS404 and SDM845, so enable
> the driver for this.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
