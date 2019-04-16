Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7EAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAE82173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555451637;
	bh=fHtFxcqZiZRoPr7MvBZgck05FUgpb26H/9wwwGxleaE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qScsGKFctIRhucZGma19fcfcjhn8PuCo1iW0UP4gPVeD1WWaP3J4dqBnDYw35j2SU
	 dehAdvrMgbjFoUvXDet3DnzBCYQ3cjbdCT0CmL9RdaS3ZnlJvLeVCYyRSGLfWcKosK
	 vPbuYYE0+jExz772V78jCaWMEcgSjCIDleWDrcAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfDPVx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfDPVx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:53:56 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6814A217D4;
        Tue, 16 Apr 2019 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555451635;
        bh=fHtFxcqZiZRoPr7MvBZgck05FUgpb26H/9wwwGxleaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FGG5Itk2GDdrKJpuK4GphzfdMXiFmKqthkXb83EeM/QxYRoCseKwsxQmieqk7xjZQ
         21RydLUMM4s+6E2jPr6+8lnV9DnzGq8GSzlI9uPRS2vy2neJMQoJXYQzNSxQl0oszU
         bpbRWlHN7zGTGK+ib+fMR/fku6Ql024DUFtvf83U=
Received: by mail-qt1-f181.google.com with SMTP id v32so25125930qtc.10;
        Tue, 16 Apr 2019 14:53:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXGBQml4bF9EZsDo5O5Y9FDuvxtb/Cs0dHum2yF2mq09D6chfEL
        /+dFZLSgV7BiNluIYYGMI5l/dCAHabmy9JY9xw==
X-Google-Smtp-Source: APXvYqzPHVQ59q7hpu3KnTJN+48CiCJ3Ufnseaq+9a1lVOXBt8JmQno3zdpdZU/M1JUAL3RTNbPctt7vKEvaKY5k6Bs=
X-Received: by 2002:aed:35f7:: with SMTP id d52mr65878733qte.335.1555451634688;
 Tue, 16 Apr 2019 14:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190414183403.21538-1-andrew.smirnov@gmail.com> <20190414183403.21538-3-andrew.smirnov@gmail.com>
In-Reply-To: <20190414183403.21538-3-andrew.smirnov@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 16 Apr 2019 16:53:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+zJVUNrYiM+-93GKWtmbd9fjDSVrKpk-2sE-VqAp8LQw@mail.gmail.com>
Message-ID: <CAL_Jsq+zJVUNrYiM+-93GKWtmbd9fjDSVrKpk-2sE-VqAp8LQw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: arm: fsl: Add support for ZII i.MX7
 RPU2 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 1:34 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add support for ZII i.MX7 RPU2 board.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
