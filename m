Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F38C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29952084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554825065;
	bh=SjbNY9MQP+9XnkvUpwJQ7nH4enkC6CDEMMsSB+0+ufY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QN+IvdaXEpbcLMAknEmY15DABmwcSJ/G7NSS7ivf58ZRYGNPL83QXMNtWIKegJvxF
	 QHa2WuJTeN6Eb504N6MMZ/XMHt+zocrWQ6hsMK2lniH6618St3O7xegLJ1szItZd9a
	 d4vO6sykdXNdkAPw4MKatWZT1/qp8oETfJAeJULM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfDIPvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfDIPvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:51:02 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFC422190B;
        Tue,  9 Apr 2019 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554825062;
        bh=SjbNY9MQP+9XnkvUpwJQ7nH4enkC6CDEMMsSB+0+ufY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OS61RgTnKKzTPwL4SD8av91Cp67oLc+zZxvfihdTOWSCp0qiQ1ru3xXcFz44oikZp
         1yJigLagiQlgHaBFeOgkM+baEnX59A/Pmq4fqegWyMDMzenRSqweMXmTYqjbySO72X
         uq9zkw410itbdDvL6Np9yOX7q7anm6MyCeATv0NE=
Received: by mail-qt1-f178.google.com with SMTP id k2so20405377qtm.1;
        Tue, 09 Apr 2019 08:51:01 -0700 (PDT)
X-Gm-Message-State: APjAAAVXD9lFwSWmgSeLRWzrTFJlv8Jfj8XEwsa/HmagHYPsLltJIcEZ
        xA0IeuueWwohUCVTw6eccGkG4hOhxzTrklRTKw==
X-Google-Smtp-Source: APXvYqwfnLKSgUFbJxt6Ibma4uGRJdHvZGMhOjMS+ZY0B1dnNeTrxdgDLuOm4oLkT5wl6nIPoBsxLm8RPMa1YspPBUc=
X-Received: by 2002:ac8:2cef:: with SMTP id 44mr15071611qtx.178.1554825060974;
 Tue, 09 Apr 2019 08:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190409144250.7237-1-TheSven73@gmail.com> <20190409144250.7237-5-TheSven73@gmail.com>
In-Reply-To: <20190409144250.7237-5-TheSven73@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Apr 2019 10:50:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com>
Message-ID: <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] dt-bindings: anybus-controller: document
 devicetree binding
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 9:43 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> This patch adds devicetree binding documentation for the
> Arcx anybus controller.
>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  .../fieldbus/arcx,anybus-controller.txt       | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fieldbus/arcx,anybus-controller.txt

DT patches don't get in my queue if you don't CC DT list.

Rob
