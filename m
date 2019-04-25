Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C769C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B46206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556228140;
	bh=YguPMd5wr2ROFmh6YQ848UffpOhhCNpwyareBnFMOAY=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=oDpiyi6Ih9fBqtU06PV5VhL2zCyBZ8sR8+7iNVrotxKCgkS6ANuZ59PclhxEWB2bO
	 tb4AeqZ3b34vOmZmQz6WobWb8h9jCSbDMafVQ+kiT+qb2u0T/f/i1KcuRfnJwSfnTk
	 3IkddOi4hJiLJI+coB7J4r0DK1Yme5rzP3Uf6xxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfDYVfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:35:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfDYVfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:35:38 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B359220675;
        Thu, 25 Apr 2019 21:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556228137;
        bh=YguPMd5wr2ROFmh6YQ848UffpOhhCNpwyareBnFMOAY=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=Ka3TBetgGIoGfg2CC2G3MmhI7tYM6Gic0tMMSbWvsXA0JQLSI0hOefBL44fDhmaU3
         LF1SBsoU2MS96zzIT8ombyYqUkM4N5nHygB4L8B3rAxdENHQoh9Z8Njq+L0zXBHWvH
         P7mUoVsITmYuy+TU3fTt+iJDt1vyO7/UPTJMxKPM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190323211612.860-14-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-14-fparent@baylibre.com>
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
Subject: Re: [PATCH 13/24] dt-bindings: mediatek: apmixedsys: add support for MT8516
To:     Fabien Parent <fparent@baylibre.com>, mark.rutland@arm.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Message-ID: <155622813672.15276.2529493939985880382@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:35:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabien Parent (2019-03-23 14:16:01)
> Add binding documentation of apmixedsys for MT8516 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied to clk-next

