Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F82FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA652184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555014757;
	bh=UPgjiCmyjFjtjSM5AbviElA1q8wDpQaiU5NfmcHVJG4=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=CMgv6oy6+dwcsGFWqsarZEMk4AOVt2Yd7soJeZXcgGoVJOTyexLV2uHDxauCDa415
	 utr0MYu+w1Dfk9bSXcaTnbdMFF/5xHZ03P26fwDiY3iB5Zl42cstARndzVr4wRoVjV
	 2r3k8gDcYcNZzF4Ypeh2ZHSRBtwrLAJte9kKUEXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfDKUcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDKUcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:32:36 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37A592073F;
        Thu, 11 Apr 2019 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555014755;
        bh=UPgjiCmyjFjtjSM5AbviElA1q8wDpQaiU5NfmcHVJG4=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=jJ/leix3rMT0rql16yvfDI/jGhUgow9fJE/wee9DbO1xnfoUtrlwbumcUrNtOcfz8
         kkyWRy3HC649spQs8FIUMazSOr0VhwqgNRQ+JDjieq3+bt6DTHIxrMWBLF/FtZmAFQ
         RcEBkFMyhyxpUrTw7/eUfdPfNquTy8gBLUn9+aDk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190306055148.10823-1-bjorn.andersson@linaro.org>
References: <20190306055148.10823-1-bjorn.andersson@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: gcc-qcs404: Add CDSP related clocks and resets
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <155501475438.20095.12629556637191717943@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 11 Apr 2019 13:32:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-03-05 21:51:48)
> Add the clocks and resets need in order to control the Turing
> remoteproc.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

