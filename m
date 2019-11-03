Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F898CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 08:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4CF2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 08:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572768802;
	bh=O6Sl/WudcHVmvZ80SOwx1ethvyuH+iLA+GM2fSi1sgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gWnHqHWJsZFL92p8RKww/YPD9Tm+VgsMQCfSZn5ZFdu192f+7tEwQvvUM/f3LI/oS
	 x/NsTfKz/kzAJrm+IEybiXtCmgPpHVmbxDQ1+LC+IANOGjS5od+UHk2n9TOhj+17NA
	 5SE4iwkm6MPFQg/pFi2nukjPsEkLaTdw08C8O5H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfKCINT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 03:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfKCINT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 03:13:19 -0500
Received: from localhost (unknown [106.206.31.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB6D2084D;
        Sun,  3 Nov 2019 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572768798;
        bh=O6Sl/WudcHVmvZ80SOwx1ethvyuH+iLA+GM2fSi1sgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF3rTgqQIDJOKT6EJtQc5fSgYoCY9pcDJe4Yvnr+FYdtchoUmabp904LiWUE7zHPN
         wZP6mmlwNsnSLUf6xUCyjs8iNqFk62PLkieN84qmkYYs6x6oo3cJBEGFr3WpvUSQ/T
         apkjijqjwn05w9gKPLjKYiGhXC7iqE91WYVxNAm0=
Date:   Sun, 3 Nov 2019 13:43:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] arm64: dts: qcom: msm8996: Introduce IFC6640
Message-ID: <20191103081311.GM2695@vkoul-mobl.Dlink>
References: <20191021051322.297560-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021051322.297560-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-19, 22:13, Bjorn Andersson wrote:
> Refactor msm8996 and db820c in order to make it follow the structure of newer
> platforms, move db820c specific things to db820c.dtsi and then introduce the
> Informace 6640 Single Board Computer.

This has patch 9/11 missing. But rest look good to me.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
