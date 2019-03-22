Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAC6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46278218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfCVRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:36:59 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:47344 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfCVRg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:36:58 -0400
Received: from alans-desktop (82-70-14-226.dsl.in-addr.zen.co.uk [82.70.14.226])
        by fuzix.org (8.15.2/8.15.2) with ESMTP id x2MHah0U025492;
        Fri, 22 Mar 2019 17:36:44 GMT
Date:   Fri, 22 Mar 2019 17:36:43 +0000
From:   Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        axboe@kernel.dk, b.zolnierkie@samsung.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_oldpiix: Add missing device ID for
 INTEL_82371AB
Message-ID: <20190322173643.75a81d1b@alans-desktop>
In-Reply-To: <20190312133808.GA9336@Red>
References: <1544449564-16557-1-git-send-email-clabbe@baylibre.com>
        <9aab3632-4647-cb66-f720-8f6742bc9b4e@cogentembedded.com>
        <20190312104102.GA28302@Red>
        <20190312120623.46ca7286@alans-desktop>
        <20190312133808.GA9336@Red>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > If the virtual Sparc emulator is using it does that also mean actual
> > Sparc hardware has it. In which case presumably it needs fixing, or at
> > least moving to the generic driver assuming the firmware sets it up ?
> >   
> 
> The qemu works perfectly with the new Linux driver.

For some configurations both drivers will work with even older chips. The
question is whether your chip has separate slave timings, if not then
while it'll work single device with ata_piix some combinations will fail.

Digging into the datasheet the part in question has slave timing (0x44) so
should indeed be ata_piix.

Alan

