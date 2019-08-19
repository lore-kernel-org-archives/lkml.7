Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15983C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D617D2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566221138;
	bh=6r1/vyEsP1XDK18vZbK7ergEOexctMBSCUjVwG/OuV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vJfKOgPOMm9wmIF+XLsCDavK0A6XumFetg8eh9/pRmy6OApq1uhBrmHN6FlgdQEwh
	 gZDs+H0Djdw8OhzD5rDg2U7P0clFPsnzYUo2Dqv7SW+EAUX7dkzlgu8FIz5SAfm+GL
	 UQ719WIQeXjNwSlM1Vgs7RGB7z+MEOPJVy/uU4Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfHSNZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfHSNZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:25:37 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C9E2085A;
        Mon, 19 Aug 2019 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566221136;
        bh=6r1/vyEsP1XDK18vZbK7ergEOexctMBSCUjVwG/OuV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=17e7Jjs9xizwLvMtiPB8x61b1RM3ss0gRAoFj+3cPgyKgkQv/azXq3hqC/+cL4R53
         Un1MjUEBoSfJgjbG/uJR26Pmh0iz4aGoGrJ4htSVkLG2eNeOiURrC+xHRxJzNzTgKB
         2HqeNipJxkP2Egx1ZkDyw12kd16G0FHFMwpaK5CA=
Date:   Mon, 19 Aug 2019 15:25:21 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, ping.bai@nxp.com, jun.li@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] arm64: dts: imx8mm: Enable cpu-idle driver
Message-ID: <20190819132520.GK5999@X250>
References: <1565950383-589-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565950383-589-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 06:13:03AM -0400, Anson Huang wrote:
> Enable i.MX8MM cpu-idle using generic ARM cpu-idle driver, 2 states
> are supported, details as below:
> 
> root@imx8mmevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state0/name
> WFI
> root@imx8mmevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state0/usage
> 3973
> root@imx8mmevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state1/name
> cpu-pd-wait
> root@imx8mmevk:~# cat /sys/devices/system/cpu/cpu0/cpuidle/state1/usage
> 6647
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied, thanks.
