Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD474C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933BE208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561342137;
	bh=Dlgy5y6IOr86zrC5ULsIEkU6O/3QFT09EgHJe2Me9mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JyLj0EtIFWppih7yibCZZ/RFzgvcuz61JRxWfpPt+FhlJY+5anjFhzg/oK1S4j4D4
	 p/C0N7+lB+eYTSWvNZ67U2C3Izqsef4LAQmncChmYy5D1f+U7RMjpjaZQYgOyk3xwO
	 P93ImhSb4LArNhhP2I0xnCNrtinR0sytYSqQOzwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfFXCI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfFXCI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:08:56 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71A3E20679;
        Mon, 24 Jun 2019 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561342135;
        bh=Dlgy5y6IOr86zrC5ULsIEkU6O/3QFT09EgHJe2Me9mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6MIivq83ozx43WU+GTcEau8ddmJwxS97aO4ThD5bQf8pe/Des3N4ioBzWYN+JfJG
         jmXbIrZv/Me+abGr9zu+HDAdMtre/GvqQkn1syvd7SHy50TuQePJb+LNOR4BjWapuT
         gXzr1+gH6tfwfuSbPNxIq3GXlMJNe3gPWLsdTnAw=
Date:   Mon, 24 Jun 2019 10:08:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: fsl: librem5: enable the SNVS power key
Message-ID: <20190624020841.GL3800@dragon>
References: <20190620170532.18845-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620170532.18845-1-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 11:05:32AM -0600, Angus Ainslie (Purism) wrote:
> Enable the snvs power key.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Applied, thanks.
