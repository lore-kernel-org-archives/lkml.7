Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED1ECA9ED5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4840217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 04:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572928480;
	bh=NDV59a3O/OthvWIdOBtwNTkBLDN4MF21O3Lcza0ndnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1wb7LlAamcPyT7oYHrQcmiEb4G8kHjObUOoHKbL6jjGfAgc8s5uGeCBfOAcV+lgLH
	 cq9LR8OGi/TgI/SU3G0bd3I6NyYaDNRldm3BRyqNB7q4VZ5UpEpv20LRZEb5jDP4Xz
	 OGnRFtx36nlSrEzIK+X8c9sq2sqBgO4mUur719yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbfKEEej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 23:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfKEEej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 23:34:39 -0500
Received: from localhost (mobile-107-92-63-247.mycingular.net [107.92.63.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B7F217F4;
        Tue,  5 Nov 2019 04:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572928479;
        bh=NDV59a3O/OthvWIdOBtwNTkBLDN4MF21O3Lcza0ndnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wd/EqbcO77qUEhuOpLFuztyjazitPQ09hDltw4NuSRk4Ra9lpswQWV9kKVcQfZexB
         WmKa1dDmjjB/fCUGCwo5C1PVd0nwMlB9pNDIYtjZoNAyItkRTZ0TTf4HhNNr6KJk+s
         9whynkKaGJhhgj6tMdSr9GZkKs6hBKzktvgKan60=
Date:   Mon, 4 Nov 2019 22:34:37 -0600
From:   Andy Gross <agross@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as co-maintainer for QCOM
Message-ID: <20191105043437.GD5299@hector.lan>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191104055036.63414-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104055036.63414-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2019 at 09:50:36PM -0800, Bjorn Andersson wrote:
> Add myself as co-maintainer for the Qualcomm SoC.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

I'll add my s-o-b and throw this on top of the next pull request.


Andy
