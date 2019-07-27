Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE58C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89452085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU22+crb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfG0Oax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 10:30:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39203 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfG0Oax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 10:30:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so39003974lfa.6;
        Sat, 27 Jul 2019 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wv1yLIt8dyUH9BThIfQWfGHvzo6b2SQHOoH8T3cW6qg=;
        b=HU22+crbqQCvc6CPEy5y1z7SVkNPS/QEvJ51JimvDWp//wOJiEM3zWPyqjNL3wS06Y
         fVbQrEuRmpVr+j8PEhI1yqgP37EyXPkm3xYurGfhzYeHaGNZw++ukOxrwuyRwsUszXP+
         jRrk2KaPx5y0x+FXCyY93DHzSJKs96IzdsmPQ2znhsZwbgi0PANwuhaPvqNOpENejlH+
         /Cz4qdEA+n5sxseRCqHAQ7qF0qPscBas7zfOqRZ2iIEIhQNJrMW/F4VAn06whl9nyWod
         yDBdBHPoUDsn8CeUroBpQH5bh9RVV5Folr5W06bU5JylOFdS0DHW5W52DTRT7oK0eEQL
         zmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wv1yLIt8dyUH9BThIfQWfGHvzo6b2SQHOoH8T3cW6qg=;
        b=dH/aisWRCNlLKuqnJBohcevKRlEhP15zf+S0hlWtzHE4A06+2mUhefldIGbbtRyNNJ
         7ReVMEfS8NyQ18a5GXyhBnmQexrqgx4Mo62JdBEDSgAvcX+4it0d+BksQ6CIvc64+SGY
         wsxTcvHd3NNaJRijA1EBYLK82CvJ0jagX3fkkL0O149SRB6rizlyXYJHwN69I717hYgu
         UgT5/o0H0nPaUNjTjVttf13D2EGriDinFE/MyVpUiYqI2zxWShYrLn5qHhi3iG2sFTC5
         aA0s66uyLDvWYABPhWWKGWXUOGbbJnOj51Lxkg/0uLA4lcGZCdGeabby1kGjxzW48jWp
         NTog==
X-Gm-Message-State: APjAAAXB6BBjEo481fgRhPGZEpS0IJL5Odql3IKKH0tHAd859pzxvwk5
        pRxsQD1Y+dZyrWCJ3+5xkBNG6vzEqAN4h7xyN88=
X-Google-Smtp-Source: APXvYqzYz0/B0l1VoUh0y8S3xTIl3qB04gaGoqLIzQpM/BhZYYpP4jZDP9b0wf97pRFVTUmhqAl80aYJE+WkKg576I0=
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr27577350lfo.107.1564237850846;
 Sat, 27 Jul 2019 07:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190727142640.23014-1-krzk@kernel.org>
In-Reply-To: <20190727142640.23014-1-krzk@kernel.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 27 Jul 2019 11:30:52 -0300
Message-ID: <CAOMZO5BWdDZSitFTWOOR1dPK6TKAwZLZ_U5YWuCOqcPVRL8yWQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Cleanup style around assignment operator
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat, Jul 27, 2019 at 11:26 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Use a space before and after assignment operator to have consistent
> style.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for doing this cleanup:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
