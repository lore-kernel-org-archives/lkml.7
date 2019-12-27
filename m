Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ABAC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402AF20882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577422724;
	bh=yWsd5G0WUxN+iBk4oErsNJp25PktWWWeD+xxPEb/IuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=atq2jGMa5454cTKre4pA5fRgRfUqc5s2Tu914UUvp2ZdmMK1e4xhv5oDXY0KVHis1
	 t+On+ks0AIqdK2Gw+MU2XCUWBV6goQZbl7NXgT0sm4EqZNihBUiy6Gif45IJYeO31S
	 bV7i6u+DwKrEC5qF9tJNtjSJrP4wvrbORmGnSrUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfL0E6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 23:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbfL0E6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 23:58:43 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A513020838;
        Fri, 27 Dec 2019 04:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577422722;
        bh=yWsd5G0WUxN+iBk4oErsNJp25PktWWWeD+xxPEb/IuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrYLQr+5NZzn3kPbaqmyzDevAIoV7rXxXnOQ2OSkzYU+sCJDx35aJOTOE8Q4DsIXS
         qG/fVPIl5gPmSt40bfhBdFWKETVRD5rJQp0wIK2NPptTb6no1d58789Lqf4Dsqtbuk
         zla32tu2pUQxOYqlzSx2HYuVrF+vAMSHRFlPCmJI=
Date:   Fri, 27 Dec 2019 10:28:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: db845c: Move remoteproc firmware to
 sdm845
Message-ID: <20191227045838.GB3006@vkoul-mobl>
References: <20191113203951.3704428-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113203951.3704428-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-19, 12:39, Bjorn Andersson wrote:
> The redistributable firmware should work on any engineering device, so
> lets push this to qcom/sdm845, rather than qcom/db845c. Also specify the
> path for the modem firmware.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
