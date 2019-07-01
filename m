Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D6BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649092146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfGAKKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:10:52 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:57099 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfGAKKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:10:52 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id A25142000E;
        Mon,  1 Jul 2019 10:10:49 +0000 (UTC)
Message-ID: <25207fcb87900100fc00da17b2515fde79ecfb1e.camel@hadess.net>
Subject: Re: [PATCH v3] HID: sb0540: add support for Creative SB0540 IR
 receivers
From:   Bastien Nocera <hadess@hadess.net>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Bastien Nocera <bnocera@redhat.com>
Date:   Mon, 01 Jul 2019 12:10:47 +0200
In-Reply-To: <CAO-hwJJDf68gqgJZHQtAdjZcEzuL+LbOJD=OYHtod1xN6G+GjA@mail.gmail.com>
References: <20190626140618.8944-1-hadess@hadess.net>
         <CAO-hwJJDf68gqgJZHQtAdjZcEzuL+LbOJD=OYHtod1xN6G+GjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 (3.32.3-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-01 at 11:45 +0200, Benjamin Tissoires wrote:
> Hi Bastien,
> 
> On Wed, Jun 26, 2019 at 4:07 PM Bastien Nocera <hadess@hadess.net>
> wrote:
> > From: Bastien Nocera <bnocera@redhat.com>
> > 
> > Add a new hid driver for the Creative SB0540 IR receiver. This
> > receiver
> > is usually coupled with an RM-1500 or an RM-1800 remote control.
> > 
> > The scrollwheels on the RM-1800 remote are not bound, as they are
> > labelled for specific audio controls that don't usually exist on
> > most
> > systems. They can be remapped using standard Linux keyboard
> > remapping tools.
> 
> Much better commit message :)
> Thanks!
> 
> I have a few nitpicks however

Most of the checkpatch.pl warnings are now fixed. I ignored the one
about writing docs for the symbol (I have no idea what it wants, looks
like a false positive) and the too long line for the USB device match.

<snip>
> > +       /* force input as some remotes bypass the input
> > registration */
> > +       hid->quirks |= HID_QUIRK_HIDINPUT_FORCE;
> 
> Does this still applies to your remote?

Yes, you mentioned it in your original review as well, and it was
necessary.

v4's been sent.

Thanks!

