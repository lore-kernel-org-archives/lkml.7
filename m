Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56DBC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9714720872
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JM7MZfoJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hgZ4nWw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfFER0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:26:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37050 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfFER0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:26:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5FE9360E59; Wed,  5 Jun 2019 17:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559755610;
        bh=2evWTxdFbkeUdR6ga+Ohoj6kOtwJ9cgbxQLfNdc1t1U=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=JM7MZfoJ5SXkX+BnPJlilvJgbD35i3W2OSqkvwBCfwbAK4+it7H+1fCYbt/TAjIOq
         8Qgn+t7/l/dFPi+44H76oXqe1HXmBstxv1HOCASuJYrCON9o6hUKuw4vxAXaHfSlz1
         9oZw+N3+xP3gZwVvsJguygVQbe5Moxf9fg72fEMI=
Received: from [192.168.1.6] (unknown [122.164.184.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2FF6760741;
        Wed,  5 Jun 2019 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559755609;
        bh=2evWTxdFbkeUdR6ga+Ohoj6kOtwJ9cgbxQLfNdc1t1U=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=hgZ4nWw3bvopFQW6hDoRLvEyGiRohLWXZ9F0axpksO6Rh1AjgCyAya/NaKvZBDklQ
         lKv76NaJCC8lBGBW7BYMlyo19zfky6jSOTbexjHbi07DBfNzFrFUT0osF1Eg1GiQaf
         35CiUrBe/pH6UtdKNJna53c3KEADgvsavVc3GixU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2FF6760741
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH 0/6] Add minimal boot support for IPQ6018
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh+dt@kernel.org, sboyd@codeaurora.org, linus.walleij@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <d6ccfaa6-bbcc-c0be-918b-d4c0ebda66bb@codeaurora.org>
Date:   Wed, 5 Jun 2019 22:56:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559754961-26783-1-git-send-email-sricharan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, Got sboyd@codeaurora.org wrong. Will fix and repost

Regards,
 Sricharan

On 6/5/2019 10:45 PM, Sricharan R wrote:
> The IPQ6018 is Qualcomm’s 802.11ax SoC for Routers,
> Gateways and Access Points.
> 
> This series adds minimal board boot support for ipq6018-cp01
> board.
> 
> Sricharan R (6):
>   pinctrl: qcom: Add ipq6018 pinctrl driver
>   dt-bindings: qcom: Add ipq6018 bindings
>   clk: qcom: Add DT bindings for ipq6018 gcc clock controller
>   clk: qcom: Add ipq6018 Global Clock Controller support
>   arm64: dts: Add ipq6018 SoC and CP01 board support
>   arm64: defconfig: Enable qcom ipq6018 clock and pinctrl
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml    |    2 +
>  .../devicetree/bindings/clock/qcom,gcc.txt         |    1 +
>  arch/arm64/boot/dts/qcom/Makefile                  |    1 +
>  arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts       |   35 +
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  231 +
>  arch/arm64/configs/defconfig                       |    2 +
>  drivers/clk/qcom/Kconfig                           |    9 +
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/gcc-ipq6018.c                     | 5267 ++++++++++++++++++++
>  drivers/pinctrl/qcom/Kconfig                       |   10 +
>  drivers/pinctrl/qcom/Makefile                      |    1 +
>  drivers/pinctrl/qcom/pinctrl-ipq6018.c             | 1183 +++++
>  include/dt-bindings/clock/qcom,gcc-ipq6018.h       |  405 ++
>  13 files changed, 7148 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq6018.dtsi
>  create mode 100644 drivers/clk/qcom/gcc-ipq6018.c
>  create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq6018.c
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-ipq6018.h
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
