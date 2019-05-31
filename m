Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C46C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962D6264E7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559287730;
	bh=QxnEIAuMjeVnNv5orkkiuF9Lbcy91s9E5WW6FJ7br3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wT6aszn3mkdo+YqgxOSVoh3drKxaNgN0ZsSulaTjjbXevmWoDhWuwnOKoUuKCgtWo
	 vfql8ZS4bXrYsKYdRtdgvPhbvpoU5UhgtRjtP8Fqy/RHvgSXcRPbQ4P6VB5gPVLBCn
	 uQHKmR8R8NMHLWErnfjKr55nATe9UMiLvfDduNmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfEaH2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaH2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:28:49 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC6A2650B;
        Fri, 31 May 2019 07:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559287729;
        bh=QxnEIAuMjeVnNv5orkkiuF9Lbcy91s9E5WW6FJ7br3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qlcQjViLKQ5cUCw4eQNi52wfuudi7KQT309H5Fxh4it9mOmifPNWK1cqUEFxDV/jj
         v1pTSbX+gIqUieq58yUMepC/5WthFis9z2fBkxnx7SVQXjsqzLFUQHGdpIwCvpDTWv
         ilEdW7LiEJTAc0oEgJ7UvQhAZ6Csmq6CXP5xdmK0=
Date:   Fri, 31 May 2019 15:27:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 1/2] arm64: dts: imx8mm: Add SAI nodes
Message-ID: <20190531072727.GB23453@dragon>
References: <20190515144210.25596-1-daniel.baluta@nxp.com>
 <20190515144210.25596-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515144210.25596-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 02:42:28PM +0000, Daniel Baluta wrote:
> i.MX8MM has 5 SAI instances with the following base
> addresses according to RM.
> 
> SAI1 base address: 3001_0000h
> SAI2 base address: 3002_0000h
> SAI3 base address: 3003_0000h
> SAI5 base address: 3005_0000h
> SAI6 base address: 3006_0000h
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks.
