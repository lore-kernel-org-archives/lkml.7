Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3206C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8877B2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570785076;
	bh=0b+19Hn7UbHkSSxLN4MXTvyEt2kAc48uoFb/JWDbo/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k069CZnr7jbtkpnBlZluEBNCZuN5YmJps9cwnaK1QUrJU1eDkxUj86iAjtelCoBm+
	 wPk+kXo48EwImCPVBlIsiGvsJ+qNrr+TLWs/5pISn0hAGPcWQSxBebYBlNyni3Iki5
	 jSxZztmcOFekjgcNPMRsdtZPcVdQFYPEkKtNrSl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfJKJLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 05:11:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfJKJLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:11:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE5B21D6C;
        Fri, 11 Oct 2019 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570785073;
        bh=0b+19Hn7UbHkSSxLN4MXTvyEt2kAc48uoFb/JWDbo/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocPh3/IRZQVb6NWWmgiy3Ewp0AlBTKWgVUlOD9k5lB1EdxY2kvluEZsmwGLFROwKo
         MK4ylNgMuOO+WVtdy0wLIimkuRJYbSy/adKfmNBJ3iilOZ2IXKLLU9JltHeihqpe1z
         QVufYp25TN4xae0NxTIaWAOUMesGXjxOu5+P9D94=
Date:   Fri, 11 Oct 2019 11:11:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     devel@driverdev.osuosl.org, gneukum1@gmail.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de,
        linux-kernel@vger.kernel.org,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/5] KPC2000: kpc2000_spi.c: Fix style issues (missing
 blank line)
Message-ID: <20191011091110.GA1124173@kroah.com>
References: <20191011055155.4985-1-chandra627@gmail.com>
 <20191011055155.4985-2-chandra627@gmail.com>
 <20191011063321.GB986093@kroah.com>
 <CAEge-i7Va8NrVGYzssFqvuGEwV=xPu9VL5_ZewXn2985QbEmcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEge-i7Va8NrVGYzssFqvuGEwV=xPu9VL5_ZewXn2985QbEmcw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Oct 11, 2019 at 02:02:32AM -0700, Chandra Annamaneni wrote:
> The first set of patches were in a single commit. I started from scratch
> and built these patches from 5 different commits. Don't know if the first
> set of patches are relevant anymore.

They are not relevant to being applied, but this patch series has
changed based on the comments you received from the previous patch(s).
So it is relevant to how you got to this set of patches.

This makes it easier for reviewers to understand what changed and what
they need to focus on, or ignore, in your new set of patches.  This
isn't for you, it is for the people you are sending these patches to.

thanks,

greg k-h
