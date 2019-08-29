Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43977C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145A72189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567107120;
	bh=c0TKOHtsdLnSEh9la+4SDm3KlsaHmyTiTtfSkyUPfIs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BsQ8nA/9gQfO4tsWPlr43eMesEE+SlHsqH+fDn1nPRdrHh9s42z0QZT/Sio0bPSAX
	 1obTH2DQBCKzqIbARwN7RmDpKk4G8hGvcmnwRNG8sT0oMwVNfYmtjObTWcXSd1fEx7
	 m4vculvYeHsCVWQaBGKm+6Se7yhijfn12L40rYf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbfH2Tb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfH2Tb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:31:58 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1EDD233FF;
        Thu, 29 Aug 2019 19:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567107117;
        bh=c0TKOHtsdLnSEh9la+4SDm3KlsaHmyTiTtfSkyUPfIs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCNN9v+EA/zeZInhJp8Dnihzgo6vQfghmvl59uaEdSrQR+PeimsL49pUMV7ECV8up
         cLfnsqkbRa2jOWmFXQ9QEpS4yS9bwwDUjHsglgxdBKLl0PAOD1O+r7t9A7EMwiya7s
         jps1UkaLmwZ9GI2OFc37hjD8SVts/sE76ybWHVlo=
Received: by mail-qk1-f171.google.com with SMTP id g17so4030361qkk.8;
        Thu, 29 Aug 2019 12:31:57 -0700 (PDT)
X-Gm-Message-State: APjAAAUM0a+MwiGCxkU2HY0sS99mhQcrD4e/UOURCxHZrX5eOJwBlgNi
        HAu4AuStaPSvhdwpk2kWuOj4gBrxN5VlcsVsVg==
X-Google-Smtp-Source: APXvYqyOpevKjOl2JqIzIoObDTg6SqZCtU6dOEEUknkpmml061ROH76tm9++13JepO+XnE7NvUxRUEpL3ozPoY5XaPA=
X-Received: by 2002:a37:8905:: with SMTP id l5mr11619212qkd.152.1567107116986;
 Thu, 29 Aug 2019 12:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190829163514.11221-1-srinivas.kandagatla@linaro.org> <20190829163514.11221-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190829163514.11221-2-srinivas.kandagatla@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Aug 2019 14:31:45 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mgx903vcawSxo8DhVgXyOet1DvA4hc8DpPO02sWMOig@mail.gmail.com>
Message-ID: <CAL_Jsq+mgx903vcawSxo8DhVgXyOet1DvA4hc8DpPO02sWMOig@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: soundwire: add slave bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:36 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../soundwire/soundwire-controller.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
