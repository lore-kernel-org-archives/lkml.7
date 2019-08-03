Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0966C31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F992073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 07:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564817128;
	bh=nQgmvuwty+IpGuxuskizAqv+iX4PZOcNYWEpHdFpGzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G8Nbr42rIXnuuadtr2iuecSX51l3Y5uOF79IDbOBjJpvgOLPk6s9FBEACxL0FjSR8
	 boKI+QbJkujNMtjoQ6J89lcyqOskF8qVSYp7VHo6AXrn+ShCMpmEmenXB+/eCBNOy1
	 9i3kHUrQb/u9gkMEqBZO2Xw/dSHqwXkLalClMh0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfHCHZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 03:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfHCHZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 03:25:24 -0400
Received: from X250 (cm-84.211.118.175.getinternet.no [84.211.118.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895942073D;
        Sat,  3 Aug 2019 07:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564817123;
        bh=nQgmvuwty+IpGuxuskizAqv+iX4PZOcNYWEpHdFpGzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a3CYUCjcyMQlyHtmHrnAArp/g0S1/+DYikO2YC45lrhcYRLzSZ2wij3yNjgJenw9t
         Wx6ntrbnEVFpwlGmhd5JPvcZ1Ia5Ov5Rtcgs5i8obGAcNs0XIMHrOsrucrjaChxECQ
         n9G+lDPYPwaRHhy63ngunwzdqIwOHdGjaKaGnPM0=
Date:   Sat, 3 Aug 2019 09:25:17 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] dt-bindings: clock: imx8mn: Fix tab indentation for yaml
 file
Message-ID: <20190803072516.GA7597@X250>
References: <20190725020551.27034-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725020551.27034-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 10:05:51AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> YAML file can NOT contain tab as indentation, fix it.
> 
> Fixes: 6d6062553e3d ("dt-bindings: imx: Add clock binding doc for i.MX8MN")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

I squashed it into the original commit.

Shawn
