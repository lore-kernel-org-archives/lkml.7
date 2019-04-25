Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8729AC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D35C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556228082;
	bh=TeFMU285vQsKoeyW6YnIsqqiPOWUxTotNNhyVhxNaTI=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=DGZBrf/3bafZVTa5zMB3ADxi4QeXwjfG+5Lpsnq95nF3maFaLWQgkio1zcpsvu2Z3
	 e1ZSIln4WgSB8nOuOoq7ISMVrNyXKWbnpd88KnmnAsLGpbocC1xk0bpakIU2RAUHSC
	 C2ELbKicuLnXNXDhtFt8ZDatMc5a+lKDcNQzLK6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfDYVel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDYVek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:34:40 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F033B20675;
        Thu, 25 Apr 2019 21:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556228080;
        bh=TeFMU285vQsKoeyW6YnIsqqiPOWUxTotNNhyVhxNaTI=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=YzsBsz+OkKnK1iC+GMLS838W9zhtyF4cac6F+kRUAUbVtIhzE5mmgV7ZsW+NcC6br
         3ntbDPRO62kqsMJg0Dy3c5T9Muq/H5ISNCRgMhiDVFrS3sRqu92B6Z3niGPSsJOCCm
         +FLFHGMUxnVwKi3eR43tODxOpnoxKWWPdEL7v770=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190323211612.860-13-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com> <20190323211612.860-13-fparent@baylibre.com>
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
Subject: Re: [PATCH 12/24] dt-bindings: mediatek: infracfg: add support for MT8516
To:     Fabien Parent <fparent@baylibre.com>, mark.rutland@arm.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Message-ID: <155622807901.15276.4074098056713390821@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Thu, 25 Apr 2019 14:34:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Fabien Parent (2019-03-23 14:16:00)
> Add binding documentation of infracfg for MT8516 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied to clk-next

