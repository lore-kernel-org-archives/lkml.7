Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE5CA9EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 05:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F1E21928
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 05:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572153146;
	bh=nQIgYtdmE5iOAHFZmW614Kg+/JtIT+5vGjcXIskojSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fwa3EtDkRAQUbIK7hAAhKaJcXLrJ1unXgXmNPiuwvluhtEYW/hlRcL8zCxQc2/5I7
	 wHmReLdCO8wzZU48GViejhzp9VdLWaG06gTa5rq07Os37wFK3WoslKiVnGl3CEXIXE
	 9yUfuu+Mu3cpJ83iUFdAq1jiPv9AADrh8WCjJC5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfJ0FM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 01:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJ0FMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 01:12:25 -0400
Received: from localhost (mobile-166-176-122-39.mycingular.net [166.176.122.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BF222070B;
        Sun, 27 Oct 2019 05:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572153145;
        bh=nQIgYtdmE5iOAHFZmW614Kg+/JtIT+5vGjcXIskojSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h5/XfO93pg2k5bjQb66v0w8ys5w9iHbkD6bdWczGKDT5qWWngAPDRLEr1FB9P6Pov
         wS0GcaEzpKiKh3jGkQ2fsUGTkEmNrL+PGpzBw+HQKC1OvrEPJm8vdlmfJwXeJVkou+
         g/NrXb2X8/5F711Ae2WZWE9P2qU4HMnvrCLdPZM0=
Date:   Sun, 27 Oct 2019 00:12:21 -0500
From:   Andy Gross <agross@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 05/15] arm: dts: msm8974: thermal: Add thermal zones
 for each sensor
Message-ID: <20191027051221.GG5514@hector.lan>
Mail-Followup-To: Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        masneyb@onstation.org, swboyd@chromium.org, julia.lawall@lip6.fr,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        devicetree@vger.kernel.org
References: <cover.1571652874.git.amit.kucheria@linaro.org>
 <72cc755c16888976edea555f1df60a299daa8a1e.1571652874.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cc755c16888976edea555f1df60a299daa8a1e.1571652874.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 04:05:24PM +0530, Amit Kucheria wrote:
> msm8974 has 11 sensors connected to a single TSENS IP. Define a thermal
> zone for each of those sensors to expose the temperature of each zone.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Tested-by: Brian Masney <masneyb@onstation.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Applied for 5.5

Andy
