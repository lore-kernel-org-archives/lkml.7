Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF9AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3130208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560786927;
	bh=1b47WlW4PR2yZnyMSoLvFrpGsLhOodFKbTIZ5AcebYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jZ7OJYrGua+76gtVJPxsQHpvs5xuNKfiT4HRUs/5PdD69ov4j/rMJauIXvHXMo7rq
	 UgIT1k6UEypJJYte/JunrxjCYwTVTv1mfOtZbORmCv3fxZSi9C5Z71QOr1oZmbvbzx
	 EK7eyoSjg+Y13wf6cc9c/tIR0fw/BA4pnXS1mWNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfFQPz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:55:26 -0400
Received: from casper.infradead.org ([85.118.1.10]:38560 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+/5VA9ZuoXyLrG+BiiWydDZ/+oR7o3Vk3uSSQIEd16c=; b=gWNa6GaJ/p3/9QeUuIX0nsaxYa
        2iVR/TxaDorIbG/lixhBnGTv/K/F8h/jNdQCRwn4NZpx55gNWejwIH9c7mghw2wHU3PEF6RMSVVTu
        3jZSO6RQEurFZ/xoFL5QtSAzIA3CU1wYqyeBwatTPpNELSZOMYdeLcXNM2T7cLRcnqrxjIXVfjV9u
        zO9KhUOkc32z7SPrBr7C9s/db4SLpfTyTOZkbgDp3R4iAi1JyugKBzaEwuLvL7ShOLTn0wooZ6FZ4
        27otCZgKtA/D4/MwEjKdAlIaQS82//4REyeHJTueyzawe8KUFOmzeyshx08keOARG1UkgSvNNwtQU
        qw6oNnvg==;
Received: from 179.186.105.91.dynamic.adsl.gvt.net.br ([179.186.105.91] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hctyd-0000g2-26; Mon, 17 Jun 2019 15:55:23 +0000
Date:   Mon, 17 Jun 2019 12:55:17 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Markus Heiser <markus.heiser@darmarit.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] docs: sphinx/kernel_abi.py: fix UTF-8 support
Message-ID: <20190617125517.293fd50f@coco.lan>
In-Reply-To: <20190617075608.696cf037@lwn.net>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
        <62c8ffe86df40c90299e80619a1cb5d50971c2c6.1560477540.git.mchehab+samsung@kernel.org>
        <20190614161837.GA25206@kroah.com>
        <20190614132530.7a013757@coco.lan>
        <28aca947-4e88-7186-7f07-9a3ccb379649@darmarit.de>
        <20190617061659.22596fc3@coco.lan>
        <20190617075608.696cf037@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 17 Jun 2019 07:56:08 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Mon, 17 Jun 2019 06:16:59 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
>=20
> > > No need to change, the emacs notation is also OK, see your link
> > >=20
> > >    """or (using formats recognized by popular editors):"""
> > >=20
> > >    https://www.python.org/dev/peps/pep-0263/#defining-the-encoding
> > >=20
> > > I prefer emacs notation, this is also evaluated by many other editors=
 / tools.   =20
> >=20
> > The usage of emacs notation is something that we don't like at the
> > Linux Kernel. With ~4K developers per release, if we add tags to
> > every single editor people use, it would be really messy, as one
> > developer would be adding a tag and the next one replacing it by its
> > some other favorite editor's tag. =20
>=20
> So "we" like a language-specific notation instead?  That seems a little
> strange to me.  Lots of things understand the Emacs notation, it doesn't
> seem like something that needs to be actively avoided here.

=46rom my side, I don't have any strong preference. Just saying that
people usually complain when e-macs or vim specific tags appear at the
Kernel. That's why I would prefer an editor-agnostic macro.

It won't make any difference for me, anyway, as the editors I use
don't recognize it.

Whatever you want is OK to me, provided that we use the same notation on
all Sphinx extensions... right now there's a mix of notations.

Thanks,
Mauro
