Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF66C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF07214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552340390;
	bh=qJ389/3UsXc8mtAhNABnV0nvJfu0cKsmvbw2lmxka6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qrfIfm0CgIv/GRy6685tSXjPn/HmoDP+nYaaxFmNbaryoUGDiCMsQYTjAvKIli9+I
	 bfCHWJ8AmXpjO8ItIoJH25Vu2wDaKWX7o+dybA8zqpgWtOuhVVlLvbVpHLKxb2XfZ6
	 cWdCjolIMu7mvB9twq0IbiHAaMPPzxk9W9pljAkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfCKVjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKVjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:39:48 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74D62173C;
        Mon, 11 Mar 2019 21:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552340388;
        bh=qJ389/3UsXc8mtAhNABnV0nvJfu0cKsmvbw2lmxka6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBjKI37zus/+FQTMXSAxAaUgc+cW5XmthvxFqPVESm00O0CYQa4uJ5b7MzBZmcjnI
         FvCTc0a62EzYFtQSc+jyPHJYr2bGSvu5EqzHeHllUyBQp27TUOUTtMILaZXH64vjeH
         QTyDYGEgXInlOAWveb98AdJmWort84/PpbhYywDo=
Received: by mail-qt1-f179.google.com with SMTP id f11so309631qti.7;
        Mon, 11 Mar 2019 14:39:47 -0700 (PDT)
X-Gm-Message-State: APjAAAU/3wAZ8xVG4E/hJ51Ihb6BLgh0k3zDtkIP9oFNAM4ENfwqcG+t
        vYZcPk97jYqOmFcQg28P3cQ6E+SzbQd5jDQn1g==
X-Google-Smtp-Source: APXvYqxx6tG7XGb/BD8u1e5066p33ODLin8d61AiEQVNWFctsDB76A3HrH38SOs2v12qL96hOfedzgOg4OD8s9KHZ/A=
X-Received: by 2002:ac8:5445:: with SMTP id d5mr440421qtq.38.1552340387060;
 Mon, 11 Mar 2019 14:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190220085607.31582-1-peng.ma@nxp.com> <20190222143931.GA17132@bogus>
 <VI1PR04MB44312525A43E259CE9CC45F9ED480@VI1PR04MB4431.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB44312525A43E259CE9CC45F9ED480@VI1PR04MB4431.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Mar 2019 16:39:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+tBSw0d6=A6CS3=tWn7k4WX-KAeLBaoJ6019uGc-PRUg@mail.gmail.com>
Message-ID: <CAL_Jsq+tBSw0d6=A6CS3=tWn7k4WX-KAeLBaoJ6019uGc-PRUg@mail.gmail.com>
Subject: Re: [v6 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Andy Tang <andy.tang@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 1:57 AM Peng Ma <peng.ma@nxp.com> wrote:
>
> Hi Rob,

Please don't top post to mail lists.

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

>
> Thanks for your comments, I don't understand what you said.
> This patch is one of the series patchs(http://patchwork.ozlabs.org/project/linux-ide/list/?series=93099&archive=both&state=*) for review.
> There is not changed for 6th version of this patch.

I reviewed v5 and gave my Reviewed-by. When you posted v6, you should
have added the tag so the maintainer applying this series doesn't have
to look at prior versions to collect tags and so I don't have to
review this again and can ignore it.

Rob
