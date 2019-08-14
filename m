Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229FC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A398520665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803367;
	bh=GAzNd5pRsAMxYsgNXow8Gp1w93OVWSHeKuTwNE0agvI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Mt4USXnznvw9UIVzavPjqt6b28XVDKtIIV5rEpDClOKzUht9ePnMDcd7oXX3cyM6f
	 eTr2ahWuMMtDLNWM4wGj7ndqVIZJqRbxl2fdBOAsZf+VNnTgGYhT8tI7enc+Vy1whd
	 UU3it6A8qLhC/bPO8ToRiAvIUbTl8Op/oiwc9Nnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfHNRWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfHNRIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:08:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB462084D;
        Wed, 14 Aug 2019 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802499;
        bh=GAzNd5pRsAMxYsgNXow8Gp1w93OVWSHeKuTwNE0agvI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2uO4dnAdNJcoelnyoXMqDZYVG/OXEc8SI4K/A5t9g/LrCDldOORasOKaNgS4do8j2
         wAfrDkDlohQ7HLW+b5O7iVSuY0gVoh/C3HdJ7FMQcZxwliFtIVg8jgaEhJICvEU8AH
         TpSTQ+Rqv2mxi0OEPwgRmtzosphNfqWvipbGtoqI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190814125012.8700-12-vkoul@kernel.org>
References: <20190814125012.8700-1-vkoul@kernel.org> <20190814125012.8700-12-vkoul@kernel.org>
Subject: Re: [PATCH 11/22] arm64: dts: qcom: pm8150b: Add gpio node
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sibis@codeaurora.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 14 Aug 2019 10:08:18 -0700
Message-Id: <20190814170819.4AB462084D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-08-14 05:50:01)
> Add the gpio node found in pm8150b PMIC.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8150b.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Squash it?

