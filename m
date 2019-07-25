Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C25CC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C5D218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 21:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564090660;
	bh=DEqG5QVpqjFk6fDTKmZueo9OEbXtd2kkOwCkB9pcwsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rutr/p0qlfd+E7UfnMDRbzQZXTXtjiB1apLXrUpCd7eg2LrxXaItWp3e+8hgOJoZx
	 rov6ggMmlKLcZnONLQxnTPYHZydETkUI0TJzDibof3ktdZVzLmsPWSXSP5FLIsYcb8
	 2Z2MyP0/xCAma1jx5GZ+JOcEbQqMh24T4vMQIPsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGYVhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 17:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfGYVhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:37:38 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7024522C7C;
        Thu, 25 Jul 2019 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564090657;
        bh=DEqG5QVpqjFk6fDTKmZueo9OEbXtd2kkOwCkB9pcwsw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ChBuyG/zLWJRz7CNaa1J+2pTEKGQ5mPVZxhgAryltV3xIru5iRsalCt70Lgc+2swf
         OaUz0nXNxLffPqB602194PwAB1rEqPC8bnnh+EmKVVt2iF2akDyn7gCayH3wQD+9Gp
         1QMBZQQe+ocmwqbpkCawFcUezrKhOamAIJS4HUdo=
Received: by mail-qt1-f179.google.com with SMTP id y26so50588637qto.4;
        Thu, 25 Jul 2019 14:37:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVFqEB/IMriJV2MXTLzv2Frktdgt07eRlzyGioKA7wE3jCbagb6
        IQ5edU5ewexGZmyhiyaRcMJedLBIZJ8gRkarXQ==
X-Google-Smtp-Source: APXvYqwh/T3W6Tp6QVzMKguGCdgOPe7mHm3zxACkzb6VLbhzRa4V1o3Vyr0DiCBcMEJFji5FQ4vwo8d9PagXgK58joc=
X-Received: by 2002:ac8:368a:: with SMTP id a10mr63961851qtc.143.1564090656611;
 Thu, 25 Jul 2019 14:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190725020551.27034-1-Anson.Huang@nxp.com> <20190725210619.5EB94218D4@mail.kernel.org>
In-Reply-To: <20190725210619.5EB94218D4@mail.kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 25 Jul 2019 15:37:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZHG-y_cKitU0=EksgyVU-YLOi1gAcFXx4ve21CMki1g@mail.gmail.com>
Message-ID: <CAL_JsqKZHG-y_cKitU0=EksgyVU-YLOi1gAcFXx4ve21CMki1g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: imx8mn: Fix tab indentation for yaml file
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 3:06 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Anson.Huang@nxp.com (2019-07-24 19:05:51)
> > From: Anson Huang <Anson.Huang@nxp.com>
> >
> > YAML file can NOT contain tab as indentation, fix it.
> >
>
> Would be nice if checkpatch could check for this.

Would be nice if folks just ran 'make dt_binding_check'. :) It
wouldn't be hard to add a tab check to checkpatch, but that's just one
potential problem.

Rob
