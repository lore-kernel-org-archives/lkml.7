Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF9FC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46FF2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560841830;
	bh=kE3MmzvZTygkPVcZHnSFvoO/LaEEXlbMMluK5iiTHk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EFVjHgQQud4y9aCxehOB18hR7H8VQQoOuXQABa6GBamo47zThnGieBbhNBnaUpJAZ
	 M9AV8e3bW37kZFBswDxLpgBBXRtOIF3pDKVV1q0QBPJIiXPAy9TmP/sFEdX3izivYg
	 icQV0MkB/o2PPsv8uP5oOCJj390y9UwrIlQmaGUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfFRHK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfFRHK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:10:28 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A3020679;
        Tue, 18 Jun 2019 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560841828;
        bh=kE3MmzvZTygkPVcZHnSFvoO/LaEEXlbMMluK5iiTHk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iu09j7IRof5xp35w/w0RZx+n3twZu7wvno3/+0ujDn6h4WBu6LzgrHVWdNjDLIhZb
         EcntIhQ52huhEkQQQhWIROx20oL9n4jx7QkT0ReKyV4OUlFgj+rAI55CBWUDSP5wG0
         0r2i+l+3SoLxkpYLQF+wKb0f70QJK9xvPCoxabPI=
Date:   Tue, 18 Jun 2019 15:09:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ping.bai@nxp.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mm: Enable SNVS power key according to
 board design
Message-ID: <20190618070612.GE29881@dragon>
References: <20190613020104.24612-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613020104.24612-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 10:01:04AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> The SNVS power key depends on board design, by default it should
> be disabled in SoC DT and ONLY be enabled on board DT if it is
> wired up.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
