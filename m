Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE05C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00DC2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558573194;
	bh=1qlr1saWEx9OtCDPOZZL3KDO+7inSJQ4Uod5b4ZfYxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YrP3bGqQBjHtghqm0qRKWi4e98Lkq1+pQyR5q5ld9Ndjedb0xPMTPwHH/1QOOQCnH
	 yCfOW1AcKin619P1WU93RdhgwvbnCIl50SuAFl9NNnODIk8mxkPyAWoNabtbcYdgMV
	 XeRS6qxsCyqp6Sew1tml3Wk06c6fbTUkfbEZHRew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbfEWA7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfEWA7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:59:53 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A666D2089E;
        Thu, 23 May 2019 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558573193;
        bh=1qlr1saWEx9OtCDPOZZL3KDO+7inSJQ4Uod5b4ZfYxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0Tk8FJlY3aXlAmtiS70EZ6IwtmjdlmkKqoOoiyGdap2W1xZfpJQuHecqbOiN29F1
         pZVQYC5jQq2BWSzfUixnMoaq1IPNTt7/B6lWj/Em6ZrVufMRsSW21cJHKe0x5G/iJZ
         6uAO/YDqnGJnyzHSAb/C17AeuHxYxkv8wqE0jPnA=
Date:   Thu, 23 May 2019 08:58:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx8mq: Add SNVS clock
Message-ID: <20190523005854.GB16359@dragon>
References: <1557882259-3353-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557882259-3353-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:09:24AM +0000, Anson Huang wrote:
> Add macro for the SNVS clock of the i.MX8MQ.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
