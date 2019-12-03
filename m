Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD28FC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44F20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575363917;
	bh=kH7M6raCYcwzp14cZpiS1nz6oSFsgOSES0lH2kUYIbc=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=xRkOKaxfjZDIk2EcuE/ROcVZZddtRQlJX4kn0FrZaxL7gCQQ949hgItK9PI0knqof
	 y9i1WiRGw1W23QCfIsz3UG2lOU8YnrNHaQ4mRU45DtIW4O0Cykd9v5iw/kphhFbCKL
	 ygWHS2EvXaxhuH5cSMcdIL837ZwZds4+Qlm6saz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfLCJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:05:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCJFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:05:16 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A03B20661;
        Tue,  3 Dec 2019 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575363916;
        bh=kH7M6raCYcwzp14cZpiS1nz6oSFsgOSES0lH2kUYIbc=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=yLaYHkcUYhTB5dMIAfawF2MIKjgR0iQV5k/t02Uqmww2lc3bYrZ8x9inAWCS1P992
         WdKqbojHyVHi4XPlP2AW8T/2cn3wL6HH8O6DHJoT+lFo4a2PfPRs9iPUU3+QKHW+yW
         iG9RTsU9ljzDwfGw1299K8sp4Z4X6W5QK08FK+bM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jv9r27kzn.fsf@starbuckisacylon.baylibre.com>
References: <20190924123954.31561-1-jbrunet@baylibre.com> <1jv9r27kzn.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH 0/3] clk: let clock perform allocation in init
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 03 Dec 2019 01:05:15 -0800
Message-Id: <20191203090516.1A03B20661@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-11-29 07:36:28)
>=20
> On Tue 24 Sep 2019 at 14:39, Jerome Brunet <jbrunet@baylibre.com> wrote:
>=20
> > This patchset is a follow up on this pinky swear [0].
> > Its purpose is:
> >  * Clarify the acceptable use of clk_ops init() callback
> >  * Let the init() callback return an error code in case anything
> >    fail.
> >  * Add the terminate() counter part of of init() to release the
> >    resources which may have been claimed in init()
> >
> > After discussing with Stephen at LPC, I decided to drop the 2 last patc=
hes
> > of the RFC [1]. I can live without it for now and nobody expressed a
> > critical need to get the proposed placeholder.
> >
> > [0]: https://lkml.kernel.org/r/CAEG3pNB-143Pr_xCTPj=3DtURhpiTiJqi61xfDG=
DVdU7zG5H-2tA@mail.gmail.com
> > [1]: https://lkml.kernel.org/r/20190828102012.4493-1-jbrunet@baylibre.c=
om
> >
>=20
> Hi Stephen,
>=20
> Do you think we can fit this into the incoming cycle ?
>=20

Sorry I missed this one. I'll apply it soon but won't be for this merge
window.

