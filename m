Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1659FC41514
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E194723401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567604754;
	bh=1r1n2dV7qz+ood1UyoTT8pXwvwuaPc1xvE+m2kLuLm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tfsCtnaxGFDz7CHUNh2S/7E2EJmfTpGs5j9w3mXF8noDyycQxBIgEPYKWFuiKE0fG
	 iTiqGl3JsnbZId2Qdf+zmjD065jWkYPBnmgusqnZT/lECKoRoVlXzYLiBlC80FPM2I
	 xXAnG8JUCwPismWLLam1biilad4FL+TTqtBgBIFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfIDNpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 09:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfIDNpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:45:53 -0400
Received: from localhost (unknown [122.182.201.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E2C2339D;
        Wed,  4 Sep 2019 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567604752;
        bh=1r1n2dV7qz+ood1UyoTT8pXwvwuaPc1xvE+m2kLuLm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJYUK7AKwKFFeNR5HQDRyVndRcn8WMpiJR5kF6ik6JJAcWm9HB3GkpYTQXBaMbbF/
         Wu5PgJ4QV3X5JTut4mkTGegMkJfnQF1RUYgkK14KDV6C3MnJmWazRLkbuUmr33Iq4y
         s/mWFtltbkEnLlN9DASG1CbnXPt03S2nLPMlN0Eo=
Date:   Wed, 4 Sep 2019 19:14:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: Add Lenovo Yoga C630
Message-ID: <20190904134438.GZ2672@vkoul-mobl>
References: <20190904121606.17474-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904121606.17474-1-lee.jones@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-09-19, 13:16, Lee Jones wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The Lenovo Yoga C630 is built on the SDM850 from Qualcomm, but this seem
> to be similar enough to the SDM845 that we can reuse the sdm845.dtsi.
> 
> Supported by this patch is: keyboard, battery monitoring, UFS storage,
> USB host and Bluetooth.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
