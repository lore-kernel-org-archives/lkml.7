Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38D6C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54B9206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556228046;
	bh=/6OJQu0ZK4y11n1Q8S4AnQAcH4oz3UCYvQXvJSeIkw0=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=qfgIdvdrtVklgMl9RjrMNVdx9YxSaw81smnfqHPMFEiiKLGuZxc/wX+tx7xgp1LX9
	 LrOhhEDOwDPNjr7j/J7bPCl01vs9kB2R0H2vTVMrkSEf2hknQ7pEeFSJpb1BRJcq9L
	 1rVuP/JN0pyydshlPvijpXldJC6KpaAI+RnDbcHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfDYVeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDYVeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:34:04 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1082A20675;
        Thu, 25 Apr 2019 21:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556228044;
        bh=/6OJQu0ZK4y11n1Q8S4AnQAcH4oz3UCYvQXvJSeIkw0=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Fe0EcPKr3p3JCv0GqLkFxwJjjhPrHwh6WTWUpvgZtZ5Vuw0Wr5oowEHOwTc5/K/pk
         y/e1/TMH7GhwJ6xh8NDyS9Driwx4WKiVyfs/KStaHCW1h5ajYZckxfAFoC5ADb+qx9
         EotqDEuyz4f5rmczolzWZZfNTBCGOYPiUd63/8Ao=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190323211612.860-12-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-12-fparent@baylibre.com>
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 11/24] dt-bindings: mediatek: topckgen: add support for MT8516
To:     Fabien Parent <fparent@baylibre.com>, mark.rutland@arm.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Message-ID: <155622804294.15276.9513683589761355567@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:34:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabien Parent (2019-03-23 14:15:59)
> Add binding documentation of topckgen for MT8516 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied to clk-next

