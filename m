Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175E3C10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D497921841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553068883;
	bh=DezKVxJ9k/B+t90tpPzteaUHsjXY4XQe8hChfflEkVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xItcwMOBoDLdnh06dI+5bN3tuI0DlA6Ie9vhS3IWXmZ/TwBt5eVttsgLhk5gkEu/D
	 /ep0fsn7pkWio56OI+OupZeTmBl+dTZ7qPH51RnCZOXYMyNk543C397wjaX0jMu6hh
	 6cF6c2kqfR2i6CK5DMkRVW7Aa730DTW2+ryLAXwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfCTIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfCTIBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:01:22 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A254B2146E;
        Wed, 20 Mar 2019 08:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553068882;
        bh=DezKVxJ9k/B+t90tpPzteaUHsjXY4XQe8hChfflEkVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GOzeWIwRv0QprvxyqSmBJ1xVSTOqdgINTjKt5B0RDNReHwkmYh+188iBQbHqMwz/V
         g2wK1/SfDA/xRLADYH9nu4+HuezV8bQ2RKtpwj4LTXF/MVnUj1HV2Cr7bk6a3Wv5aH
         VBn7pKHbc9F6UqIndZ75Sil+O/PUzNxsPkmpWF7U=
Date:   Wed, 20 Mar 2019 16:00:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx7ulp: remove snvs clock
Message-ID: <20190320080056.GC4980@dragon>
References: <1551343889-6674-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551343889-6674-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 08:56:00AM +0000, Anson Huang wrote:
> Since i.MX7ULP B0 chip, the SNVS module is moved into M4
> domain and its clock is also moved into PCC0 which is
> contorlled by M4, Linux kernel should NOT add it into
> clock tree.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied both, thanks.
