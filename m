Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCC7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A336B2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553000440;
	bh=/BnRs4jBzjyKKnthAC+xBHEFOhneesnKHzy82oCgh7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ylRqw20yIa0XD+etKDWluw6ipP7zyDEr2ZlqP1zblEUsQ12+P5mO2vPezzJUUdS/w
	 5DOpol8yeuAQPGwdjXvLffkIHX182z12Co7Z1V3OI7PjJvurjOA9/2UCZsUy5ou0FR
	 pKIcO/wc5aBVWK/5SJd7dm9EFKkTQnmi7ZsDWNKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCSNAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfCSNAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:00:39 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A671A213F2;
        Tue, 19 Mar 2019 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553000438;
        bh=/BnRs4jBzjyKKnthAC+xBHEFOhneesnKHzy82oCgh7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=meyYLkhoncryI0IvGnYE+CBX2e2/Ulv6AXF0BkinO/hgqBma2yNqjeShQb+k9xv66
         VCmUmbf9ikaMZW7Lzug0z319tZq/MRHZ+3j9s8N8vYy05Iwc93QfNlTrNAabaSVVtW
         2esYWQKfxZgb7GkiZRWi68rOkepPPH+YkbRavGpo=
Date:   Tue, 19 Mar 2019 21:00:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V2 2/2] arm64: dts: freescale: imx8mq: add clock
 for GPIO node
Message-ID: <20190319130009.GC28063@dragon>
References: <1551230622-30660-1-git-send-email-Anson.Huang@nxp.com>
 <1551230622-30660-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551230622-30660-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 01:28:32AM +0000, Anson Huang wrote:
> i.MX8MQ has clock gate for each GPIO bank, add clock info
> to GPIO node for clock management.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Prefix 'arm64: dts: imx8mq: ...' is good enough.  Dropped 'freescale: '
and applied the patch.

Shawn
