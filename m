Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9BFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8B822CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 05:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567142812;
	bh=+P17J9tShmpWymIoBV3Fufmq/dNPsl5SAe0eYWEu+Gs=;
	h=In-Reply-To:References:Cc:Subject:To:From:Date:List-ID:From;
	b=iKQJCMYY3hS0Isx3OkEzEN36UaKAb9gRtfRPbiAPho+22hwb+HncmmW/n12uiOsoA
	 E2EM9BGwTF55uY4k4UaQtcl1gUMpXzHlLB6s68cjkY5xmvWOtneEisqhPjvFapRDoQ
	 QWPA8k78RjiY9hJqVQmdBI98GSrCijKZWyObEmeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfH3F0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 01:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfH3F0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 01:26:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6B4E21874;
        Fri, 30 Aug 2019 05:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567142809;
        bh=+P17J9tShmpWymIoBV3Fufmq/dNPsl5SAe0eYWEu+Gs=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=WHJulB7ORcPRovQuT1ftjog7EP0D+91Qgpp6CTS80V5YeHFuQLN0hpA//p6gZ+C9T
         ev/tVSIQp+0azYYsRb1hpxj0jIZd9Nn/UgQPwqXyg1sxSVp37nJy706FlMQbDbkdAV
         Wz3+AdGRTS5jLnzal/QfQwEKMkFif4Aj9aq4DTUY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190822171135.26488-1-vkoul@kernel.org>
References: <20190822171135.26488-1-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sdm845: Add parent clock for rpmhcc
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Thu, 29 Aug 2019 22:26:48 -0700
Message-Id: <20190830052649.A6B4E21874@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-22 10:11:35)
> RPM clock controller has parent as xo, so specify that in DT node for
> rpmhcc
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

