Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715F1C2D0C3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBCC2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 02:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLaCd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 21:33:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58291 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbfLaCd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 21:33:27 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBV2XE93024338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 21:33:15 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5BEAF420485; Mon, 30 Dec 2019 21:33:14 -0500 (EST)
Date:   Mon, 30 Dec 2019 21:33:14 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: Why is CONFIG_VT forced on?
Message-ID: <20191231023314.GC3669@mit.edu>
References: <9b79fb95-f20c-f299-f568-0ffb60305f04@landley.net>
 <b3cf8faf-ef04-2f55-3ccb-772e18a57d7b@infradead.org>
 <ac0e5b3b-6e70-6ab0-0c7f-43175b73058f@landley.net>
 <e55624fa-7112-1733-8ddd-032b134da737@infradead.org>
 <018540ef-0327-78dc-ea5c-a43318f1f640@landley.net>
 <774dfe49-61a0-0144-42b7-c2cbac150687@landley.net>
 <8059d1c4-759d-9911-73c7-211f8576e7f2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8059d1c4-759d-9911-73c7-211f8576e7f2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 06:03:26PM -0800, Randy Dunlap wrote:
> > 
> > So if I disable CONFIG_EXPERT, using miniconfig I then need to manually switch on:
> > 
> > ./init/Kconfig:	bool "Namespaces support" if EXPERT
> > 
> > So nobody noticed you have a structural "this config option actually switches
> > this thing _off_" implemented via magic symbol then?

Perhaps because the right thing happens if you enable CONFIG_EXPERT
using "make menuconfig"?  It also looks like the right thing happens
if you edit the .config and then run "make oldconfig".

Personally, I never use miniconfig, so it's not anything *I* ever
noticed in all of my years of kernel development.  Usually, the way
that I manage configs is "make menuconfig", or editing the .config
directly, or "make savedefconfig" / "make olddefconfig".

Cheers,

					- Ted
