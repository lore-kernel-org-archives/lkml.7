Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6559C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BC922CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566241733;
	bh=hKKokWvdTtt0L3+3PBxynmZ/1K2qD5A3ZQsLufZc6ZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s8T6B30fmMNU2cLc7is3hi6PEtzVkjMpOOsSJnrBqYwZWRddus87ubOtpKxvzVhRj
	 H0p64YczqXkcv5QhTVXmRq71t33IQE0E05kQbjBnEfqSD1G1pEAZPFwiSnMMNuPi4Z
	 vf30plO/SMylvRukO/ea5URDflQAyJ/dFj17smtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfHSTIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfHSTIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:08:52 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F4722CF4;
        Mon, 19 Aug 2019 19:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566241731;
        bh=hKKokWvdTtt0L3+3PBxynmZ/1K2qD5A3ZQsLufZc6ZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L4OGbR0aGXZZqfOp99j+gd9RtdmR4nlWplkz/oWA3hlJx+nA1RFULQ/U+Tr2SSjdx
         +cgFSi5pcy7TI/8yLHccMX+ZNQcxJ5UqqAdVvLjjkFb8VPjxUXsvlsgZgDJCESZ2X9
         omDajPMk5AOqyC3V9KwgswBoHmmUDjKtceLS6oOM=
Received: by mail-qt1-f172.google.com with SMTP id j15so3101386qtl.13;
        Mon, 19 Aug 2019 12:08:51 -0700 (PDT)
X-Gm-Message-State: APjAAAUWuouLEnf78YPfmR+jQEH8NwvHA3RLLwQrZpsUCHoC6aRjtaO6
        9uekd79uWDtX1NzY993PnvMBLppY03HzxNxe4w==
X-Google-Smtp-Source: APXvYqxgXllJEuAzpab2Jc5x2K/U/N2VgZkKV3wmLeSwKMMzAAfB85VbJUzmHGfPmvfgL/ruAuKMJJYkju2ElceB4ns=
X-Received: by 2002:ad4:4050:: with SMTP id r16mr11993870qvp.200.1566241730428;
 Mon, 19 Aug 2019 12:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190819172606.6410-1-dafna.hirschfeld@collabora.com> <20190819172606.6410-2-dafna.hirschfeld@collabora.com>
In-Reply-To: <20190819172606.6410-2-dafna.hirschfeld@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Aug 2019 14:08:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJx6pTw7Pr=7f0jkC81JF+EDkyhHrvFehSWZV=0wy+YXQ@mail.gmail.com>
Message-ID: <CAL_JsqJx6pTw7Pr=7f0jkC81JF+EDkyhHrvFehSWZV=0wy+YXQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: imx: add imx8mq nitrogen support
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Troy Kisky <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:26 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> From: Gary Bisson <gary.bisson@boundarydevices.com>
>
> The Nitrogen8M is an ARM based single board computer (SBC)
> designed to leverage the full capabilities of NXP=E2=80=99s i.MX8M
> Quad processor.
>
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> [Dafna: porting vendor's code to mainline]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Please add acks/reviewed-bys when posting new versions.

Rob
