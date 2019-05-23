Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A1EC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB012177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558596490;
	bh=fR8am8eYsyOKxxovT2B3g28ceysx1M76jsNM6qy5Fys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zMJEym3Thz2wR31qaEvt5CGIjxTX0v+Z7d4tBwimsmyfdfKz8946SePM7vWV2MZj6
	 vZdPmykkyQhRaq0AH1BDmtunLTwky5IVz4vn38e6zM5FPbjjKzJnGr7GX19qYXLhWC
	 KtRxoUkodlZu3oOmgCUEfsUxqhC+FwLxxSuBFhUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfEWH2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWH2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:28:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CBC82175B;
        Thu, 23 May 2019 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558596488;
        bh=fR8am8eYsyOKxxovT2B3g28ceysx1M76jsNM6qy5Fys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+WcTzi4FLyVQvYWVkuOfbzOoxrxOS3Ykwvz0kfoeoHMgdvTt6fjUfRBxVDrZUbt3
         8bdMOsWQ0oi7ehdPifRPlZ1d3oP+8UuaJGBQH8fyFTiVZYpljr5XE7zuIbLK5hLAz7
         AY9OA7GDy4E6JKRX6P+r59ijRrRqBMRelh2frdZs=
Date:   Thu, 23 May 2019 15:27:07 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx8mm: Add SNVS clock
Message-ID: <20190523072706.GD9261@dragon>
References: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 01:29:53AM +0000, Anson Huang wrote:
> Add macro for the SNVS clock of the i.MX8MM.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
