Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0498C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 987452070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 06:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565591850;
	bh=yzB5zh4Nx6+UzoV/qKu39N7ca/NcQkTP25F/oH/DAUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MeZmFnW6A0PhoFIt7sLwWs6xsynoMWIQR9orVG9w1g1ZnmXorutkRwNx1bitq+Sia
	 A+q379g/KpcDluZsrXfxuhkidDR5/WA4ceJvj+voG1nFLEZbguzKigmJ1++4s5hHn5
	 dENgai6LoIzYy0+wfLvEZmsMrmFLE/2J7XMyIgEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfHLGh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 02:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbfHLGh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 02:37:28 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56EB2070C;
        Mon, 12 Aug 2019 06:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565591848;
        bh=yzB5zh4Nx6+UzoV/qKu39N7ca/NcQkTP25F/oH/DAUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n8dhDwk/RXQ1MwkksvGZU6TTH/09lZzwQO/+QAqS71qES/V2mrf3enUCR0KuXMYTG
         P7N3WK1cXS9Aqh44AufGcskqoGprkNyZ71HvrEAGOZNfvO0OW9+IJFAD0SQHt4Njbc
         UM9eyQBSDsv1LB72IoMLne19iQU8aRP+aNxcCCcs=
Received: by mail-wm1-f50.google.com with SMTP id f72so11051480wmf.5;
        Sun, 11 Aug 2019 23:37:27 -0700 (PDT)
X-Gm-Message-State: APjAAAVp5GjOffl+JIDlKeIMOrYjBs1ehXI+lubRQqvU7OOSSeVReQAU
        s8UXlx8/1tVspoDwFtvVMbFbPJfE/C7rwW2HsQM=
X-Google-Smtp-Source: APXvYqwCMmZLThLs+ABWEFDndGaEubz/Nt5ZO+lSRkNAUIHiANERBPLWnIFyXv7U/9+AyVUfzIsZIZwRnc0MCDOeMeU=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr25235520wmc.25.1565591846502;
 Sun, 11 Aug 2019 23:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190811203144.5999-1-peron.clem@gmail.com> <20190811203144.5999-4-peron.clem@gmail.com>
In-Reply-To: <20190811203144.5999-4-peron.clem@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 12 Aug 2019 14:37:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v64L0VNdb=b64N4CTNT9DBYSZO8wGr2SWDiwuvYp0CNEzg@mail.gmail.com>
Message-ID: <CAGb2v64L0VNdb=b64N4CTNT9DBYSZO8wGr2SWDiwuvYp0CNEzg@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 3/3] arm64: defconfig: Enable Sun4i SPDIF module
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 4:32 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
>
> Allwinner A64 and H6 use the Sun4i SPDIF driver.
>
> Enable this to allow a proper support.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Applied. Thanks.
