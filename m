Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9FCC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A5D2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564727772;
	bh=gZD3osXgOdunMT0f6xDvKJLephy3dVfenVvnxvNuuK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ByCr9Sn8iC68wUHikM7gl07l3abMeSc4xR9/IOnZS0K4lxrRq4PA4q/ayVvnnNv8p
	 pw86uYPNGnCiKsL0MHwceJEKI6FR3af3VJ4ZKzfQkKkCPruD1V3pAW9kl4cF1+elSF
	 kO8gx4AzWm3LM3Gfc9g4Jyvz/OLdVBdWxRD2IOZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbfHBGgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731905AbfHBGgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:36:11 -0400
Received: from localhost (unknown [122.167.106.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBCD2073D;
        Fri,  2 Aug 2019 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564727770;
        bh=gZD3osXgOdunMT0f6xDvKJLephy3dVfenVvnxvNuuK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oilc6Xl93nglPGICT5s/g0CO61+Di4OQBeczd4v2IwGRmHzubtplUe2KaC8yBlCPx
         qKu6PLdswVXnHfKCXAMEu9fZm6K5W536CGJsVn8YYsgmNS65c7Sbcctf900a97k0hg
         EgTBA12xq0nhYgZRe/jmAlGjjQQXa6oVcAnziJc0=
Date:   Fri, 2 Aug 2019 12:04:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jitendra Sharma <shajit@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH v2 2/2] pinctrl: qcom: Add SC7180 pinctrl driver
Message-ID: <20190802063457.GC12733@vkoul-mobl.Dlink>
References: <20190802041507.12365-1-rnayak@codeaurora.org>
 <20190802041507.12365-2-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802041507.12365-2-rnayak@codeaurora.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-08-19, 09:45, Rajendra Nayak wrote:
> From: Jitendra Sharma <shajit@codeaurora.org>
> 
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for SC7180

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
