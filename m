Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA72C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21FE217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556174308;
	bh=5rOr5h9iHbANIyhqHKrjoRofbIurrbSYMOWJ1ioQ0yE=;
	h=In-Reply-To:References:Cc:From:Subject:To:Date:List-ID:From;
	b=qUVSiNFvLAAvALNp0M7LKKNgOjj5a5btL2GBaRdl+lyby/D+BtbgqDLu/2exeO8/7
	 mxrQlkH6RQl7S/Bf3KVvm8AEn7M3RRRRykulRoSJya4rULMpfohqMRMk1NYAFLRsa4
	 uV6wUCSqEx3WcWQ9z2eqijOOVf0WWnXDGiV289qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfDYGi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729765AbfDYGiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:38:25 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB64217D7;
        Thu, 25 Apr 2019 06:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556174304;
        bh=5rOr5h9iHbANIyhqHKrjoRofbIurrbSYMOWJ1ioQ0yE=;
        h=In-Reply-To:References:Cc:From:Subject:To:Date:From;
        b=PI6SrsZQ71Mn0dhAQNizFZkvABjxAh7nh9RHGeZCkwhQGd0m+YmHHtE1RF6mDeHP3
         S8F+ywjP+sSfxLzokFFQl9YHxrz/sPQef+oGauAisdjM1taX8lzONa1OlIJnHsebz6
         T0AN+VVQzKK34CbahEhwxj6N8VztWmVJp7wkOkSg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190424072726.0e1318bf@canb.auug.org.au>
References: <20190424072726.0e1318bf@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the clk tree
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <155617430338.15276.16102392882212735866@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Wed, 24 Apr 2019 23:38:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Rothwell (2019-04-23 14:27:26)
> Hi all,
>=20
> Commit
>=20
>   1a80c922c718 ("fixup! clk: divider: add explicit big endian support")
>=20
> is missing a Signed-off-by from its author and committer.
>=20

It will be squashed later while reintegrating the branches. So there's
nothing to see here...

