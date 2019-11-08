Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE3C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB9F214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573187659;
	bh=4B2SnwZXzTaWLQOUtTDx9eWlfS8vkBMKoHWOE/PahJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iBH8yYqLtQOYXK6W3DPmfn4n+++BbVS2xvcO6EMh+YizTXgsg/KiBky7YvGY5gM92
	 zJJx1Qln1/I5c3dVrJOlKvXfsMz24BgYccUlam+mA9GklJVn3iZndJ0SwqVEJQ5OWO
	 DHsLQMjXtrMTBy4cQkBKbJPBfCNbWSzWBrhnfPWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfKHEeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHEeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:34:17 -0500
Received: from localhost (unknown [106.200.194.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A4B214DB;
        Fri,  8 Nov 2019 04:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573187656;
        bh=4B2SnwZXzTaWLQOUtTDx9eWlfS8vkBMKoHWOE/PahJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSIakb2/1ko+CiiCkHi1ttysGhal65v5mgjLDtF9qU/ob4jB5gfxU6Z3lagM+vR/v
         Wwbg0HkIM/OuUwRNPSboaV4e2SJPuu4yUPd3JQMINlHJCvuRn5MKA1XMNhgnLpVaXE
         robUyeeS3cARWcg6F3Q4oV3sDBuvz8/E7Y+nYGdw=
Date:   Fri, 8 Nov 2019 10:04:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: rpmh: Reuse sdm845 clks for sm8150
Message-ID: <20191108043412.GX952516@vkoul-mobl>
References: <20191107214018.184105-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107214018.184105-1-sboyd@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-19, 13:40, Stephen Boyd wrote:
> The SM8150 list of clks is almost the same as the list for SDM845,
> except there isn't an IPA clk. Just point to the SDM845 clks from the
> SM8150 list for now so we can reduce the amount of struct bloat in this
> driver.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
