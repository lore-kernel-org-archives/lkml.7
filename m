Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252F5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 03:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC48321569
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 03:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577417053;
	bh=s944JgsWuexqbpJwZEh5NgcpT/2p+A42CXGeuiQy7Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WMv6ACBlzjHP+6ocTvgQBiwvfD3SUCyALpg2RXp5ZaM1gxktjjwlR9VnKdpoQ+BQ6
	 SVirvA32hVei7B+yhxrbTBh+C87LueFK/GlFX4x3tXOEspE3+Mfy1VjabcdTwOsHh1
	 ao8whhGxNrqplH0rCNjx88sgX0x2nrma171qzXpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfL0DYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 22:24:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfL0DYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 22:24:11 -0500
Received: from localhost (unknown [106.51.110.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BFD520409;
        Fri, 27 Dec 2019 03:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577417051;
        bh=s944JgsWuexqbpJwZEh5NgcpT/2p+A42CXGeuiQy7Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lniWdE+1CfCD2taWKoVqrH7HpvP+yRHnD2Ra7FVmywg6c0/03a2CJdRyCluQakkCv
         GLSWslgnSUy5vY2amMPTrS1yi0Nm8jJO3XKDLjIsOpjN44R8He1v3fBFQRQU6It3t1
         UBblyNrF0bExvBoZgH91fh6akV7tZfdj3g6R0I7o=
Date:   Fri, 27 Dec 2019 08:54:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/5] phy: qcom-qmp: Add SDM845 QMP and QHP PHYs
Message-ID: <20191227032406.GA3006@vkoul-mobl>
References: <20191107000917.1092409-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107000917.1092409-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-19, 16:09, Bjorn Andersson wrote:
> Add support for the two PCIe PHYs found in Qualcomm SDM845.

I have tested this on db845 so:
Tested-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
