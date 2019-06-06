Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BEFC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D084120866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559789275;
	bh=+MwTvxbeyR43AvjkDTTFN/CTZFvCYYxViVY1qhfn7gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DzUu22saxvK+6AGW5SDBnMXItvnUfQW44c2Z218mhLrB7w+DXfOS4AHURBfzEQUi4
	 qwVJp4dEX5od1PJ6FHscyiFf5u7yaWTsFCmRpeALp7WJ+3oKu6AOOo+1DHhyUg2DXZ
	 nWB/t9s8fb1yP73WqW0/v80A0EfCo8BcMI46DiQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFFCrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfFFCrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:47:55 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A600A20684;
        Thu,  6 Jun 2019 02:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559789274;
        bh=+MwTvxbeyR43AvjkDTTFN/CTZFvCYYxViVY1qhfn7gg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnFq4myrIEwfsdgcKq8f7jMPDLWwi2QIWPzypddKAc8XmCbstWNFjlYAbiU3i4DQT
         7rpVlOww+ecBDtJyuCXN0Gr0jGpkraG+Pyy+rdE9QjpBLkLlYpBRhreYxJ6oTeivwD
         Vix7ivQFZd19t5/IYR1x32aCBJSuVw55pVh2Ox5Q=
Date:   Thu, 6 Jun 2019 10:47:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        ping.bai@nxp.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND] arm64: dts: imx8mm: Move gic node into soc node
Message-ID: <20190606024735.GX29853@dragon>
References: <20190606023936.25543-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606023936.25543-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:39:36AM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> GIC is inside of SoC from architecture perspective, it should
> be located inside of soc node in DT.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
