Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D928B206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCLMGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:06:39 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:52206 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLMGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:06:39 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x2CC6OhC029385;
        Tue, 12 Mar 2019 12:06:24 GMT
Date:   Tue, 12 Mar 2019 12:06:23 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        axboe@kernel.dk, b.zolnierkie@samsung.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Message-ID: <20190312120623.46ca7286@alans-desktop>
In-Reply-To: <20190312104102.GA28302@Red>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
        <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
        <20190312104102.GA28302@Red>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 11:41:02 +0100
LABBE Corentin <clabbe@baylibre.com> wrote:

> On Mon, Dec 10, 2018 at 05:52:35PM +0300, Sergei Shtylyov wrote:
> > Hello!
> > 
> > On 12/10/2018 04:46 PM, Corentin Labbe wrote:
> >   
> > > When playing with a virtual SPARC machine with qemu, I found that the
> > > IDE emulated device was not probing with the ata/pata_oldpiix driver.  
> > 
> >    Correctly, it should probe with ata_piix,
> >   
> > > But with the old ide/piix, it was probed.> 
> > > This is due to this PCI devid was not migrated from the old ide/piix.  
> > 
> >    It wasn't on purpose -- the IDE driver supports the original PIIX
> > incorrectly.
> >   
> 
> Hello
> 
> What about removing this old driver totally if it dont work ?

If the virtual Sparc emulator is using it does that also mean actual
Sparc hardware has it. In which case presumably it needs fixing, or at
least moving to the generic driver assuming the firmware sets it up ?

Alan
