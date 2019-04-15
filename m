Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4432BC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1552E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555319522;
	bh=N+5rhBnY3WIBMSf8JvKcry4dgbo24p1ZAxcYN2GJNpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vluGdL/3CAQkarNT9MmdA2YzctCc/bGTQi52r0kMh8kPbwhaknr+Lp1IKARDofeYs
	 UDQkj1I/dVRFtkRglXwHKbNSoKD0TLbB3iTPGLP0Bt2H4KTTlI0pLrXW0yfA1ZqTMr
	 hAAdpEZXwzCjdE9VZxKVpmfvJD4WZWx6dfAWsNQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDOJMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbfDOJMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:12:00 -0400
Received: from X250.skyworth_vap (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76E462073F;
        Mon, 15 Apr 2019 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555319519;
        bh=N+5rhBnY3WIBMSf8JvKcry4dgbo24p1ZAxcYN2GJNpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+4M3dXxZED0IDZp8/Q6IRjPyEAvI61lqA00KhQ3844dyUuF1Ca2SxqzGFfF5q8sS
         BnAwEWsCNksSONYULh8wz18440WvU0OuGarGtqO0yrEMIcLmJm2jaA7ECLTbUSEulw
         XDsALPCMqFBkGaNN11byZPNhw1JHcVxToFFk3oc4=
Date:   Mon, 15 Apr 2019 17:11:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Kueffner <kueffner.markus@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG
Message-ID: <20190415091150.GB18917@X250.skyworth_vap>
References: <20190411065440.GB26817@dragon>
 <1555161577-1533-1-git-send-email-kueffner.markus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555161577-1533-1-git-send-email-kueffner.markus@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 03:19:36PM +0200, Markus Kueffner wrote:
> Add Pincfgs to enable the i.MX6's OTG feature for UDOO
> 
> Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>

Applied, thanks.
